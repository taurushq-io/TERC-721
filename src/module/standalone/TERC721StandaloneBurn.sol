// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "OZ/token/ERC721/ERC721.sol";
import {AccessControl} from "OZ/access/AccessControl.sol";
import "../TERC721ShareBurn.sol";

/**
 * @title TERC721 for burn features
 */
abstract contract TERC721StandaloneBurn is
    ERC721,
    AccessControl,
    TERC721ShareBurn
{
    /* ============ Burn ============ */
    /**
     * @notice burn tokens
     * @dev burned tokens can be minted again with mint by specifying the tokenId
     */
    function burn(uint256 tokenId) public override onlyRole(BURNER_ROLE) {
        _burn(tokenId);
        emit Burn(_msgSender(), tokenId);
    }

    /**
     * @notice {batch} version of burn
     * @dev burned tokens can be minted again with mint by specifying the tokenId
     */
    function batchBurn(
        uint256[] calldata tokenIds
    ) public override onlyRole(BURNER_ROLE) {
        require(tokenIds.length != 0, Burn_EmptyTokenIds());
        for (uint256 i = 0; i < tokenIds.length; ++i) {
            _burn(tokenIds[i]);
        }
        emit BatchBurn(_msgSender(), tokenIds);
    }

    /* ============ ERC165 ============ */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC721, AccessControl) returns (bool) {
        return
            ERC721.supportsInterface(interfaceId) ||
            AccessControl.supportsInterface(interfaceId);
    }
}
