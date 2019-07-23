pragma solidity >=0.5.0 <0.6.0;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";


contract ERC20Registry is Ownable {
    struct ERC20Token {
        string name;
        string symbol;
        uint8 decimals;
        address localAddress;
        address foreignAddress;
    }

    event AddressRegistered(address localAddress, address foreignAddress);
    event AddressUnregistered(address localAddress, address foreignAddress);

    mapping(address => address) private addressMapping;
    address[] private localAddresses;

    function registerAddressMapping(address localAddress, address foreignAddress) public onlyOwner {
        require(addressMapping[localAddress] == address(0), "localAddress already registered");
        addressMapping[localAddress] = foreignAddress;
        localAddresses.push(localAddress);

        emit AddressRegistered(localAddress, foreignAddress);
    }

    function unregisterAddressMapping(address localAddress) public onlyOwner {
        require(addressMapping[localAddress] != address(0), "localAddress not registered");
        address foreignAddress = addressMapping[localAddress];
        delete addressMapping[localAddress];
        for (uint i = 0; i < localAddresses.length; i++) {
            if (localAddresses[i] == localAddress) {
                localAddresses[i] = localAddresses[localAddresses.length - 1];
                localAddresses.length -= 1;
                break;
            }
        }

        emit AddressUnregistered(localAddress, foreignAddress);
    }

    function getRegisteredERC20Tokens() public view returns (ERC20Token[] memory) {
        ERC20Token[] memory tokens = new ERC20Token[](localAddresses.length);
        for (uint i = 0; i < localAddresses.length; i++) {
            address localAddress = localAddresses[i];
            address foreignAddress = addressMapping[localAddress];
            ERC20Detailed erc20 = ERC20Detailed(localAddress);
            tokens[i] = ERC20Token(erc20.name(), erc20.symbol(), erc20.decimals(), localAddress, foreignAddress);
        }
        return tokens;
    }
}
