const ERC20Registry = artifacts.require("ERC20Registry");
const readline = require("readline-sync");

module.exports = async function (callback) {
    try {
        let id = readline.question("Token ID: ");

        const registry = await ERC20Registry.deployed();
        console.log(await registry.unregister(id));
        callback();
    } catch (e) {
        callback(e);
    }
};
