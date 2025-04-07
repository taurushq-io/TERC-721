// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721Upgradeable} from "OZUpgradeable/token/ERC721/ERC721Upgradeable.sol";
import {AccessControlUpgradeable} from "OZUpgradeable/access/AccessControlUpgradeable.sol";
import "../TERC721ShareMint.sol";

/**
 * @title TERC721 for mint features
 */
abstract contract TERC721UpgradeableMint is
    ERC721Upgradeable,
    AccessControlUpgradeable,
    TERC721ShareMint
{
    /* ==== ERC-7201 State Variables === */
    struct TERC721UpgradeableMintStorage {
        uint256 _nextTokenId;
        string _baseURI;
    }

    /* ============ ERC-7201 ============ */
    // keccak256(abi.encode(uint256(keccak256("TERC721Upgradeable.storage.mint")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant TERC721UpgradeableMintStorageLocation =
        0xb67eff2db28fee42b215bff2672a3cd02727c23ecfe740c44e17513eecddc700;

    /* ============ Mint ============ */
    /* ==== Mint with custom tokenId === */
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
        require(tos.length != 0, Mint_EmptyTos());
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
        TERC721UpgradeableMintStorage
            storage $ = _getTERC721UpgradeableMintStorage();
        uint256 tokenId = $._nextTokenId++;
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
        TERC721UpgradeableMintStorage
            storage $ = _getTERC721UpgradeableMintStorage();
        uint256 nextTokenIdLocal = $._nextTokenId;
        for (uint256 i = 0; i < amount; ++i) {
            uint256 tokenId = nextTokenIdLocal++;
            tokenIds[i] = tokenId;
            _safeMint(to, tokenId);
        }
        $._nextTokenId = nextTokenIdLocal;
        emit BatchMint(msg.sender, to, tokenIds);
    }

    /**
     * @inheritdoc TERC721ShareMint
     */
    function batchMint(
        address[] calldata tos
    ) public override onlyRole(MINTER_ROLE) {
        require(tos.length != 0, Mint_EmptyTos());
        TERC721UpgradeableMintStorage
            storage $ = _getTERC721UpgradeableMintStorage();
        uint256[] memory tokenIds = new uint256[](tos.length);
        uint256 nextTokenIdLocal = $._nextTokenId;
        for (uint256 i = 0; i < tos.length; ++i) {
            uint256 tokenId = nextTokenIdLocal++;
            tokenIds[i] = tokenId;
            _safeMint(tos[i], tokenId);
        }
        $._nextTokenId = nextTokenIdLocal;
        emit BatchMint(msg.sender, tos, tokenIds);
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

    /*//////////////////////////////////////////////////////////////
                            INTERNAL/PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function _mintAndEvent(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId);
        emit Mint(msg.sender, to, tokenId);
    }

    /* ============ ERC-7201 ============ */
    function _getTERC721UpgradeableMintStorage()
        private
        pure
        returns (TERC721UpgradeableMintStorage storage $)
    {
        assembly {
            $.slot := TERC721UpgradeableMintStorageLocation
        }
    }
}
