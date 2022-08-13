let ethers = require('ethers');  
let crypto = require('crypto');

let correctArr = [];

for (let i = 0; i <5; i++) {
    let key = crypto.randomBytes(32).toString('hex');
    let privateKey = "0x"+key;
    console.log(`Private Key: ${privateKey}`);
    
    let walletAddress = new ethers.Wallet(privateKey);
    console.log("Address: " + walletAddress.address);
    correctArr.push(`Address: ${walletAddress? "true": "false"} Private Key: ${privateKey? "true": "false"}`);
    console.log(correctArr);
}