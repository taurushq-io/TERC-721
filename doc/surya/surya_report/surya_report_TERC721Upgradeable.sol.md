## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./TERC721Upgradeable.sol | 6be43220e08419bbe9776eb8a06e9b829856b93a |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC721Upgradeable** | Implementation | Initializable, TERC721Share, TERC721UpgradeableBurn, TERC721UpgradeableMint |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | initialize | Public ❗️ | 🛑  | initializer |
| └ | __TERC721Upgradeable_init_unchained | Internal 🔒 | 🛑  | onlyInitializing |
| └ | setBaseURI | Public ❗️ | 🛑  | onlyRole |
| └ | baseURI | Public ❗️ |   |NO❗️ |
| └ | hasRole | Public ❗️ |   |NO❗️ |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _setBaseURI | Internal 🔒 | 🛑  | |
| └ | _baseURI | Internal 🔒 |   | |
| └ | _getTERC721UpgradeableStorage | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
