// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TShirtNFT is ERC721 {
    
    event NewTShirtBuy(uint indexed tokenId, address buyer);

    uint256 private _nextTokenId;

    constructor() ERC721("TShirt", "TSHI") {}

    function buyTShirt(address buyer) public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _mint(buyer, tokenId);
        
        emit NewTShirtBuy(tokenId, buyer);

        return tokenId;
    }

}