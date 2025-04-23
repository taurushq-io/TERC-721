// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/TERC721Upgradeable.sol";
import "./TERC721TestShare.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract TERC721TestProxy is Test, TERC721TestShare {
    function setUp() public {
        address proxy = Upgrades.deployTransparentProxy(
            "TERC721Upgradeable.sol",
            admin,
            abi.encodeCall(
                TERC721Upgradeable.initialize,
                (admin, testName, testSymbol, testBaseURI)
            )
        );
        token = ERC721Abstract(proxy);
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

    function testCanBatchMintWithASingleHolder() public {
        TERC721TestShare.testShareCanBatchMintWithASingleHolder();
    }

    function testCanBatchMintWithSeveralHolders() public {
        TERC721TestShare.testShareCanBatchMintWithSeveralHolders();
    }

    function testCanBatchMintWithSeveralHoldersAndIds() public {
        TERC721TestShare.testShareCanBatchMintWithSeveralHoldersAndIds();
    }

    function testCanBatchMintWithASingleHolderAndTokenIds() public {
        TERC721TestShare.testShareCanBatchMintWithASingleHolderAndTokenIds();
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
                       tokenID
    //////////////////////////////////////////////////////////////*/
    function testSetTokenId() public {
        TERC721TestShare.testShareCanSetTokenId();
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
        TERC721TestShare.testShareAttackerCannotMintAndBatchMint();
    }

    function testAttackerCannotSetBaseURI() public {
        TERC721TestShare.testShareAttackerCannotSetBaseURI();
    }

    function testAttackerCannotSetNextTokenId() public {
        TERC721TestShare.testShareAttackerCannotSetNextTokenId();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/
    function testCannotBurnBatchIfInvalidParameters() public {
        TERC721TestShare.testShareCannotBurnBatchIfInvalidParameters();
    }

    function testCannotMintBatchIfInvalidParametersEmptyTos() public {
        TERC721TestShare.testShareCannotBatchMintIfInvalidParametersEmptyTos();
    }

    function testCannotMintBatchIfInvalidParametersNullAmount() public {
        TERC721TestShare
            .testShareCannotBatchMintIfInvalidParametersMintNullAmount();
    }

    /*//////////////////////////////////////////////////////////////
                        Deployment
    //////////////////////////////////////////////////////////////*/
    function testTERC721UpgradeableDeployment() public {
        address proxy = Upgrades.deployTransparentProxy(
            "TERC721Upgradeable.sol",
            admin,
            abi.encodeCall(
                TERC721Upgradeable.initialize,
                (admin, testName, testSymbol, testBaseURI)
            )
        );
        TERC721Upgradeable TERC721 = TERC721Upgradeable(proxy);
        // Access control
        assertEq(TERC721.hasRole(DEFAULT_ADMIN_ROLE, admin), true);
        assertEq(TERC721.hasRole(BURNER_ROLE, admin), true);
        assertEq(TERC721.hasRole(MINTER_ROLE, admin), true);
        assertEq(TERC721.hasRole(DEFAULT_ADMIN_ROLE, attacker), false);
        assertEq(TERC721.hasRole(BURNER_ROLE, attacker), false);
        assertEq(TERC721.hasRole(MINTER_ROLE, attacker), false);
        // Base
        assertEq(TERC721.name(), testName);
        assertEq(TERC721.symbol(), testSymbol);
        assertEq(TERC721.baseURI(), testBaseURI);
    }
}
