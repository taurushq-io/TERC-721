**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [pragma](#pragma) (1 results) (Informational)
 - [solc-version](#solc-version) (1 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
 - [unused-state](#unused-state) (2 results) (Informational)
 - [constable-states](#constable-states) (1 results) (Optimization)
## pragma

> Solidity version is set in the config file

Impact: Informational
Confidence: High
 - [ ] ID-0
	2 different versions of Solidity are used:
	- Version constraint ^0.8.20 is used by:
 		- lib/openzeppelin-contracts/contracts/access/AccessControl.sol#4
		- lib/openzeppelin-contracts/contracts/access/IAccessControl.sol#4
		- lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3
		- lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#4
		- lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#4
		- lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#4
		- lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#4
		- lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Utils.sol#4
		- lib/openzeppelin-contracts/contracts/utils/Context.sol#4
		- lib/openzeppelin-contracts/contracts/utils/Panic.sol#4
		- lib/openzeppelin-contracts/contracts/utils/Strings.sol#4
		- lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4
		- lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4
		- lib/openzeppelin-contracts/contracts/utils/math/Math.sol#4
		- lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#5
		- lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/token/ERC721/ERC721Upgradeable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#4
	- Version constraint ^0.8.28 is used by:
 		- src/TERC721Standalone.sol#2
		- src/TERC721Upgradeable.sol#2
		- src/lib/TERC721Share.sol#2

## solc-version

> Solidity version is set in the config file

Impact: Informational
Confidence: High
 - [ ] ID-1
	Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
	 It is used by:
	- lib/openzeppelin-contracts/contracts/access/AccessControl.sol#4
	- lib/openzeppelin-contracts/contracts/access/IAccessControl.sol#4
	- lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3
	- lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#4
	- lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#4
	- lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#4
	- lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#4
	- lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Utils.sol#4
	- lib/openzeppelin-contracts/contracts/utils/Context.sol#4
	- lib/openzeppelin-contracts/contracts/utils/Panic.sol#4
	- lib/openzeppelin-contracts/contracts/utils/Strings.sol#4
	- lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4
	- lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4
	- lib/openzeppelin-contracts/contracts/utils/math/Math.sol#4
	- lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#5
	- lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/token/ERC721/ERC721Upgradeable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#4

## naming-convention

> Same notation as OpenZeppelin, see https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/8c63b58ff08275284c120c561b3bc14090b87c51/contracts/token/ERC20/ERC20Upgradeable.sol#L62

Impact: Informational
Confidence: High
 - [ ] ID-2
Constant [TERC721Upgradeable.TERC721UpgradeableStorageLocation](src/TERC721Upgradeable.sol#L17-L18) is not in UPPER_CASE_WITH_UNDERSCORES

src/TERC721Upgradeable.sol#L17-L18

> Same notation as OpenZeppelin see https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/8c63b58ff08275284c120c561b3bc14090b87c51/contracts/token/ERC20/ERC20Upgradeable.sol#L44


 - [ ] ID-3
Function [TERC721Upgradeable.__TERC721Upgradeable_init_unchained(address,string)](src/TERC721Upgradeable.sol#L45-L51) is not in mixedCase

src/TERC721Upgradeable.sol#L45-L51

## unused-state

> used by setBaseURI & tokenURI

Impact: Informational
Confidence: High

 - [ ] ID-4
[TERC721Standalone.baseURI_](src/TERC721Standalone.sol#L11) is never used in [TERC721Standalone](src/TERC721Standalone.sol#L8-L127)

src/TERC721Standalone.sol#L11

> Used by ERC-2701 through assembly


 - [ ] ID-5
[TERC721Upgradeable.TERC721UpgradeableStorageLocation](src/TERC721Upgradeable.sol#L17-L18) is never used in [TERC721Upgradeable](src/TERC721Upgradeable.sol#L9-L186)

src/TERC721Upgradeable.sol#L17-L18

## constable-states

> Not possible, can be updated with the function setBaseURI

Impact: Optimization
Confidence: High
 - [ ] ID-6
[TERC721Standalone.baseURI_](src/TERC721Standalone.sol#L11) should be constant 

src/TERC721Standalone.sol#L11

