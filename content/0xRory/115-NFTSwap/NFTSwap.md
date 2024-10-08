### 38. NFT交易所

利用智能合約建立 0 手續費的 NFT 交易所。

#### 設計邏輯
- 賣家：出售NFT的一方，可以掛單list、撤單revoke、修改價格update。
- 買家：購買NFT的一方，可以購買purchase。
- 訂單：賣家發布的NFT鏈上訂單，一個系列的同一tokenId最多存在一個訂單，其中包含掛單價格price和持有人owner資訊。當一個訂單交易完成或被撤單後，其中資訊清除。

#### NFTSwap 合約

  - 四個事件
  ```solidity

      event List(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 price); //掛單
      event Purchase(address indexed buyer, address indexed nftAddr, uint256 indexed tokenId, uint256 price); //購買
      event Revoke(address indexed seller, address indexed nftAddr, uint256 indexed tokenId); //撤單
      event Update(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 newPrice); //修改價格
  ```

- 還要抽像一下 order 結構

    包含掛單價格price和持有人owner資訊。

    nftList映射記錄了訂單是對應的NFT系列（合約地址）和tokenId資訊。
  ```
    // 定义order结构体
    struct Order{
        address owner;
        uint256 price; 
    }
    // NFT Order映射
    mapping(address => mapping(uint256 => Order)) public nftList;
  ```
- 在NFTSwap中，用戶使用ETH購買NFT。因此，合約需要實作fallback()函數來接收ETH。
```
    fallback() external payable{}
```
ERC721的安全轉帳函數會檢查接收合約是否實作了onERC721Received()函數，並傳回正確的選擇器selector。用戶下單之後，需要將NFT發送給NFTSwap合約。因此NFTSwap繼承IERC721Receiver接口，並實作onERC721Received()函數：

```
contract NFTSwap is IERC721Receiver{

    // 实现{IERC721Receiver}的onERC721Received，能够接收ERC721代币
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external override returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }
```

#### 掛單 List()

賣家建立NFT並建立訂單，並釋放List事件。

- 參數為NFT合約地址_nftAddr，
- NFT對應的_tokenId，掛單價格_price（注意：單位是wei）。
- 成功後，NFT會從賣家轉到NFTSwap合約中。


```
    // 挂单: 卖家上架NFT，合约地址为_nftAddr，tokenId为_tokenId，价格_price为以太坊（单位是wei）
    function list(address _nftAddr, uint256 _tokenId, uint256 _price) public{
        IERC721 _nft = IERC721(_nftAddr); // 声明IERC721接口合约变量
        require(_nft.getApproved(_tokenId) == address(this), "Need Approval"); // 合约得到授权
        require(_price > 0); // 价格大于0

        Order storage _order = nftList[_nftAddr][_tokenId]; //设置NF持有人和价格
        _order.owner = msg.sender;
        _order.price = _price;
        // 将NFT转账到合约
        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);

        // 释放List事件
        emit List(msg.sender, _nftAddr, _tokenId, _price);
    }
```

#### 撤單 Revoke()

賣家撤回掛單，釋放Revoke事件。

- 參數為NFT合約地址_nftAddr，NFT對應的_tokenId。
- 成功後，NFT會從NFTSwap合約轉回賣家。

```
    // 撤单： 卖家取消挂单
    function revoke(address _nftAddr, uint256 _tokenId) public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.owner == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中
        
        // 将NFT转给卖家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        delete nftList[_nftAddr][_tokenId]; // 删除order
      
        // 释放Revoke事件
        emit Revoke(msg.sender, _nftAddr, _tokenId);
    }
```

#### 調整價格 Update()

賣家修改NFT訂單價格，並釋放Update事件。

- 參數為NFT合約地址_nftAddr，NFT對應的_tokenId，
- 更新後的掛單價格_newPrice（注意：單位是wei）。

```
    // 调整价格: 卖家调整挂单价格
    function update(address _nftAddr, uint256 _tokenId, uint256 _newPrice) public {
        require(_newPrice > 0, "Invalid Price"); // NFT价格大于0
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order
        require(_order.owner == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中
        
        // 调整NFT价格
        _order.price = _newPrice;
      
        // 释放Update事件
        emit Update(msg.sender, _nftAddr, _tokenId, _newPrice);
    }
```

#### 購買 Purchase()

買家支付ETH購買掛單的NFT，並釋放Purchase事件。

- 參數為NFT合約地址_nftAddr，NFT對應的_tokenId。
- 成功後，ETH將轉給賣家，NFT將從NFTSwap合約轉給買家。

```
    // 购买: 买家购买NFT，合约为_nftAddr，tokenId为_tokenId，调用函数时要附带ETH
    function purchase(address _nftAddr, uint256 _tokenId) payable public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.price > 0, "Invalid Price"); // NFT价格大于0
        require(msg.value >= _order.price, "Increase price"); // 购买价格大于标价
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中

        // 将NFT转给买家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // 将ETH转给卖家，多余ETH给买家退款
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).transfer(msg.value-_order.price);

        delete nftList[_nftAddr][_tokenId]; // 删除order

        // 释放Purchase事件
        emit Purchase(msg.sender, _nftAddr, _tokenId, _order.price);
    }
```

***
- 會一直看到 `IERC721(_nftAddr);` 這樣的寫法出現，其實是因為我們目前執行的合約是 NFTSwap 合約，而 NFTSwap 合約並不知道 ERC721 合約的內容，所以我們需要告訴他，這個合約是 ERC721 合約，這樣才能夠正確的操作 ERC721 合約的內容。

- 然後會發現 `_tokenId` 也是至關重要的變數，因為這個變數是用來標記 NFT 的唯一性，所以在這個合約中，我們會一直使用 `_tokenId` 來標記 NFT 的唯一性。

- 所以在利用 NFTSwap 合約的 NFTList 內放上 `_tokenId` 以做為標記。

- 每個操作都會詢問你一次，然後每個都會消耗 gass fee ，和我們平常寫資料庫的購物車有天壤之別的差異。

