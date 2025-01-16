## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./TERC721Upgradeable.sol | 46c66935ee7f33eecc473711c32e17530d919af8 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC721Upgradeable** | Implementation | Initializable, ERC721Upgradeable, AccessControlUpgradeable, TERC721Share |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | initialize | Public ❗️ | 🛑  | initializer |
| └ | __TERC721Upgradeable_init_unchained | Internal 🔒 | 🛑  | onlyInitializing |
| └ | mint | Public ❗️ | 🛑  | onlyRole |
| └ | mintBatch | Public ❗️ | 🛑  | onlyRole |
| └ | mintBatch | Public ❗️ | 🛑  | onlyRole |
| └ | burn | Public ❗️ | 🛑  | onlyRole |
| └ | burnBatch | Public ❗️ | 🛑  | onlyRole |
| └ | setBaseURI | Public ❗️ | 🛑  | onlyRole |
| └ | baseURI | Public ❗️ |   |NO❗️ |
| └ | _setBaseURI | Internal 🔒 | 🛑  | |
| └ | _baseURI | Internal 🔒 |   | |
| └ | hasRole | Public ❗️ |   |NO❗️ |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | _getTERC721UpgradeableStorage | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
