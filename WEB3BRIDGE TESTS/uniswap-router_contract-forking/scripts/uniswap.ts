import { ethers } from "hardhat";

async function main() {
    //interact with uniswap swapTokenforExactToken function
    //swap usdt to dai
    //TO-DO
    //erc20 token interface
    //Approve the uniswap contract
    //check balance of signer before swap
    //swap token caling the function
    //check balance after swap.

    const USDTAddress = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
    const DAIAddress = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
    const UNIRouter = "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D";
    const amountOut = 3e6;
    const amountIn = 2e6;

    const helpers = require("@nomicfoundation/hardhat-network-helpers");
    const USDTHolder = "0xf584f8728b874a6a5c7a8d4d387c9aae9172d621";
    await helpers.impersonateAccount(USDTHolder);
    const impersonatedSigner = await ethers.getSigner(USDTHolder);

    const USDC = await ethers.getContractAt(
        "IERC20",
        USDTAddress,
        impersonatedSigner
    );
    const DAI = await ethers.getContractAt("IERC20", DAIAddress);
    const ROUTER = await ethers.getContractAt(
        "IUniswap",
        UNIRouter,
        impersonatedSigner
    );
    await USDC.approve(UNIRouter, amountOut);
    const usdcBal = await USDC.balanceOf(impersonatedSigner.address);
    const daiBal = await DAI.balanceOf(impersonatedSigner.address);

    console.log("balance after swap:", "USDC:", usdcBal.toString(), "DAI:", daiBal.toString());

    console.log("==========================================");
    console.log("==========================================");
    console.log("Swapping Tokens");

    console.log("==========================================");
    console.log("==========================================");

    await ROUTER.swapTokensForExactTokens(
        amountOut,
        amountIn,
        [USDTAddress, DAIAddress],
        USDTHolder,
        1960674129
    );
    console.log("Swapped Tokens");

    console.log("==========================================");
    console.log("==========================================");


    const usdtBalAfter = await USDC.balanceOf(impersonatedSigner.address);
    const daiBalAfter = await DAI.balanceOf(impersonatedSigner.address);

    console.log("balance after swap:", "USDC:", usdtBalAfter.toString(), "DAI:", daiBalAfter.toString());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});