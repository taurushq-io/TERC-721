// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";

abstract contract TERC721ShareBurn {
    /**
     * @dev Role to burn tokens
     */
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /* ============ Events ============ */
    event Burn(address indexed burner, uint256 tokenId);
    event BatchBurn(address indexed burner, uint256[] values);
    /* ============ Errors ============ */
    /**
     * @dev Indicates that the parameter `accounts` is empty.
     * Used with {batchBurn}.
     */
    error Burn_EmptyTokenIds();


    /**
     *
     * @notice batch version of {burn}.
     * @dev
     *
     * For each burn action, emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Emits a {BurnBatch} event
     * Requirements:
     * - the caller must have the `BURNER_ROLE`.
     * - `accounts` cannot be empty (error Burn_EmptyAccounts)
     * - `accounts` and `values` must have the same length
     * - `accounts` cannot contain a zero address.
     * The check is made inside the internal OpenZeppelin function _burn.
     * If this is the case, the contract will generate the following error defined in the ERC-6093:
     * ERC20InvalidSender
     */
    function batchBurn(uint256[] calldata tokenIds) public virtual;
    /**
     * @notice Destroys a `value` amount of tokens from `account`, by transferring it to address(0).
     * @dev
     * Emits a {Burn} event
     * Emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Requirements:
     * - The caller must have the `BURNER_ROLE`.
     * - Account cannot be the zero address (error ERC20InvalidSender).
     * The check is made inside the internal OpenZeppelin function _burn.
     */
    function burn(uint256 tokenId) public virtual;
}