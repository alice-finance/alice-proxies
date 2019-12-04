const ERC20Registry = artifacts.require("ERC20Registry");
const readline = require("readline-sync");

module.exports = async function (callback) {
    try {
        let ethAddress = readline.question("Eth address: ");
        let localAddress = readline.question("Local address: ");
        let name = readline.question("Name: ");
        let symbol = readline.question("Symbol: ");
        let decimals = readline.question("Decimals: ", {type: "number", default: 18});

        const registry = await ERC20Registry.deployed();
        console.log(await registry.register(ethAddress, localAddress, name, symbol, decimals));
        callback();
    } catch (e) {
        callback(e);
    }
};
