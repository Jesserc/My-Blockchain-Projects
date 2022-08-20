
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.9",

  networks: {
    hardhat: {
      forking: {
        url: process.env.RI_URL!,
      },
    },
    rinkeby: {
      url: process.env.RI_URL,
      //@ts-ignore
      accounts: [process.env.KEY],
    },
  },
};

export default config;