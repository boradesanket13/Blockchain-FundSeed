
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const config = {
  solidity: "0.8.19",
  networks: {}
};

if (process.env.PROJECT_ID && process.env.ACCOUNT_PRIVATE_KEY) {
  config.networks.sepolia = {
    url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.PROJECT_ID}`,
    chainId: 11155111,
    accounts: [`0x${process.env.ACCOUNT_PRIVATE_KEY.replace(/^0x/, "")}`]
  };
}

module.exports = config;
