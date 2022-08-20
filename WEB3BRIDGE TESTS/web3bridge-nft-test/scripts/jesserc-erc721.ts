import { ethers } from "hardhat";

async function main() {
  //contract address = 0xE5a9f5Ec2A132cEeB59E3c921f1afD433F2E8433
  //opensea link = https://testnets.opensea.io/assets/rinkeby/0xe5a9f5ec2a132ceeb59e3c921f1afd433f2e8433/0
  const NFT = await ethers.getContractFactory("Jesserc");
  const nft = await NFT.deploy();

  await nft.deployed();

  console.log("Jesserc ERC721 token deployed to", nft.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
