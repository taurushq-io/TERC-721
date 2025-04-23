// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721Upgradeable} from "OZUpgradeable/token/ERC721/ERC721Upgradeable.sol";
import {AccessControlUpgradeable} from "OZUpgradeable/access/AccessControlUpgradeable.sol";
import {TERC721ShareBurn} from "../TERC721ShareBurn.sol";

/**
 * @title TERC721 for burn features
 */
abstract contract TERC721UpgradeableBurn is
    ERC721Upgradeable,
    AccessControlUpgradeable,
    TERC721ShareBurn
{
    /* ============ Burn ============ */
    /**
     * @notice burn tokens
     */
    function burn(uint256 tokenId) public override onlyRole(BURNER_ROLE) {
        _burn(tokenId);
        emit Burn(_msgSender(), tokenId);
    }

    /**
     * @notice {batch} version of burn
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
    )
        public
        view
        virtual
        override(ERC721Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return
            ERC721Upgradeable.supportsInterface(interfaceId) ||
            AccessControlUpgradeable.supportsInterface(interfaceId);
    }
}
