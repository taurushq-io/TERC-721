**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [assembly](#assembly) (2 results) (Informational)
 - [naming-convention](#naming-convention) (3 results) (Informational)
## assembly

> Used by  ERC-7201

Impact: Informational
Confidence: High
 - [ ] ID-0
	[TERC721Upgradeable._getTERC721UpgradeableStorage()](src/TERC721Upgradeable.sol#L136-L144) uses assembly
	- [INLINE ASM](src/TERC721Upgradeable.sol#L141-L143)

src/TERC721Upgradeable.sol#L136-L144


 - [ ] ID-1
	[TERC721UpgradeableMint._getTERC721UpgradeableMintStorage()](src/lib/upgradeable/TERC721UpgradeableMint.sol#L150-L158) uses assembly
	- [INLINE ASM](src/lib/upgradeable/TERC721UpgradeableMint.sol#L155-L157)

src/lib/upgradeable/TERC721UpgradeableMint.sol#L150-L158

## naming-convention

> Acknolwedge

Impact: Informational
Confidence: High
 - [ ] ID-2
Constant [TERC721Upgradeable.TERC721UpgradeableStorageLocation](src/TERC721Upgradeable.sol#L23-L24) is not in UPPER_CASE_WITH_UNDERSCORES

src/TERC721Upgradeable.sol#L23-L24


 - [ ] ID-3
Function [TERC721Upgradeable.__TERC721Upgradeable_init_unchained(address,string)](src/TERC721Upgradeable.sol#L48-L54) is not in mixedCase

src/TERC721Upgradeable.sol#L48-L54


 - [ ] ID-4
Constant [TERC721UpgradeableMint.TERC721UpgradeableMintStorageLocation](src/lib/upgradeable/TERC721UpgradeableMint.sol#L24-L25) is not in UPPER_CASE_WITH_UNDERSCORES

src/lib/upgradeable/TERC721UpgradeableMint.sol#L24-L25

