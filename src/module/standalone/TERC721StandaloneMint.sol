// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "OZ/token/ERC721/ERC721.sol";
import {AccessControl} from "OZ/access/AccessControl.sol";
import "../TERC721ShareMint.sol";

/**
 * @title TERC721 for mint features
 */
abstract contract TERC721StandaloneMint is
    ERC721,
    AccessControl,
    TERC721ShareMint
{
    /* ==== Mint with custom tokenId === */
    uint256 internal nextTokenId;
    /**
     * @inheritdoc TERC721ShareMint
     */
    function mintTokenId(
        address to,
        uint256 tokenId
    ) public override onlyRole(MINTER_ROLE) {
        _mintAndEvent(to, tokenId);
    }

    /**
     * @inheritdoc TERC721ShareMint
     */
    function batchMintTokenIds(
        address to,
        uint256[] calldata tokenIds
    ) public override onlyRole(MINTER_ROLE) {
        require(tokenIds.length > 0, Mint_EmptyTokenIds());
        for (uint256 i = 0; i < tokenIds.length; ++i) {
            _safeMint(to, tokenIds[i]);
        }
        emit BatchMint(msg.sender, to, tokenIds);
    }

    /**
     * @inheritdoc TERC721ShareMint
     */
    function batchMintTokenIds(
        address[] calldata tos,
        uint256[] calldata tokenIds
    ) public override onlyRole(MINTER_ROLE) {
        require(tos.length > 0, Mint_EmptyTos());
        require(
            tos.length == tokenIds.length,
            Mint_TosTokenIdslengthMismatch()
        );
        for (uint256 i = 0; i < tos.length; ++i) {
            _safeMint(tos[i], tokenIds[i]);
        }
        emit BatchMint(msg.sender, tos, tokenIds);
    }

    /* ==== Mint by using the storage variable tokenId  === */
    /**
     * @inheritdoc TERC721ShareMint
     */
    function mint(address to) public override onlyRole(MINTER_ROLE) {
        uint256 tokenId = nextTokenId++;
        _mintAndEvent(to, tokenId);
    }

    /**
     * @inheritdoc TERC721ShareMint
     */
    function batchMint(
        address to,
        uint256 amount
    ) public override onlyRole(MINTER_ROLE) {
        require(amount > 0, Mint_NullAmount());
        uint256[] memory tokenIds = new uint256[](amount);
        uint256 nextTokenIdLocal = nextTokenId;
        for (uint256 i = 0; i < amount; ++i) {
            uint256 tokenId = nextTokenIdLocal++;
            tokenIds[i] = tokenId;
            _safeMint(to, tokenId);
        }
        nextTokenId = nextTokenIdLocal;
        emit BatchMint(msg.sender, to, tokenIds);
    }

    /**
     * @inheritdoc TERC721ShareMint
     */
    function batchMint(
        address[] calldata tos
    ) public override onlyRole(MINTER_ROLE) {
        require(tos.length != 0, Mint_EmptyTos());
        uint256[] memory tokenIds = new uint256[](tos.length);
        uint256 nextTokenIdLocal = nextTokenId;
        for (uint256 i = 0; i < tos.length; ++i) {
            uint256 tokenId = nextTokenIdLocal++;
            tokenIds[i] = tokenId;
            _safeMint(tos[i], tokenId);
        }
        nextTokenId = nextTokenIdLocal;
        emit BatchMint(msg.sender, tos, tokenIds);
    }

    /* ============ ERC165 ============ */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC721, AccessControl) returns (bool) {
        return
            ERC721.supportsInterface(interfaceId) ||
            AccessControl.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            INTERNAL/PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function _mintAndEvent(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId);
        emit Mint(msg.sender, to, tokenId);
    }
}
