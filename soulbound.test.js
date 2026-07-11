const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SoulboundToken Structural Engine", function () {
  let SoulboundToken, sbtContract;
  let owner, userAccount, secondAccount;

  beforeEach(async function () {
    [owner, userAccount, secondAccount] = await ethers.getSigners();
    SoulboundToken = await ethers.getContractFactory("SoulboundToken");
    sbtContract = await SoulboundToken.deploy("IdentityToken", "IDT");
  });

  it("Should properly initialize metadata states", async function () {
    expect(await sbtContract.name()).to.equal("IdentityToken");
    expect(await sbtContract.symbol()).to.equal("IDT");
  });

  it("Should emit Locked event upon minting and prevent transfer actions", async function () {
    await expect(sbtContract.connect(owner).mintSoulbound(userAccount.address))
      .to.emit(sbtContract, "Locked")
      .withArgs(0);

    expect(await sbtContract.locked(0)).to.equal(true);

    await expect(
      sbtContract.connect(userAccount).transferFrom(userAccount.address, secondAccount.address, 0)
    ).to.be.revertedWith("SoulboundToken: Transfer actions are strictly prohibited");
  });
});
