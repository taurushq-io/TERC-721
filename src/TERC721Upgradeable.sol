// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721Upgradeable} from "OZUpgradeable/token/ERC721/ERC721Upgradeable.sol";
import {AccessControlUpgradeable} from "OZUpgradeable/access/AccessControlUpgradeable.sol";
import {Initializable} from "OZUpgradeable/proxy/utils/Initializable.sol";
import {TERC721Share} from "./lib/TERC721Share.sol";

contract TERC721Upgradeable is
    Initializable,
    ERC721Upgradeable,
    AccessControlUpgradeable,
    TERC721Share
{
    /* ============ ERC-7201 ============ */
    // keccak256(abi.encode(uint256(keccak256("TERC721Upgradeable.storage.main")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant TERC721UpgradeableStorageLocation =
        0xd784b38d666c98842d939c4cd6a9471f8841642a0d6b6cab2340c928808e9b00;
    /* ==== ERC-7201 State Variables === */
    struct TERC721UpgradeableStorage {
        uint256 _nextTokenId;
        string _baseURI;
    }

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
        __ERC721_init_unchained(name, symbol);
        // AccessControlUpgradeable inherits from ERC165Upgradeable
        __ERC165_init_unchained();
        __AccessControl_init_unchained();
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
    /* ============ Mint ============ */
    function mint(address to) public override onlyRole(MINTER_ROLE) {
        TERC721UpgradeableStorage storage $ = _getTERC721UpgradeableStorage();
        uint256 tokenId = $._nextTokenId++;
        _mint(to, tokenId);
        emit Mint(msg.sender, to, tokenId);
    }

    function mintBatch(
        address to,
        uint256 amount
    ) public override onlyRole(MINTER_ROLE) {
        require(amount > 0, Mint_NullAmount());
        for (uint256 i = 0; i < amount; ++i) {
            TERC721UpgradeableStorage
                storage $ = _getTERC721UpgradeableStorage();
            uint256 tokenId = $._nextTokenId++;
            _mint(to, tokenId);
        }
    }

    function mintBatch(
        address[] calldata tos
    ) public override onlyRole(MINTER_ROLE) {
        require(tos.length != 0, Mint_EmptyTos());
        for (uint256 i = 0; i < tos.length; ++i) {
            TERC721UpgradeableStorage
                storage $ = _getTERC721UpgradeableStorage();
            uint256 tokenId = $._nextTokenId++;
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
    function _setBaseURI(string calldata newBaseURI) internal {
        TERC721UpgradeableStorage storage $ = _getTERC721UpgradeableStorage();
        $._baseURI = newBaseURI;
        emit BaseURI(newBaseURI);
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`.
     */
    function _baseURI() internal view override returns (string memory) {
        TERC721UpgradeableStorage storage $ = _getTERC721UpgradeableStorage();
        return $._baseURI;
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
