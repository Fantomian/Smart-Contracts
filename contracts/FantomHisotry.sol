// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

/**
 * @title FantomHisotry
 * FantomHisotry - ERC721 contract that has minting functionality, and can't be transfered to any address.
 */
contract FantomHisotry is ERC721("FantomHisotry", "FantomHisotry"), Ownable {
    using SafeMath for uint256;

    event Minted(
        uint256 tokenId,
        string tokenUri
    );

    uint256 private _currentTokenId = 0;

    function mint(string calldata _tokenUri) external onlyOwner {
        uint256 newTokenId = _getNextTokenId();
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, _tokenUri);
        _incrementTokenId();

        emit Minted(newTokenId, _tokenUri);
    }

    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId.add(1);
    }

    function _incrementTokenId() private {
        _currentTokenId++;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        require(from == address(0));
        require(to == owner());
    }
}
