const ethers = require("ethers");
const abi = require("./abi.json");
require("dotenv").config();

let providerUrl = process.env.URL;
let contractAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
const main = async () => {
  //declare provider
  //connect provider
  //send request
  //get request

  const provider = new ethers.providers.JsonRpcProvider(providerUrl);
  const USDT = new ethers.Contract(contractAddress, abi, provider);

  try {
    //you can use js .then to catch your request or use asynchronous method---as shown below
    //const usdt = USDT.name().then((data) => console.log(data));
    const usdt = await USDT.name();
    //USDT symbol
    const usdtSymbol = await USDT.symbol();

    const usdtDecimals = await USDT.decimals();

    const usdtTotalSupply = await USDT._totalSupply().catch((err) =>
      console.log("Error:", err)
    );

    //balance of user
    const usdtBalanceOf = await USDT.balanceOf(
      "0xBc1C467CE6CEc60758bbAD241e230aFe76549D89"
    );

    console.log("Token name:", usdt);
    console.log("Token symbol:", usdtSymbol);
    console.log("Token decimals:", usdtDecimals.toNumber());
    console.log("Token total supply:", Number(usdtTotalSupply));
    console.log("Balance of address:", usdtBalanceOf.toString());

    //using Promise.all to return all promise results at once..
    console.log(
      "=====================using Promise.all========================"
    );
    console.log(
      "=============================================================="
    );
    await Promise.all([
      usdt,
      usdtSymbol,
      usdtDecimals,
      usdtTotalSupply,
      usdtBalanceOf,
    ]).then((values) => console.log(values.toString()));
    //NOTE: YOU CAN ALSO DESTRUCTURE YOUR RESPONSE
    /* [RESPONSE1,RESPONSE2, RESPONSE3, RESPONSE4, RESPONSE5] = 
  await Promise.all([
      usdt,
      usdtSymbol,
      usdtDecimals,
      usdtTotalSupply,
      usdtBalanceOf,
    ]);
    console.log(RESPONSE1, RESPONSE2...etc)
    //this should work
    */
  } catch (error) {
    console.log(error);
  } finally {
    console.log("promise resolved and exited");
  }
};

main();
