const ERC20Proxy = artifacts.require("ERC20Proxy");

module.exports = function(deployer) {
    deployer.deploy(ERC20Proxy);
};
