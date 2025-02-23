// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

abstract contract TERC721Share {
    /**
     * @notice
     * Get the current version of the smart contract
     */
    string public constant VERSION = "0.2.0";

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /* ============ Events ============ */
    event Burn(address indexed burner, uint256 tokenId);
    event BurnBatch(address indexed burner, uint256[] values);

    event Mint(address indexed minter, address indexed to, uint256 tokenId);
    event MintBatch(address indexed minter, address[] tos, uint256[] tokenIds);
    event MintBatch(address indexed minter, address to, uint256[] tokenIds);
    /**
     * @dev Emitted when the value of 'baseUri' is set
     */
    event BaseURI(string newBaseURI);

    /* ============ Errors ============ */
    error Burn_EmptyTokenIds();
    error Mint_NullAmount();
    error Mint_EmptyTos();
    error Mint_TosAmountlengthMismatch();
    error Mint_TosTokenIdslengthMismatch();
    error Mint_EmptyTokenIds();

    /* ============ Functions ============ */
    function burnBatch(uint256[] calldata tokenIds) public virtual;
    function burn(uint256 tokenId) public virtual;
    /* ======  Mint with counter as tokenId ====== */
    function mint(address to) public virtual;
    function mintBatch(address to, uint256 amount) public virtual;
    function mintBatch(address[] calldata tos) public virtual;

    /* ======  Mint with tokenIds====== */
    function mint(address to, uint256 tokenId) public virtual;
    function mintBatch(
        address[] calldata tos,
        uint256[] calldata tokenIds
    ) public virtual;
    function mintBatch(address to, uint256[] calldata tokenIds) public virtual;

    function setBaseURI(string calldata newBaseURI) public virtual;
}
