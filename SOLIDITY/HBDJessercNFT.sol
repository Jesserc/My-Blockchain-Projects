// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HappyBirthdayJesserc is ERC721, ERC721Enumerable, ERC721URIStorage {
    //0xbA5748a2C011b004081F58fd449bC75eff773082
    
    address owner;
    uint16 constant MAX_SUPPLY = 2022;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Happy Birthday Jesserc", unicode"🎂") {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function safeMint(address to, string memory uri) external payable {
        require(msg.value > 0, "Please provide mint fee");
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId <= MAX_SUPPLY, "Can't mint, total mint reached");
        _tokenIdCounter.increment(); 
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

 
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    } 

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
{
  return super.supportsInterface(interfaceId);
    }

    function withdrawFunds() external onlyOwner{
        payable(owner).transfer(address(this).balance);
    }

}