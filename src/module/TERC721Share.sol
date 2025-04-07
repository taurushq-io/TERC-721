// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

abstract contract TERC721Share {
    /**
     * @notice
     * Get the current version of the smart contract
     */
    string public constant VERSION = "1.0.0";

    /**
     * @dev Emitted when the value of 'baseUri' is set
     */
    event BaseURI(string newBaseURI);

    /* ============ Functions ============ */
    /**
     * @notice Return current contract version
     */
    function version() public pure virtual returns (string memory) {
        return VERSION;
    }

    /**
     * @notice Set the base URI, common for all tokens URI if the URI of the token is set
     */
    function setBaseURI(string calldata newBaseURI) public virtual;
}
