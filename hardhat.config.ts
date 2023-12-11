import { HardhatUserConfig } from "hardhat/types";
import "@typechain/hardhat";
import dotenv from 'dotenv'

require("@nomicfoundation/hardhat-toolbox");

const SEI_PRIVATE_KEY="0x03a01f808bf1a1421ee59ff0e476ed07e41c5fa2229af228959f16e22dce8e82"

dotenv.config({ path: '.env.local' })

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{ version: "0.8.1", settings: {} }],
  },
  networks: {
    sei: {
        url: 'http://127.0.0.1:8545',
        accounts: [SEI_PRIVATE_KEY]
      }
  }
};

export default config;