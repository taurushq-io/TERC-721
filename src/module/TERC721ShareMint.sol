// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";

abstract contract TERC721ShareMint {
    /**
     * @dev Role to mint tokens
     */
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /* ============ Events ============ */
    event Mint(
        address indexed minter,
        address indexed to,
        uint256 indexed tokenId
    );
    event BatchMint(address indexed minter, address[] tos, uint256[] tokenIds);
    event BatchMint(
        address indexed minter,
        address indexed to,
        uint256[] tokenIds
    );
    /* ============ Errors ============ */

    error Mint_NullAmount();
    error Mint_EmptyTos();
    error Mint_TosTokenIdslengthMismatch();
    error Mint_EmptyTokenIds();

    /* ======  Mint with counter as tokenId ====== */

    /**
     * @notice Mints the next NFT and transfers it to `to`.
     * Requirements:
     * The caller must have the `MINTER_ROLE`.
     * If the token is already minted, transaction will be reverted with the ERC-6093 error `ERC721InvalidSender`
     * To cannot be the zero address(ERC-6093 error ERC721InvalidReceiver)
     * If `to`is a smart contract, it must implement the interface `IERC721Receiver` (ERC-6093 error `ERC721InvalidReceiver`)
     * @dev
     * Emit a `Mint`event
     * Emit a `Transfer`event. 
     * This event is emitted inside the OpenZeppelin function `_update` called by `_mint`.
     */
    function mint(address to) public virtual;

    /**
     * @notice
     * Batch version of {mint}
     * Mint `amount`of next NFTs to the recipient `to`
     * Same requirement as the function `mint`
     * @param amount number of tokens to mint
     * @dev 
     * Emit a `BatchMint` event
     * For each NFT minted:
     *  Emit a `Transfer`event. 
     *  This event is emitted inside the OpenZeppelin function `_update` called by `_mint`.
     */
    function batchMint(address to, uint256 amount) public virtual;
    /**
     * @notice mint `tos.length`of next NFTs to address `tos`
     * Batch version of {mint}
     * Each address will receive one NFT
     * Requirements:
     * - Same requirement as the function `mint`
     * - `tos` cannot be empty (error `Mint_EmptyTos`)
     * 
     * @dev 
     * Events:
     *  Emit a `BatchMint` event
     *  For each NFT minted:
     *      Emit a `Transfer`event. 
     *      This event is emitted inside the OpenZeppelin function `_update` called by `_mint`.
     */
    function batchMint(address[] calldata tos) public virtual;

    /* ======  Mint with tokenIds====== */
    /**
     * @notice Mints `tokenId` and transfers it to `to`.
     * Same requirement as the function `mint`
     */
    function mintTokenId(address to, uint256 tokenId) public virtual;
    /**
     * @notice
     * Batch version of {`mintTokenId`}
     * Each address `to` will receive one token
     * Requirements:
     * -  Same requirement as the function `mint`
     * - `tos` cannot be empty (error `Mint_EmptyTos`)
     * - `tos` and `tokenIds` must have the same length (error Mint_TosTokenIdslengthMismatch)
     *  Events:
     *  Emit a `BatchMint` event
     *  For each NFT minted:
     *      Emit a `Transfer`event. 
     *      This event is emitted inside the OpenZeppelin function `_update` called by `_mint`.
     */
    function batchMintTokenIds(
        address[] calldata tos,
        uint256[] calldata tokenIds
    ) public virtual;

    /**
     * @notice
     * Batch version of {mintTokenId}
     * Mint `tokenIds.length` to the recipient `to`
     * Requirements:
     * - Same requirement as the function `mint`
     * - `tokenIds` cannot be empty (error Mint_EmptyTokenIds)
     * @dev
     *  Events:
     *  Emit a `BatchMint` event
     *  For each NFT minted:
     *      Emit a `Transfer`event. 
     *      This event is emitted inside the OpenZeppelin function `_update` called by `_mint`.
     */
    function batchMintTokenIds(
        address to,
        uint256[] calldata tokenIds
    ) public virtual;
}
