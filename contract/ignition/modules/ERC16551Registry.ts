import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "viem";

const ERC16551RegistryModule = buildModule("ERC16551RegistryModule", (m) => {
  const registry = m.contract("ERC6551Registry", [], {});
  return { registry };
});

export default ERC16551RegistryModule;
