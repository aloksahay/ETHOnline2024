import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "viem";

const TShirtNFTModule = buildModule("TShirtNFTModule", (m) => {
  const tshirt = m.contract("TShirtNFT", [], {});
  return { tshirt };
});

export default TShirtNFTModule;
