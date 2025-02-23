// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/TERC721Standalone.sol";
import "./TERC721TestShare.sol";

contract TERC721TestStandalone is Test, TERC721TestShare {
    function setUp() public {
        token = ERC721Abstract(
            address(
                new TERC721Standalone(admin, testName, testSymbol, testBaseURI)
            )
        );
    }

    /*//////////////////////////////////////////////////////////////
                        VERSION
    //////////////////////////////////////////////////////////////*/
    function testVersion() public view {
        testShareVersion();
    }

    /*//////////////////////////////////////////////////////////////
                          MINT
    //////////////////////////////////////////////////////////////*/

    function testMint() public {
        TERC721TestShare.testShareCanMint();
    }

    function testCanMintBatchWithASingleHolder() public {
        TERC721TestShare.testShareCanMintBatchWithASingleHolder();
    }

    function testCanMintBatchWithSeveralHolders() public {
        TERC721TestShare.testShareCanMintBatchWithSeveralHolders();
    }

    function testCanMintBatchWithSeveralHoldersAndIds() public {
        TERC721TestShare.testShareCanMintBatchWithSeveralHoldersAndIds();
    }

    function testCanMintBatchWithASingleHolderAndTokenIds() public {
        TERC721TestShare.testShareCanMintBatchWithASingleHolderAndTokenIds();
    }

    /*//////////////////////////////////////////////////////////////
                           BURN
    //////////////////////////////////////////////////////////////*/

    function testBurn() public {
        TERC721TestShare.testShareCanBurn();
    }

    function testBurnBatch() public {
        TERC721TestShare.testShareCanBurnBatch();
    }

    /*//////////////////////////////////////////////////////////////
                        BaseURI
    //////////////////////////////////////////////////////////////*/
    function testSetBaseURI() public {
        TERC721TestShare.testShareCanSetBaseURI();
    }

    /*//////////////////////////////////////////////////////////////
                     ERC-165
    //////////////////////////////////////////////////////////////*/
    function testSupportInterface() public view {
        TERC721TestShare.testShareSupportInterface();
    }

    /*//////////////////////////////////////////////////////////////
                           Access Control
    //////////////////////////////////////////////////////////////*/

    function testAttackerCannotBurnAndBurnBatch() public {
        TERC721TestShare.testShareAttackerCannotBurnAndBurnBatch();
    }

    function testAttackerCannotMintAndMintBatch() public {
        TERC721TestShare.testShareAttackerCannotMintAndMintBatch();
    }

    function testAttackerCannotSetBaseURI() public {
        TERC721TestShare.testShareAttackerCannotSetBaseURI();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/
    function testCannotBurnBatchIfInvalidParameters() public {
        TERC721TestShare.testShareCannotBurnBatchIfInvalidParameters();
    }

    function testCannotMintBatchIfInvalidParametersEmptyTos() public {
        TERC721TestShare.testShareCannotMintBatchIfInvalidParametersEmptyTos();
    }

    function testCannotMintBatchIfInvalidParametersNullAmount() public {
        TERC721TestShare
            .testShareCannotMintBatchIfInvalidParametersMintNullAmount();
    }

    /*//////////////////////////////////////////////////////////////
                        Deployment
    //////////////////////////////////////////////////////////////*/
    function testTERC721StandaloneDeployment() public {
        TERC721Standalone TERC721 = new TERC721Standalone(
            admin,
            testName,
            testSymbol,
            testBaseURI
        );
        assertEq(TERC721.name(), testName);
        assertEq(TERC721.symbol(), testSymbol);
        assertEq(TERC721.baseURI(), testBaseURI);
    }
}
