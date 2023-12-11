// SPDX-License-Identifier: MIT
// ERC-721 Smart Contract for the Loonies NFT Collection
pragma solidity ^0.8.0;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

string constant tokenName = "Loonies";
string constant symbol = "LOON";

contract Loonies is ERC721Enumerable, Pausable, Ownable {
    using Strings for uint256;

    uint256 public maxTokens; // Should be 12000
    uint256 public price; // Cost of each mint in ETH
    string public baseTokenURI; // base uri of loonies assets

    constructor(
        uint256 _maxToken,
        uint256 _price,
        string memory _baseTokenURI
    ) ERC721("Loonies", "LOON") {
        maxTokens = _maxToken;
        price = _price;
        baseTokenURI = _baseTokenURI;
    }

    function mintNft(address _to) public payable whenNotPaused {
        uint256 id = totalSupply() + 1;

        if (msg.sender != owner()) {
            require(msg.value >= price, "Ether sent is not enough");
        }

        require(id <= maxTokens, "Exceeds maximum supply");

        _safeMint(_to, id);
    }

    function burn(uint256 tokenId) public virtual {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721Burnable: caller is not owner nor approved"
        );
        _burn(tokenId);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function withdraw(uint256 _amount) public payable onlyOwner {
        require(payable(msg.sender).send(_amount));
    }

    function withdrawAll() public payable onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }

    function _baseURI() internal view override(ERC721) returns (string memory) {
        return baseTokenURI;
    }
}