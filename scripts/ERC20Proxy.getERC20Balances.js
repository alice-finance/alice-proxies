const ERC20Proxy = artifacts.require("ERC20Proxy");
const readline = require("readline-sync");

module.exports = async function (callback) {
    try {
        let count = readline.question("Number of addresses: ");
        const addresses = [];
        for (let i = 0; i < count; i++) {
            addresses.push(readline.question("Address #" + (i + 1) + ": "))
        }

        const proxy = await ERC20Proxy.deployed();
        console.log(await proxy.getERC20Balances(addresses));
        callback();
    } catch (e) {
        callback(e);
    }
};
