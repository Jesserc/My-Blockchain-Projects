import { ethers } from "hardhat";

async function main() {
    const myAddr = "0x4924Fb92285Cb10BC440E6fb4A53c2B94f2930c5";
    const ipfsMetadataCid = "ipfs://QmXQoTCA75ZJW2BfvvzCGK3jk6MN7ACiRLBzd76CZjYVAP";
    //contract address = 0xE5a9f5Ec2A132cEeB59E3c921f1afD433F2E8433
    //opensea link = https://testnets.opensea.io/assets/rinkeby/0xe5a9f5ec2a132ceeb59e3c921f1afd433f2e8433/0
    const contract = "0xE5a9f5Ec2A132cEeB59E3c921f1afD433F2E8433";
    const NFT = await ethers.getContractAt("IJesserc", contract);

    console.log("===================================");
    console.log("===================================");

    console.log("Jesserc ERC721 token deployed to", NFT.address);

    await NFT.safeMint(myAddr, ipfsMetadataCid);

    console.log("===================================");
    console.log("===================================");


    console.log("===================================");
    console.log("===================================");

    console.log("Checking Balance....");

    const balanceOF = await NFT.balanceOf(myAddr);
    console.log(balanceOF);



    console.log("===================================");
    console.log("===================================");

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
