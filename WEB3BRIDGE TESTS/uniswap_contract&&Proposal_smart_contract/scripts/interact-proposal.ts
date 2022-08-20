import { ethers } from "hardhat";

async function main() {

    const proposalAddress = "0xa0f89Ba6a989F4F790548d0EfA901135E6145d83";
    const proposal = await ethers.getContractAt("IPropsal", proposalAddress);
    const deadline = 30;
    await proposal.createProposal("Web3bridge", deadline);
    //tx hash = 0xecc7bfbb4dc31251d9a4b8d85f90f470d74c6b62544541e6d8d57ee605cfa701

    await proposal.returnProposal(2);
    //tx hash = 0xdf981e95b582f74fdc9e42c2e7a1dc1210c2c71379ff577aa7e4f737529544c8
}



main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
