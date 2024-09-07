require('dotenv').config()

const { spicy } = require('viem/chains');

const ethers = require('ethers');
const express = require("express");

const { TokenboundClient } = require('@tokenbound/sdk');

const PORT = process.env.PORT || 3000;

const SPICY_TESTNET_CHAIN_ID = 88882;

const app = express();


// ERC721 - ABI
// const TSHIRT_ABI = require("../../contract/artifacts/contracts/TShirtNFT.sol/TShirtNFT.json");
const TSHIRT_ABI = require("./TShirtNFT.json");

// Server Key - T-Shirt company
const SERVER_KEY = process.env.SERVER_KEY;

// NFT Contract Address
const NFT_CONTRACT_ADDRESS = process.env.TSHIRT_NFT_CONTRACT_ADDRESS;


app.use(express.json());


app.get("/", (req, res) => res.send("Express on Vercel"));

app.get("/status", (request, response) => {
    response.send({"Status": "Running"});
 });



app.get("/create/:user_address", async (request, response) => {

    try {
        let user_address = request.params['user_address'];

        let provider = new ethers.JsonRpcProvider("https://spicy-rpc.chiliz.com/", );

        let signer = new ethers.Wallet(SERVER_KEY, provider);

        // Token bound SDK
        const tokenboundClient = new TokenboundClient({ signer, chain: spicy });

        let contract = new ethers.Contract(
            NFT_CONTRACT_ADDRESS,
            TSHIRT_ABI.abi,
            signer
        );

        let res = await contract.buyTShirt(user_address);

        // Retrieve the nft id
        let response_data = await res.wait();
        let log = response_data.logs.filter((log) => log.fragment.name == "NewTShirtBuy");
        let token_id = log[0].args[0]        

        // Create token bound account
        const { account, txHash } = await tokenboundClient.createAccount({
            tokenContract: NFT_CONTRACT_ADDRESS,
            tokenId: token_id,
        })

        response.send({
            "hash": res["hash"],
            "tokenId": token_id.toString(),
            "account": account,
        });

    } catch (error) {
        console.log(error);
        request.status(500).send('Error when minting a new NFT.');
    }
});

app.listen(PORT, () => console.log("Server Listening on PORT:", PORT));

module.exports = app;