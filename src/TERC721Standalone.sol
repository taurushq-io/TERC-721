// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "OZ/token/ERC721/ERC721.sol";
import {AccessControl} from "OZ/access/AccessControl.sol";
import {TERC721Share} from "./module/TERC721Share.sol";
import {TERC721StandaloneBurn} from "./module/standalone/TERC721StandaloneBurn.sol";
import {TERC721StandaloneMint} from "./module/standalone/TERC721StandaloneMint.sol";
contract TERC721Standalone is
    TERC721Share,
    TERC721StandaloneBurn,
    TERC721StandaloneMint
{
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

    /* ============ Uri ============ */

    /**
     * @inheritdoc TERC721Share
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
    /* ============ ERC165 ============ */
    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(TERC721StandaloneMint, TERC721StandaloneBurn)
        returns (bool)
    {
        return
            ERC721.supportsInterface(interfaceId) ||
            AccessControl.supportsInterface(interfaceId) ||
            TERC721StandaloneMint.supportsInterface(interfaceId) ||
            TERC721StandaloneBurn.supportsInterface(interfaceId);
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

    /*//////////////////////////////////////////////////////////////
                            INTERNAL/PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
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
}
