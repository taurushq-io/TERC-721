// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/lib/TERC721Share.sol";
import {ERC721Abstract} from "./ERC721Abstract.sol";
import {Strings} from "OZ/utils/Strings.sol";
import {IERC165} from "OZ/utils/introspection/IERC165.sol";
import {IERC20} from "OZ/token/ERC20/IERC20.sol";
import {IAccessControl} from "OZ/access/IAccessControl.sol";
contract TERC721TestShare is Test {
    using Strings for uint256;
    ERC721Abstract internal token;

    address admin = address(0x1);
    address minter = address(0x2);
    address burner = address(0x3);
    address holder = address(0x4);
    address attacker = address(0x5);

    string testName = "testnName";
    string testSymbol = "testSymbol";
    string testBaseURI = "testBaseURI";

    // Custom error openZeppelin
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    /* ============ Events ============ */
    event Burn(address indexed burner, uint256 tokenId);
    event BurnBatch(address indexed burner, uint256[] values);
    event Mint(address indexed minter, address indexed to, uint256 tokenId);
    event MintBatch(address indexed minter, address[] tos);
    event MintBatch(address indexed minter, address to, uint256 amount);

    /* ============ Errors ============ */
    error Burn_EmptyTokenIds();
    error Mint_NullAmount();
    error Mint_EmptyTos();
    error Mint_TosAmountlengthMismatch();

    // OpenZeppelin
    error ERC721NonexistentToken(uint256 tokenId);

    /*//////////////////////////////////////////////////////////////
                        VERSION
    //////////////////////////////////////////////////////////////*/
    function testShareVersion() internal view{
        assertEq(token.VERSION(), "0.1.0");
    }

    /*//////////////////////////////////////////////////////////////
                          MINT
    //////////////////////////////////////////////////////////////*/
    function testShareCanMint() internal {
        // Arrange
        uint256 tokenId = 0;
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);
        vm.startPrank(minter);

        // Events
        vm.expectEmit(true, true, true, true);
        emit Mint(minter, holder, tokenId);

        // Act
        token.mint(holder);

        // Assert
        // check balance
        assertEq(token.ownerOf(tokenId), holder);
        vm.stopPrank();
        // Check uri
        assertEq(token.tokenURI(tokenId),  string.concat(testBaseURI, tokenId.toString()));
    }

    function testShareCanMintBatchWithASingleHolder() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        // Act
        uint256 amount = 5;
        vm.prank(minter);
        token.mintBatch(holder, amount);

        // Assert
        assertEq(token.balanceOf(holder), amount);
        for (uint256 i = 0; i < amount; ++i) {
            assertEq(token.ownerOf(i), holder);
        }
    }

    function testShareCanMintBatchWithSeveralHolders() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        // Events
        vm.expectEmit(true, true, false, true);
        emit MintBatch(minter, accounts);
        // Act
        vm.prank(minter);
        token.mintBatch(accounts);

        // check balances
        assertEq(token.ownerOf(0), accounts[0]);
        assertEq(token.ownerOf(1), accounts[1]);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                           BURN
    //////////////////////////////////////////////////////////////*/

    function testShareCanBurn() internal {
        // Arrange
        vm.startPrank(admin);

        // Mint tokens first
        token.mint(holder);
        assertEq(token.ownerOf(0), holder);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        // Events
        vm.expectEmit(true, true, true, true);
        emit Burn(burner, 0);

        // Act
        token.burn(0);

        // Assert
        // Check balance after burn
        vm.expectRevert(
            abi.encodeWithSelector(ERC721NonexistentToken.selector, 0)
        );
        assertEq(token.ownerOf(0), address(0));
        vm.stopPrank();
    }

    function testShareCanBurnBatch() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        // Mint tokens first
        token.mintBatch(holders);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256[] memory burnIds = new uint256[](2);
        burnIds[0] = 0;
        burnIds[1] = 1;

        // Events
        vm.expectEmit(true, true, false, true);
        emit BurnBatch(burner, burnIds);

        // Act
        token.burnBatch(burnIds);

        // Assert
        // Check balance
        assertEq(token.balanceOf(holder), 0);
        assertEq(token.balanceOf(admin), 0);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/

    function testShareCannotBurnBatchIfInvalidParameters() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        // Mint tokens first
        token.mintBatch(holders);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256[] memory burnIds = new uint256[](0);

        // Act
        vm.expectRevert(abi.encodeWithSelector(Burn_EmptyTokenIds.selector));
        token.burnBatch(burnIds);
    }

    function testShareCannotMintBatchIfInvalidParametersEmptyTos() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        // Act
        vm.prank(minter);
        accounts = new address[](0);
        vm.expectRevert(abi.encodeWithSelector(Mint_EmptyTos.selector));
        token.mintBatch(accounts);
    }

    function testShareCannotMintBatchIfInvalidParametersMintNullAmount() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        // Act
        vm.prank(minter);
        vm.expectRevert(abi.encodeWithSelector(Mint_NullAmount.selector));
        token.mintBatch(holder, 0);
    }

    /*//////////////////////////////////////////////////////////////
                          Base URI
    //////////////////////////////////////////////////////////////*/

    function testShareCanSetBaseURI() internal {
        string memory newBaseURI = "newBaseUri";
        uint256 tokenId = 0;
        vm.startPrank(admin);
        // Arrange 
        token.mint(holder);

        // Act
        token.setBaseURI(newBaseURI);

        // Assert
        assertEq(token.tokenURI(tokenId ),  string.concat(newBaseURI, tokenId .toString()));
    }

    /* ============ ERC165 ============ */
    function testShareSupportInterface() internal view {
        bytes4 erc721Interface = 0x80ac58cd;

        // Assert
        assertEq(token.supportsInterface(erc721Interface), true);
        assertEq(token.supportsInterface(type(IAccessControl).interfaceId), true);
        assertEq(token.supportsInterface(type(IERC165).interfaceId), true);
         assertEq(token.supportsInterface(type(IERC20).interfaceId), false);
    }

    /*//////////////////////////////////////////////////////////////
                           Access Control
    //////////////////////////////////////////////////////////////*/
    function testShareAttackerCannotBurnAndBurnBatch() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        // Mint tokens first
        token.mintBatch(holders);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(attacker);

        uint256[] memory burnIds = new uint256[](2);
        burnIds[0] = 50;
        burnIds[1] = 150;

        // Act
        // Burn batch
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                BURNER_ROLE
            )
        );
        token.burnBatch(burnIds);
        // burn
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                BURNER_ROLE
            )
        );
        token.burn(100);
    }

    function testShareAttackerCannotMintAndMintBatch() internal {
        // Arrange
        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        uint256[] memory values = new uint256[](2);
        values[0] = 100;
        values[1] = 200;

        vm.startPrank(attacker);
        // Act
        // mint
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                MINTER_ROLE
            )
        );
        token.mint(holder);
        // MintBatch
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                MINTER_ROLE
            )
        );
        token.mintBatch(accounts);
    }

    function testShareAttackerCannotSetBaseURI() internal {
        // Arrange
        vm.startPrank(attacker);
        // Act
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                DEFAULT_ADMIN_ROLE
            )
        );
        token.setBaseURI("");
    }
}
