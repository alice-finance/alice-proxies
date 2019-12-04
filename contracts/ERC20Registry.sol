pragma solidity >=0.5.0 <0.6.0;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract ERC20Registry is Ownable {
    struct ERC20Token {
        bool registered;
        string name;
        string symbol;
        uint8 decimals;
        address ethAddress;
        address localAddress;
    }

    event TokenRegistered(uint256 id, address ethAddress, string name);
    event TokenUnregistered(uint256 id, address ethAddress, string name);

    ERC20Token[] private tokens;
    mapping(address => uint256) private ethId;
    mapping(address => uint256) private localId;

    function register(address ethAddress, address localAddress, string memory name, string memory symbol, uint8 decimals) public onlyOwner returns (bool) {
        uint256 id = tokens.length;
        tokens.length += 1;

        tokens[id].registered = true;
        tokens[id].name = name;
        tokens[id].symbol = symbol;
        tokens[id].decimals = decimals;
        tokens[id].ethAddress = ethAddress;
        tokens[id].localAddress = localAddress;

        localId[localAddress] = id;
        ethId[ethAddress] = id;

        emit TokenRegistered(id, ethAddress, name);
        return true;
    }

    function unregister(uint256 id) public onlyOwner {
        require(tokens.length > 0);
        require(tokens[id].registered == true);

        emit TokenUnregistered(id, tokens[id].ethAddress, tokens[id].name);

        delete ethId[tokens[id].ethAddress];
        delete localId[tokens[id].localAddress];

        tokens[id] = tokens[tokens.length - 1];

        if (tokens.length > 0) {
            ethId[tokens[id].ethAddress] = id;
            localId[tokens[id].localAddress] = id;
        }
    }

    function getRegisteredTokens() public view returns (ERC20Token[] memory) {
        return tokens;
    }

    function getToken(uint256 id) public view returns (ERC20Token memory) {
        return tokens[id];
    }
}
