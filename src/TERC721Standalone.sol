// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "OZ/token/ERC721/ERC721.sol";
import {AccessControl} from "OZ/access/AccessControl.sol";
import {TERC721Share} from "./lib/TERC721Share.sol";

contract TERC721Standalone is TERC721Share, AccessControl, ERC721 {
    uint256 internal nextTokenId;
    // Optional base URI
    string internal baseURI_;
    constructor(
        address admin,
        string memory name,
        string memory symbol,
        string memory baseURIInput
    ) ERC721(name, symbol) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _setBaseURI(baseURIInput);
    }

    /* ============ Mint ============ */
    function mint(address to) public override onlyRole(MINTER_ROLE) {
        uint256 tokenId = nextTokenId++;
        _mint(to, tokenId);
        emit Mint(msg.sender, to, tokenId);
    }

    function mintBatch(
        address to,
        uint256 amount
    ) public override onlyRole(MINTER_ROLE) {
        require(amount > 0, Mint_NullAmount());
        for (uint256 i = 0; i < amount; ++i) {
            uint256 tokenId = nextTokenId++;
            _mint(to, tokenId);
        }
        emit MintBatch(msg.sender, to, amount);
    }

    function mintBatch(
        address[] calldata tos
    ) public override onlyRole(MINTER_ROLE) {
        require(tos.length != 0, Mint_EmptyTos());
        for (uint256 i = 0; i < tos.length; ++i) {
            uint256 tokenId = nextTokenId++;
            _mint(tos[i], tokenId);
        }
        emit MintBatch(msg.sender, tos);
    }

    /* ============ Burn ============ */
    function burn(uint256 tokenId) public override onlyRole(BURNER_ROLE) {
        _burn(tokenId);
        emit Burn(msg.sender, tokenId);
    }

    function burnBatch(
        uint256[] calldata tokenIds
    ) public override onlyRole(BURNER_ROLE) {
        require(tokenIds.length != 0, Burn_EmptyTokenIds());
        for (uint256 i = 0; i < tokenIds.length; ++i) {
            _burn(tokenIds[i]);
        }
        emit BurnBatch(msg.sender, tokenIds);
    }

    /* ============ Uri ============ */

    /**
     * @notice Set the base URI, common for all tokens URI if the URI of the token is set
     */
    function setBaseURI(
        string calldata newBaseURI
    ) public override onlyRole(DEFAULT_ADMIN_ROLE) {
        _setBaseURI(newBaseURI);
    }

    /**
     * @notice return Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`.
     */
    function baseURI() public view returns (string memory) {
        return _baseURI();
    }

    /**
     * @dev Set the base URI, common for all tokens URI if the URI of the token is set
     */
    function _setBaseURI(string memory newBaseURI) internal {
        baseURI_ = newBaseURI;
        emit BaseURI(newBaseURI);
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default
     */
    function _baseURI() internal view override returns (string memory) {
        return baseURI_;
    }

    /* ============ ERC165 ============ */
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, AccessControl) returns (bool) {
        return
            ERC721.supportsInterface(interfaceId) ||
            AccessControl.supportsInterface(interfaceId);
    }

    /* ============ ACCESS CONTROL ============ */
    /**
     * @notice Returns `true` if `account` has been granted `role`.
     */
    function hasRole(
        bytes32 role,
        address account
    ) public view virtual override(AccessControl) returns (bool) {
        // The Default Admin has all roles
        if (AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        }
        return AccessControl.hasRole(role, account);
    }
}
