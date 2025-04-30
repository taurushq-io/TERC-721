## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./module/standalone/TERC721StandaloneMint.sol | c37442a4d3478778cdae3550f3bf18c0f3df4f8b |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC721StandaloneMint** | Implementation | ERC721, AccessControl, TERC721ShareMint |||
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


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
