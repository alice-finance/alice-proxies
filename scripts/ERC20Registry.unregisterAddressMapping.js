const ERC20Registry = artifacts.require("ERC20Registry");
const readline = require("readline-sync");

module.exports = async function (callback) {
    try {
        let localAddress = readline.question("Local address: ");

        const registry = await ERC20Registry.deployed();
        console.log(await registry.unregisterAddressMapping(localAddress));
        callback();
    } catch (e) {
        callback(e);
    }
};
