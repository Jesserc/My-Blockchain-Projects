import { ethers } from "hardhat";

async function main() {
    //Contract Address= 0xA69fce9eD668150710F4b6CE3D4A9Ad6ecc9758A -goerli testnet
    //Verified contract link - https://goerli.etherscan.io/address/0xA69fce9eD668150710F4b6CE3D4A9Ad6ecc9758A#writeContract


    const Vault = await ethers.getContractFactory("Vault");
    const vault = await Vault.deploy();

    await vault.deployed();

    console.log("Vault contract deployed to:", vault.address);

    // const [signer, signer2] = await ethers.getSigners();

    const grantAmount = { value: ethers.utils.parseEther("0.0005") };
    const createGrant = await vault.createGrant("0x571B102323C3b8B8Afb30619Ac1d36d85359fb84", 30, grantAmount);
    if (createGrant) {
        console.log("Grant Created");
    }

}



// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
