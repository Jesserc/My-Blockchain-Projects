import { ethers } from "hardhat";

async function main() {
    //interact with uniswap swapTokenforExactToken function
    //swap aave to dai
    //TO-DO
    //erc20 token interface
    //Approve the uniswap contract
    //check balance of signer before swap
    //swap token caling the function
    //check balance after swap.

    const AaveAddress = "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9";
    const DAIAddress = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
    const UniswapV2Router = "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D";


    //amounts to be used in swapping aave token to dai
    const amountOutMin = 1e6;
    const amountIn = 2e6;

    //amounts to be used in adding liquidity btw aave and dai
    const amountADesired = 100;
    const amountBDesired = 100;
    const amountAMin = 1;
    const amountBMin = 1;
    const epochTimeDecember = 1671382167000;
    //im
    const helpers = require("@nomicfoundation/hardhat-network-helpers");
    const TokenHolder = "0xf584f8728b874a6a5c7a8d4d387c9aae9172d621";
    await helpers.impersonateAccount(TokenHolder);
    const impersonatedSigner = await ethers.getSigner(TokenHolder);


    //aave contract initialization
    const Aave = await ethers.getContractAt(
        "IERC20",
        AaveAddress,
        impersonatedSigner
    );


    //dai contract initialization
    const DAI = await ethers.getContractAt("IERC20", DAIAddress);

    //uniswap router initialization
    const ROUTER = await ethers.getContractAt(
        "IUniswapV2Router02",
        UniswapV2Router,
        impersonatedSigner
    );

    //approving uniswap router contract to transfer and swap our token
    // await Aave.approve(UniswapV2Router, amountIn);

    await Aave.approve(UniswapV2Router, "99981199999990000000");
    await DAI.approve(UniswapV2Router, "2144000000001027479345");

    //checking balances
    const aaveBal = await Aave.balanceOf(impersonatedSigner.address);
    const daiBal = await DAI.balanceOf(impersonatedSigner.address);

    console.log("balance after swap:", "Aave:", aaveBal.toString(), "DAI:", daiBal.toString());

    console.log("==========================================");
    console.log("==========================================");
    console.log("Swapping Tokens");

    console.log("==========================================");
    console.log("==========================================");

    await ROUTER.swapExactTokensForTokens(
        amountIn,
        amountOutMin,
        [AaveAddress, DAIAddress],
        TokenHolder,
        1960674129
    );
    console.log("Swapped Tokens");

    console.log("==========================================");
    console.log("==========================================");


    const aaveBalAfter = await Aave.balanceOf(impersonatedSigner.address);
    const daiBalAfter = await DAI.balanceOf(impersonatedSigner.address);

    console.log("balance after swap:", "Aave:", aaveBalAfter.toString(), "DAI:", daiBalAfter.toString());



    const AddLiquidity = await ROUTER.addLiquidity(
        AaveAddress,
        DAIAddress,
        amountADesired,
        amountBDesired,
        amountAMin,
        amountBMin,
        TokenHolder,
        epochTimeDecember,
        { gasLimit: ethers.utils.hexlify(1000000) }
    );

    console.log(AddLiquidity);





}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});