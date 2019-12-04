const ERC20Registry = artifacts.require("ERC20Registry");

module.exports = async function (callback) {
    try {
        const registry = await ERC20Registry.deployed();
        console.log(await registry.getRegisteredTokens());
        callback();
    } catch (e) {
        callback(e);
    }
};
