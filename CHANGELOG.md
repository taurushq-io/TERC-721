# CHANGELOG

Please follow <https://changelog.md/> conventions.

## Checklist

> Before a new release, perform the following tasks

- Code: Update the version name in [TERC721Share](./src/module/TERC721Share.sol), variable VERSION
- Run linter (prettier)

- Documentation
  - Perform a code coverage and update the files in the corresponding directory [./doc/coverage](./doc/coverage)
  - Perform an audit with several audit tools (Mythril, Slither, Aderyn, etc), update the report in the corresponding directory [./doc/audits/tool](./doc/audit/tool)
  - Update surya doc by running the 3 scripts in [./doc/script](./doc/script)
  - Update changelog

## 1.0.0

- Add function `version` to return contract version to use the same name as [ERC-3643](https://eips.ethereum.org/EIPS/eip-3643) and TERC-20
- Rename functions `burnBatch`, `mintBatch`and their corresponding events in `batchBurn`, `batchMint` to use the same name as [ERC-3643](https://eips.ethereum.org/EIPS/eip-3643) and TERC-20
- Adding the suffix `TokenId` to overloading functions `mint`and `batchMint` when they take a `tokenId`in argument
- Separate Burn and Mint features from the main contract.
- Add functions `setNextTokenId`and  `nextTokenId`to set and fetch the value of `nextTokenId`
- Emit `BatchMetadataUpdate`(ERC-4906) when the baseURI is updated to refresh token metadata.
- Update OpenZeppelin library to version [v5.3.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.3.0)

## 0.2.0

- Add {`mint`, `mintBatch`} with `tokenId` as  parameter
- TERC721Upgradeable: optimize `mintBatch`

## 0.1.0 - 01292025

First release !
