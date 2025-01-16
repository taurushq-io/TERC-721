## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./TERC721Standalone.sol | 5239caa08744bd409d5f40600c8b6d09c1574154 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC721Standalone** | Implementation | TERC721Share, AccessControl, ERC721 |||
| └ | <Constructor> | Public ❗️ | 🛑  | ERC721 |
| └ | mint | Public ❗️ | 🛑  | onlyRole |
| └ | mintBatch | Public ❗️ | 🛑  | onlyRole |
| └ | mintBatch | Public ❗️ | 🛑  | onlyRole |
| └ | burn | Public ❗️ | 🛑  | onlyRole |
| └ | burnBatch | Public ❗️ | 🛑  | onlyRole |
| └ | setBaseURI | Public ❗️ | 🛑  | onlyRole |
| └ | baseURI | Public ❗️ |   |NO❗️ |
| └ | _setBaseURI | Internal 🔒 | 🛑  | |
| └ | _baseURI | Internal 🔒 |   | |
| └ | supportsInterface | Public ❗️ |   |NO❗️ |
| └ | hasRole | Public ❗️ |   |NO❗️ |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
