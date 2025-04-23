// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721Upgradeable} from "OZUpgradeable/token/ERC721/ERC721Upgradeable.sol";
import {AccessControlUpgradeable} from "OZUpgradeable/access/AccessControlUpgradeable.sol";
import {Initializable} from "OZUpgradeable/proxy/utils/Initializable.sol";
import {TERC721Share} from "./module/TERC721Share.sol";
import {TERC721UpgradeableBurn} from "./module/upgradeable/TERC721UpgradeableBurn.sol";
import "./module/upgradeable/TERC721UpgradeableMint.sol";
contract TERC721Upgradeable is
    Initializable,
    TERC721Share,
    TERC721UpgradeableBurn,
    TERC721UpgradeableMint
{
    /* ==== ERC-7201 State Variables === */
    struct TERC721UpgradeableStorage {
        string _baseURI;
    }

    /* ============ ERC-7201 ============ */
    // keccak256(abi.encode(uint256(keccak256("TERC721Upgradeable.storage.main")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant TERC721UpgradeableStorageLocation =
        0xd784b38d666c98842d939c4cd6a9471f8841642a0d6b6cab2340c928808e9b00;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        address admin,
        string memory name,
        string memory symbol,
        string calldata baseURI_
    ) public initializer {
        /* OpenZeppelin library */
        // OZ init_unchained functions are called firstly due to inheritance
        __Context_init_unchained();
        // AccessControlUpgradeable and ERC721 inherits from ERC165Upgradeable
        __ERC165_init_unchained();
        __ERC721_init_unchained(name, symbol);
        __AccessControl_init_unchained();
        // Own initialize function
        __TERC721Upgradeable_init_unchained(admin, baseURI_);
    }
    function __TERC721Upgradeable_init_unchained(
        address admin,
        string calldata baseURI_
    ) internal onlyInitializing {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _setBaseURI(baseURI_);
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
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

    /* ============ ACCESS CONTROL ============ */
    /**
     * @notice Returns `true` if `account` has been granted `role`.
     */
    function hasRole(
        bytes32 role,
        address account
    ) public view virtual override(AccessControlUpgradeable) returns (bool) {
        // The Default Admin has all roles
        if (AccessControlUpgradeable.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        }
        return AccessControlUpgradeable.hasRole(role, account);
    }

    /* ============ ERC165 ============ */
    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(TERC721UpgradeableMint, TERC721UpgradeableBurn)
        returns (bool)
    {
        return
            ERC721Upgradeable.supportsInterface(interfaceId) ||
            AccessControlUpgradeable.supportsInterface(interfaceId) ||
            TERC721UpgradeableMint.supportsInterface(interfaceId) ||
            TERC721UpgradeableBurn.supportsInterface(interfaceId);
    }

    /*//////////////////////////////////////////////////////////////
                            INTERNAL/PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev Set the base URI, common for all tokens URI if the URI of the token is set
     */
    function _setBaseURI(string calldata newBaseURI) internal {
        TERC721UpgradeableStorage storage $ = _getTERC721UpgradeableStorage();
        $._baseURI = newBaseURI;
        emit BaseURI(_msgSender(), newBaseURI);
        // ERC-4906: Refresh token metadata for the whole collection
        emit BatchMetadataUpdate(0, type(uint256).max);
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`.
     */
    function _baseURI() internal view override returns (string memory) {
        TERC721UpgradeableStorage storage $ = _getTERC721UpgradeableStorage();
        return $._baseURI;
    }

    /* ============ ERC-7201 ============ */
    function _getTERC721UpgradeableStorage()
        private
        pure
        returns (TERC721UpgradeableStorage storage $)
    {
        assembly {
            $.slot := TERC721UpgradeableStorageLocation
        }
    }
}
