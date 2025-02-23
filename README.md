## TERC-20

This project contains two basic ERC-721 tokens:

- `TERC721Standalone` for an immutable deployment, without proxy
- `TERC721Upgradeable` for an upgradeable deployment, with a compatible proxy (Transparent or Beacon)

## Common characteristics

These ERC-721 tokens have the following characteristics:

**Mint**

- A mint function only accessible with the MINTER role

- A mint batch function only accessible with the MINTER role

**Burn**

- A burn function only accessible with the BURNER role
- A burn in batch function only accessible with the BURNER role

**ERC721**

- At deployment, the issuer can set the name, symbol and the baseURI

- Once deployed, it is no longer possible to modify the name and symbol except via an upgrade in the case of the proxy. A setter function is available to set the baseURI again.

## Access Control

There are three roles: MINTER_ROLE, BURNER_ROLE and DEFAULT_ADMIN_ROLE

The DEFAULT_ADMIN_ROLE has all the roles by default

## Schema

### TERC721Standalone

#### Inheritance

![surya_inheritance_TERC721Standalone.sol](./doc/surya/surya_inheritance/surya_inheritance_TERC721Standalone.sol.png)

#### Graph

![surya_graph_TERC721Standalone.sol](./doc/surya/surya_graph/surya_graph_TERC721Standalone.sol.png)



### TERC721 Upgradeable

#### Inheritance

![surya_inheritance_TERC721Upgradeable.sol](./doc/surya/surya_inheritance/surya_inheritance_TERC721Upgradeable.sol.png)

#### Graph

![surya_graph_TERC721Upgradeable.sol](./doc/surya/surya_graph/surya_graph_TERC721Upgradeable.sol.png)

## Surya Description Report

### Contracts Description Table

#### TERC721Standalone

|       Contract        |       Type        |                Bases                |                |               |
| :-------------------: | :---------------: | :---------------------------------: | :------------: | :-----------: |
|           └           | **Function Name** |           **Visibility**            | **Mutability** | **Modifiers** |
|                       |                   |                                     |                |               |
| **TERC721Standalone** |  Implementation   | TERC721Share, AccessControl, ERC721 |                |               |
|           └           |   <Constructor>   |              Public ❗️               |       🛑        |    ERC721     |
|           └           |       mint        |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |     mintBatch     |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |     mintBatch     |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |       mint        |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |     mintBatch     |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |     mintBatch     |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |       burn        |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |     burnBatch     |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |    setBaseURI     |              Public ❗️               |       🛑        |   onlyRole    |
|           └           |      baseURI      |              Public ❗️               |                |      NO❗️      |
|           └           |    _setBaseURI    |             Internal 🔒              |       🛑        |               |
|           └           |     _baseURI      |             Internal 🔒              |                |               |
|           └           |   _mintAndEvent   |             Internal 🔒              |       🛑        |               |
|           └           | supportsInterface |              Public ❗️               |                |      NO❗️      |
|           └           |      hasRole      |              Public ❗️               |                |      NO❗️      |

#### TERC721Upgradeable

|        Contract        |                Type                 |                            Bases                             |                |                  |
| :--------------------: | :---------------------------------: | :----------------------------------------------------------: | :------------: | :--------------: |
|           └            |          **Function Name**          |                        **Visibility**                        | **Mutability** |  **Modifiers**   |
|                        |                                     |                                                              |                |                  |
| **TERC721Upgradeable** |           Implementation            | Initializable, ERC721Upgradeable, AccessControlUpgradeable, TERC721Share |                |                  |
|           └            |            <Constructor>            |                           Public ❗️                           |       🛑        |       NO❗️        |
|           └            |             initialize              |                           Public ❗️                           |       🛑        |   initializer    |
|           └            | __TERC721Upgradeable_init_unchained |                          Internal 🔒                          |       🛑        | onlyInitializing |
|           └            |                mint                 |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |              mintBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |              mintBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |                mint                 |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |              mintBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |              mintBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |                burn                 |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |              burnBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |             setBaseURI              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └            |               baseURI               |                           Public ❗️                           |                |       NO❗️        |
|           └            |             _setBaseURI             |                          Internal 🔒                          |       🛑        |                  |
|           └            |              _baseURI               |                          Internal 🔒                          |                |                  |
|           └            |            _mintAndEvent            |                          Internal 🔒                          |       🛑        |                  |
|           └            |               hasRole               |                           Public ❗️                           |                |       NO❗️        |
|           └            |          supportsInterface          |                           Public ❗️                           |                |       NO❗️        |
|           └            |    _getTERC721UpgradeableStorage    |                          Private 🔐                           |                |                  |

### Legend

| Symbol | Meaning                   |
| :----: | ------------------------- |
|   🛑    | Function can modify state |
|   💵    | Function is payable       |



## Dependencies

The toolchain includes the following components, where the versions are the latest ones that we tested:

- Foundry
- Solidity 0.8.28 (via solc-js)
- OpenZeppelin Contracts (submodule) [v5.2.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.2.0)
- OpenZeppelin Contracts upgradeable (submodule) [v5.2.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.2.0)

## Audit

See [slither](./doc/audit/tool/slither-report.md)

## Tools

### Prettier

```bash
npx prettier --write --plugin=prettier-plugin-solidity 'src/**/*.sol'
```

```bash
npx prettier --write --plugin=prettier-plugin-solidity 'test/**/*.sol'
```

### Slither

```bash
slither .  --checklist --filter-paths "openzeppelin-contracts|openzeppelin-contracts-upgradeable|test|forge-std" > slither-report.md
```

### Surya

See [./doc/script](./doc/script)

### Foundry

Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Usage

*Explain how it works.*


### Toolchain installation

The contracts are developed and tested with [Foundry](https://book.getfoundry.sh), a smart contract development toolchain.

To install the Foundry suite, please refer to the official instructions in the [Foundry book](https://book.getfoundry.sh/getting-started/installation).

### Initialization

You must first initialize the submodules, with

```bash
forge install
```

See also the command's [documentation](https://book.getfoundry.sh/reference/forge/forge-install).

Later you can update all the submodules with:

```bash
forge update
```

See also the command's [documentation](https://book.getfoundry.sh/reference/forge/forge-update).

### Compilation

The official documentation is available in the Foundry [website](https://book.getfoundry.sh/reference/forge/build-commands) 

```bash
 forge build
```

### Testing

You can run the tests with

```bash
forge test
```

To run a specific test, use

```bash
forge test --match-contract <contract name> --match-test <function name>
```

See also the test framework's [official documentation](https://book.getfoundry.sh/forge/tests), and that of the [test commands](https://book.getfoundry.sh/reference/forge/test-commands).

### Coverage

* Perform a code coverage

```bash
forge coverage
```

* Generate LCOV report

```bash
forge coverage --report lcov
```

- Generate `index.html`

```bash
forge coverage --ffi --report lcov && genhtml lcov.info --branch-coverage --output-dir coverage
```

See [Solidity Coverage in VS Code with Foundry](https://mirror.xyz/devanon.eth/RrDvKPnlD-pmpuW7hQeR5wWdVjklrpOgPCOA-PJkWFU) & [Foundry forge coverage](https://www.rareskills.io/post/foundry-forge-coverage)

### Documentation

[https://book.getfoundry.sh/](https://book.getfoundry.sh/)



## Intellectual property

The original code is copyright (c) Taurus 2025, and is released under [MIT license](https://github.com/taurushq-io/tg-bridge-contracts-CCIP/blob/main/LICENSE).
