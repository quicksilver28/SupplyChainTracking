pragma solidity >=0.6.0;

contract SupplyChain {
    
    //event Added(uint256 index);
    
    struct State{
        string currentloc;
        string currentdate;
        address entity;
    }
    
    struct Product{
        address creator;
        string productName;
        uint256 productId;
        string createdDate;
        uint256 totalStates;
        mapping (uint256 => State) intermediaries;
    }
    
    mapping(uint256 => Product) allProducts;
    uint256 public items = 0;

    function concat(string memory _a, string memory _b) public pure returns (string memory){
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }
    
    function addProduct(string memory _text, string memory _date) public returns (bool) {
        Product memory _newItem = Product({creator: msg.sender, totalStates: 0,productName: _text, productId: items, createdDate: _date});
        allProducts[items] = _newItem;
        items = items+1;
        //emit Added(items-1);
        return true;
    }
    
    function addState(uint _productId, string memory _cdate, string memory _cloc) public returns (string memory) {
        require(_productId <= items, "Invalid product id");
        State memory newState = State({entity: msg.sender, currentdate: _cdate, currentloc: _cloc});
        allProducts[_productId].intermediaries[allProducts[_productId].totalStates] = newState;
        allProducts[_productId].totalStates = allProducts[_productId].totalStates + 1;
        return _cloc;
    }
    function searchProduct(uint _productId) public view returns (string memory) {
        require(_productId<=items, "Invalid product id");
        string memory output = "Product Name: ";
        output = concat(output, allProducts[_productId].productName);
        output = concat(output, "; Manufacture Date: ");
        output = concat(output, allProducts[_productId].createdDate);
        for (uint256 j = 0; j<allProducts[_productId].totalStates; j++){
            output = concat(output, "; Current Date: ");
            output = concat(output, allProducts[_productId].intermediaries[j].currentdate);
            output = concat(output, "; Current Location:");
            output = concat(output, allProducts[_productId].intermediaries[j].currentloc);
        }
        return output;
    }

}