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
    event Mint(address indexed minter, address indexed to, uint256 tokenId);
    event BatchMint(address indexed minter, address[] tos, uint256[] tokenIds);
    event BatchMint(address indexed minter, address to, uint256[] tokenIds);
    /* ============ Errors ============ */
    
    error Mint_NullAmount();
    error Mint_EmptyTos();
    error Mint_TosAmountlengthMismatch();
    error Mint_TosTokenIdslengthMismatch();
    error Mint_EmptyTokenIds();



    /* ======  Mint with counter as tokenId ====== */
    /**
    * @notice Mints the next NFT and transfers it to `to`.
    * If the token is already minted, transaction will be reverted with the error ERC721InvalidSender
    */
    function mint(address to) public virtual;
    
    /**
    * @notice 
    * Batch version of {mint}
    * Mint `amount`of next NFTs to the recipient `to`
    * @param amount number of tokens to mint
    */
    function batchMint(address to, uint256 amount) public virtual;
    /**
    * @notice mint `tos.length`of next NFTs to address `tos`
    * Batch version of {mint}
    * Each address will receive one NFT
    */
    function batchMint(address[] calldata tos) public virtual;

    /* ======  Mint with tokenIds====== */
    /**
     * @notice Mints `tokenId` and transfers it to `to`.
     * If the token is already minted, transaction will be reverted with the error ERC721InvalidSender
     */
    function mintTokenId(address to, uint256 tokenId) public virtual;
    /**
     * @notice 
     * Batch version of {mintTokenId}
     * Each address `to` will receive one token
     */
    function batchMintTokenIds(
        address[] calldata tos,
        uint256[] calldata tokenIds
    ) public virtual;
    /**
    * @notice 
    * Batch version of {mintTokenId}
    * Mint `tokenIds.length` to the recipient `to`
    */
    function batchMintTokenIds(address to, uint256[] calldata tokenIds) public virtual;
}