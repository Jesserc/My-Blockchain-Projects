require("dotenv").config({ path: ".env" });
import { ethers } from "hardhat";


async function main() {
    
    //creating a wallet instance
    /*    let provider = {
         PrivateKey: process.env.PRIVATE_KEY as BytesLike,
         URL: process.env.URL,
       };
       const provider2 = ethers.getDefaultProvider("ropsten", provider.URL);
     let wallet = new ethers.Wallet(provider.PrivateKey, provider2); 
    */

    const _value = ethers.utils.parseEther("1");
    const CONTRACTADDRESS = "0x6e828b59fc799b6ef92e42d2f39e438a7477f469";
    const MULTISIG = await ethers.getContractAt("Imultisig", CONTRACTADDRESS);
    /*    await wallet.sendTransaction({ to: CONTRACTADDRESS, value: _value });
       console.log();
       console.log("contractBalance", await MULTISIG.contractBalance());
  */

    // array of admin account required for approving ether withdrawal to be impersonated below
    const [address1,
        address2,
        address3,
        address4,
        address5,
        address6,
        address7,
        address8] = ["0x2DBdd859D9551b7d882e9f3801Dbb83b339bFFD7",
            "0x9ee15CF9EC4B3830bBedA501d85F5329Ea3C595C",
            "0x85f20a6924A61904AB44243C7e2c771B3bE46734",
            "0x88538EE7D25d41a0B823A7354Ea0f2F252AD0fAf",
            "0x5D63564EeF4657F360343196A7bd86ae18d3a92A",
            "0x12896191de42EF8388f2892Ab76b9a728189260A",
            "0x924843c0c1105b542c7e637605f95F40FD07b4B0",
            "0xB632cAf3119860599ce162Fad8753fc4198037b4",];


    //impersonating admin accounts with ethers.getImpersonatedSigner method
    const Signer1 = await ethers.getImpersonatedSigner(address1);
    const Signer2 = await ethers.getImpersonatedSigner(address2);
    const Signer3 = await ethers.getImpersonatedSigner(address3);
    const Signer4 = await ethers.getImpersonatedSigner(address4);
    const Signer5 = await ethers.getImpersonatedSigner(address5);
    const Signer6 = await ethers.getImpersonatedSigner(address6);
    const Signer7 = await ethers.getImpersonatedSigner(address7);
    const Signer8 = await ethers.getImpersonatedSigner(address8);


    //get balance of contract
    const contractBalance = await MULTISIG.connect(Signer5).contractBalance();
    console.log("balance of contract before:", contractBalance);
    console.log("=======================================");

    //get balance of signer one
    const signerBalance = await Signer1.getBalance();
    console.log("Your Initial Balance is:", signerBalance);
    console.log("=======================================");

    //calling withdrawEther function from our deployed contract
    await MULTISIG.connect(Signer1).withdrawEther(_value);

    //calling approve function

    /* await MULTISIG.connect(Signer2).Approve(8);
    await MULTISIG.connect(Signer3).Approve(8);
    await MULTISIG.connect(Signer4).Approve(8);
    await MULTISIG.connect(Signer5).Approve(8);
    await MULTISIG.connect(Signer6).Approve(8);
    await MULTISIG.connect(Signer7).Approve(8);
    await MULTISIG.connect(Signer8).Approve(8) */;


    const newContractBalance = await MULTISIG.connect(Signer1).contractBalance();
    console.log("balance of contract after:", newContractBalance);
    console.log("=======================================");

    let newSignerBalance = await Signer1.getBalance();
    console.log("Your New Balance is:", newSignerBalance);


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});