pragma solidity >=0.5.0 <0.6.0;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "./ERC20Registry.sol";


contract ERC20Proxy {
    function getERC20Balances(address[] memory addresses) public view returns (uint256[] memory) {
        uint256[] memory balances = new uint256[](addresses.length);
        for (uint i = 0; i < addresses.length; i++) {
            address addr = addresses[i];
            if (addr == address(0)) {
                balances[i] = address(msg.sender).balance;
            } else {
                ERC20Detailed erc20 = ERC20Detailed(addr);
                balances[i] = erc20.balanceOf(msg.sender);
            }
        }
        return balances;
    }
}
