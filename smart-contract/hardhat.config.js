
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const config = {
  solidity: "0.8.19",
  networks: {}
};

const projectId = process.env.PROJECT_ID;
const privateKey = process.env.ACCOUNT_PRIVATE_KEY;

if (projectId && privateKey) {
  config.networks.sepolia = {
    url: `https://eth-sepolia.g.alchemy.com/v2/${projectId}`,
    chainId: 11155111,
    accounts: [privateKey.startsWith("0x") ? privateKey : `0x${privateKey}`]
  };
}

module.exports = config;
