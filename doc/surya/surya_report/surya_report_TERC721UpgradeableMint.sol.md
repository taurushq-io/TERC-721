## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./module/upgradeable/TERC721UpgradeableMint.sol | 84f979990a16be636f84c8a920b802807a46c5ca |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC721UpgradeableMint** | Implementation | ERC721Upgradeable, AccessControlUpgradeable, TERC721ShareMint |||
| └ | mintTokenId | Public ❗️ | 🛑  | onlyRole |
| └ | batchMintTokenIds | Public ❗️ | 🛑  | onlyRole |
| └ | batchMintTokenIds | Public ❗️ | 🛑  | onlyRole |
| └ | nextTokenId | Public ❗️ |   |NO❗️ |
| └ | setNextTokenId | Public ❗️ | 🛑  | onlyRole |
| └ | mint | Public ❗️ | 🛑  | onlyRole |
| └ | batchMint | Public ❗️ | 🛑  | onlyRole |
| └ | batchMint | Public ❗️ | 🛑  | onlyRole |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _mintAndEvent | Internal 🔒 | 🛑  | |
| └ | _getTERC721UpgradeableMintStorage | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
