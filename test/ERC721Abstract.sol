// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "../src/lib/TERC721Share.sol";
import {IERC721} from "OZ/token/ERC721/IERC721.sol";
import {IERC721Metadata} from "OZ/token/ERC721/extensions/IERC721Metadata.sol";
import {IAccessControl} from "OZ/access/IAccessControl.sol";
abstract contract ERC721Abstract is TERC721Share, IERC721, IERC721Metadata, IAccessControl {}
