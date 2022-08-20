import { ethers } from "hardhat";

async function main() {
  //Proposal contract deployed to address: 0xa0f89Ba6a989F4F790548d0EfA901135E6145d83

  const maxAmountToAcceptProposal = 3;
  const PROPOSAL = await ethers.getContractFactory("ProposalContract");
  const proposal = await PROPOSAL.deploy(maxAmountToAcceptProposal);

  await proposal.deployed();

  console.log("Proposal contract deployed to address:", proposal.address);
}



main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
