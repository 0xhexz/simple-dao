async function main() {
  const [owner, member1, member2] = await ethers.getSigners();

  const DAO = await ethers.getContractFactory("SimpleDAO");
  const dao = await DAO.deploy([owner.address, member1.address, member2.address]);

  await dao.deployed();
  console.log("SimpleDAO deployed at:", dao.address);
}

main().catch(console.error);
