**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [assembly](#assembly) (1 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
## assembly

> Used by  ERC-7201

Impact: Informational
Confidence: High
 - [ ] ID-0
	[TERC721Upgradeable._getTERC721UpgradeableStorage()](src/TERC721Upgradeable.sol#L253-L261) uses assembly
	- [INLINE ASM](src/TERC721Upgradeable.sol#L258-L260)

src/TERC721Upgradeable.sol#L253-L261

## naming-convention

> Acknolwedge

Impact: Informational
Confidence: High
 - [ ] ID-1
Constant [TERC721Upgradeable.TERC721UpgradeableStorageLocation](src/TERC721Upgradeable.sol#L17-L18) is not in UPPER_CASE_WITH_UNDERSCORES

src/TERC721Upgradeable.sol#L17-L18


 - [ ] ID-2
Function [TERC721Upgradeable.__TERC721Upgradeable_init_unchained(address,string)](src/TERC721Upgradeable.sol#L45-L51) is not in mixedCase

src/TERC721Upgradeable.sol#L45-L51

