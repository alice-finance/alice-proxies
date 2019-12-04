const ERC20Registry = artifacts.require("ERC20Registry");

module.exports = function(deployer) {
    deployer.deploy(ERC20Registry);
};
