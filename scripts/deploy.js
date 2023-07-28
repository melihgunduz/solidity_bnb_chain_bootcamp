
const hre = require("hardhat");

async function main() {

  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Balance:", (await deployer.getBalance()).toString());

  const bank = await hre.ethers.getContractFactory("Limiter");
  const bankContract = await bank.deploy();

  await bankContract.deployed();

  console.log("Bank deployed to:", bankContract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
