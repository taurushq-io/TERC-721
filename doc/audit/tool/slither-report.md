**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [assembly](#assembly) (2 results) (Informational)
 - [naming-convention](#naming-convention) (3 results) (Informational)
## assembly

> Used by  ERC-7201

Impact: Informational
Confidence: High

 - [ ] ID-0
	[TERC721UpgradeableMint._getTERC721UpgradeableMintStorage()](src/module/upgradeable/TERC721UpgradeableMint.sol#L164-L172) uses assembly
	- [INLINE ASM](src/module/upgradeable/TERC721UpgradeableMint.sol#L169-L171)

src/module/upgradeable/TERC721UpgradeableMint.sol#L164-L172


 - [ ] ID-1
	[TERC721Upgradeable._getTERC721UpgradeableStorage()](src/TERC721Upgradeable.sol#L133-L141) uses assembly
	- [INLINE ASM](src/TERC721Upgradeable.sol#L138-L140)

src/TERC721Upgradeable.sol#L133-L141

## naming-convention

> Acknolwedge

Impact: Informational
Confidence: High
 - [ ] ID-2
Constant [TERC721Upgradeable.TERC721UpgradeableStorageLocation](src/TERC721Upgradeable.sol#L23-L24) is not in UPPER_CASE_WITH_UNDERSCORES

src/TERC721Upgradeable.sol#L23-L24


 - [ ] ID-3
Function [TERC721Upgradeable.__TERC721Upgradeable_init_unchained(address,string)](src/TERC721Upgradeable.sol#L47-L53) is not in mixedCase

src/TERC721Upgradeable.sol#L47-L53


 - [ ] ID-4
Constant [TERC721UpgradeableMint.TERC721UpgradeableMintStorageLocation](src/module/upgradeable/TERC721UpgradeableMint.sol#L23-L24) is not in UPPER_CASE_WITH_UNDERSCORES

src/module/upgradeable/TERC721UpgradeableMint.sol#L23-L24

