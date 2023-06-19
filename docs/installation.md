# Installation guide

# Contents

1. Get started
    - 1.1. Verify the `qredochain` binary
    - 1.2. Run `qredochain` from binary    
2. Deploy your node
    - 2.1. Option 1: Deploy with an Ansible role
        - 2.1.1. Overview
        - 2.1.2. Environment variables
        - 2.1.3. Install a Qredochain validator
        - 2.1.4. What the Ansible role will produce
    - 2.2. Option 2: Deploy with Docker Compose
        - 2.2.1. Verify the Docker image
        - 2.2.2. Install Docker and Docker Compose
        - 2.2.3. `docker-compose.yml` and `.env`
        - 2.2.4. Run Docker Compose
        - 2.2.5. Results
    - 2.3. Verify the Docker image
3. Activate your validator
    - 3.1. Create your wallet
        - 3.1.1. Option 1: Create your wallet in the Qredo Web App
        - 3.1.2. Option 2: Create your wallet with the Qredochain CLI
    - 3.2. Extract the validator public key
    - 3.3. Validator activation ceremony
4.  Monitor your reward wallet

# 1. Get started

Getting started is straightforward. You can download, install, and spin up a non-validator on Qredo Network in a matter of minutes!

The fastest option is running `qredochain` on the host directly with the binary:

## 1.1. Verify the `qredochain` binary

All the binaries that we create are signed securely. In case Qredo binaries need to be checked independently, take the following steps:

1. Install the [openssl command-line tool](https://www.openssl.org/source/) in your environment.

2. Download the binary and signature file, which has the same name ending with `.sig`.

3. Save the Qredo binary signing public key locally into a file (for example, `qredo.signing.pub`):

    ```
    -----BEGIN PUBLIC KEY-----
    MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEEZl2gpFHPFTC3QPXQTp83JlmNxqvSRHT
    Abd5hsWy1o4ELd8xOSqXmXo1eRsB429Db/kZQVF0KBo5eJONM2PBofBwV7w5qQMd
    ZKRrlMl3PJ5A6JqzNXNRbA/e1vgbGAHw
    -----END PUBLIC KEY-----
    ```

4. Verify the binary and signature against the public key and expect a success message:
    ```bash
    openssl dgst -sha256 -verify qredo.signing.pub -signature qredochain.X.tar.gz.sig qredochain.X.tar.gz
    ```

## 1.1. Run `qredochain` from binary

To run `qredochain` from binary, take the following steps:

1. Download the `qredochain` install script.
2. Create the `$HOME/.qredochain/mainnet` folder.
3. Create a `qredochain` `systemd` service.
4. Execute `qredochain init --network mainnet --snapshot --password $PWD` to configure your node and download the database from the latest database checkpoint. Alternatively, run it without the `--snapshot` command if you wish to sync your node from scratch. For access to the snapshot password please contact the Qredo team.
5. Execute `qredochain start --network mainnet`. Your node should connect to peers and begin syncing the latest blocks. If the snapshot download was successful, the sync to the chain tip should take under a minute. If no snapshot is used, a node synchronization can take up to 72 hours.
6. Once connections are made to public sentry peers, your node should begin downloading blocks to synchronize its blockchain:  

    ```bash
    {"level":"info","message":"Initialising Qredochain","service":"qredochain","time":"2023-06-16T09:38:06","version":"v1.10.7-37b41760"}
    I[2023-06-16|09:38:06.289] Completed ABCI Handshake - Tendermint and App are synced module=consensus appHeight=0 appHash=
    I[2023-06-16|09:38:06.289] Version info                                 tendermint_version=0.34.14 block=11 p2p=8
    I[2023-06-16|09:38:06.289] This node is not a validator                 module=consensus addr=0F9ADA18DC1D0719544C088D1A403BDB857BE623 pubKey=PubKeyEd25519{5406C198E465107689F839F2C62D550DC2D0DD14D3BD33786CE916EEB06E603B}
    I[2023-06-16|09:38:06.296] P2P Node ID                                  module=p2p ID=c09b24e49e8ef951d31adeeb5ee9c9abce776896 file=/home/alex/.qredochain/testnet/config/node_key.json
    I[2023-06-16|09:38:06.296] Adding persistent peers                      module=p2p addrs="[a7ddd8f930ac6052c91ac5c644c5c5a688c0998e@sentries.testnet.qredo.network:26656 aba0cee06cb353b55d1e358c9236dc736c7d1f9c@sentries.testnet.qredo.network:36656]"
    I[2023-06-16|09:38:06.363] Adding unconditional peer ids                module=p2p ids=[]
    I[2023-06-16|09:38:06.363] Add our address to book                      module=p2p book=/home/alex/.qredochain/testnet/config/addrbook.json addr=c09b24e49e8ef951d31adeeb5ee9c9abce776896@0.0.0.0:26656
    I[2023-06-16|09:38:06.363] Successfully built new Tendermint node       
    {"level":"info","listenAddress":"tcp://0.0.0.0:26657","message":"Tendermint node parameters","nodeInfo":{"protocol_version":{"p2p":8,"block":11,"app":0},"id":"c09b24e49e8ef951d31adeeb5ee9c9abce776896","listen_addr":"tcp://0.0.0.0:26656","network":"testnet","version":"0.34.14","channels":"40202122233038606100","moniker":"alex-XPS-13-7390","other":{"tx_index":"on","rpc_address":"tcp://0.0.0.0:26657"}},"qredochainAppInfo":null,"service":"qredochain","time":"2023-06-16T09:38:06","version":"v1.10.7-37b41760"}
    I[2023-06-16|09:38:06.364] Starting Node service                        impl=Node
    I[2023-06-16|09:38:06.364] Starting RPC HTTP server on [::]:26657       module=rpc-server 
    I[2023-06-16|09:38:06.365] Starting P2P Switch service                  module=p2p impl="P2P Switch"
    I[2023-06-16|09:38:06.365] Starting Mempool service                     module=mempool impl=Mempool
    I[2023-06-16|09:38:06.365] Starting BlockchainReactor service           module=blockchain impl=BlockchainReactor
    I[2023-06-16|09:38:06.365] Starting BlockPool service                   module=blockchain impl=BlockPool
    I[2023-06-16|09:38:06.365] Starting Consensus service                   module=consensus impl=ConsensusReactor
    I[2023-06-16|09:38:06.365] Reactor                                      module=consensus waitSync=true
    I[2023-06-16|09:38:06.365] Starting Evidence service                    module=evidence impl=Evidence
    I[2023-06-16|09:38:06.365] Starting StateSync service                   module=statesync impl=StateSync
    I[2023-06-16|09:38:06.365] Starting PEX service                         module=pex impl=PEX
    I[2023-06-16|09:38:06.365] Starting AddrBook service                    module=p2p book=/home/alex/.qredochain/testnet/config/addrbook.json impl=AddrBook
    I[2023-06-16|09:38:06.365] Ensure peers                                 module=pex numOutPeers=0 numInPeers=0 numDialing=0 numToDial=10
    I[2023-06-16|09:38:06.365] No addresses to dial. Falling back to seeds  module=pex 
    I[2023-06-16|09:38:06.402] Saving AddrBook to file                      module=p2p book=/home/alex/.qredochain/testnet/config/addrbook.json size=2
    INFO[0000] Qredochain Prometheus custom metrics are disabled in testnet  service=qredochain version=v1.10.7-37b41760
    {"level":"info","message":"MPCServerStarted","port":8000,"service":"qredochain","time":"2023-06-16T09:38:06","version":"v1.10.7-37b41760"}
    I[2023-06-16|09:38:07.815] Dialing peer                                 module=p2p address=a7ddd8f930ac6052c91ac5c644c5c5a688c0998e@63.34.69.221:26656
    I[2023-06-16|09:38:07.910] Starting Peer service                        module=p2p peer=a7ddd8f930ac6052c91ac5c644c5c5a688c0998e@63.34.69.221:26656 impl="Peer{MConn{63.34.69.221:26656} a7ddd8f930ac6052c91ac5c644c5c5a688c0998e out}"
    I[2023-06-16|09:38:07.910] Starting MConnection service                 module=p2p peer=a7ddd8f930ac6052c91ac5c644c5c5a688c0998e@63.34.69.221:26656 impl=MConn{63.34.69.221:26656}
    I[2023-06-16|09:38:07.910] Added peer                                   module=p2p peer="Peer{MConn{63.34.69.221:26656} a7ddd8f930ac6052c91ac5c644c5c5a688c0998e out}"
    I[2023-06-16|09:38:08.356] executed block                               module=state height=1 num_valid_txs=0 num_invalid_txs=0
    {"appHash":"0000000000000000000000000000000000000000000000000000000000000000","blockHeight":1,"commitCount":0,"level":"info","message":"commitBlock","prevAppHash":"0000000000000000000000000000000000000000000000000000000000000000","service":"qredochain","size":0,"time":"2023-06-16T09:38:08","txCount":0,"version":"v1.10.7-37b41760"}
    I[2023-06-16|09:38:08.365] committed state                              module=state height=1 num_txs=0 app_hash=0000000000000000000000000000000000000000000000000000000000000000
    ```
7. Once your node has completed the download, it will switch to `consensus reactor` mode, indicating that synchronization is complete:

    ```bash
    I[2023-06-16|09:54:58.954] Time to switch to consensus reactor!         module=blockchain height=671
    ```
   
    The node is now ready to begin accepting new transactions via RPC.

# 2. Deploy your node

There are many ways to deploy `qredochain`. We recommend one of the following two methods:

- Using an Ansible role
- Using Docker Compose

Deployment impacts the performance and reliability of your validator, so it's important that you get it right.

## 2.1. Option 1: Deploy with an Ansible role

## 2.1.1. Overview

```
├── env
│   ├── mainnet
│   │   ├── group_vars
│   │   │   └── all.yml                        # Mainnet variables. They are used when you need to run a mainnet Qredochain validator.
│   │   └── hosts.yaml                         # Used to configure host connections.
│   └── testnet
│       ├── group_vars
│       │   └── all.yml                        # Testnet variables. They are used when you need to run a testnet Qredochainvalidator.
│       └── hosts.yaml                         # Used to configure host connections.
├── qredochain-node.yaml
└── role
    └── qredochain
        ├── README.md
        ├── defaults
        │   └── main.yml                       # Default variables.
        ├── files
        │   └── pub.pem                        # The public key used to verify the signature.
        ├── handlers
        │   └── main.yml                       # A handler for reloading the systemd service.
        ├── meta
        │   └── main.yml
        ├── tasks
        │   ├── download_qredochain.yml
        │   ├── init_qredochain.yml
        │   ├── init_user.yml
        │   ├── install_dependencies.yml
        │   ├── main.yml
        │   └── systemd.yml
        ├── templates
        │   └── systemd.j2
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml
```

### 2.1.2. Environment variables

- MAINNET - all variables are located in `env/mainnet/group_vars/all.yml`
- TESTNET - all variables are located in `env/testnet/group_vars/all.yml`

-----------------------------------------------------------------------------------------------
|           NAME            |     Description                                                  |
|---------------------------|------------------------------------------------------------------|
| env                       | The name of the environment.                                     |
| qredochain_version        | The version of qredochain .                                      |
| qredochain_file_short_sha | Used with the version to target a specific build .               |
| qredochain_file_sufix     | The suffix of the files.                                         |
| qredochain_sig_file_sifux | The suffix of the signature file.                                |
| qredochain_release_url    | The public github release repository.                            |
| qredochain_snapshot_auth  | Used by qredochain to authenticate to the snapshot endpoint.     |
| qredochain_sentry_endpoint| Used to configure the `persistent_peers` value of `qredochain`.  |
| qredochain_peer_1_port    | The TPC port of the peer 1. Used for configuring `qredochain`.   |
| qredochain_peer_1_id      | The P2P address of the peer 1. Used for configuring `qredochain`.|
| qredochain_peer_2_port    | The TPC port of the peer 2. Used for configuring `qredochain`.   |
| qredochain_peer_2_id      | The P2E address of the peer 2. Used for configuring `qredochain`.| 
-----------------------------------------------------------------------------------------------

### 2.1.3. Install a Qredochain validator

**Note:** Currently the role supports only the **ubuntu 20.04** operation system.

To install a Qredochain validator with an Ansible role, take the following steps:

1. Configure MAINNET or TESTNET variables. You need to set the ip addresses or hostnames to the target hosts.

   The variables are located in `env/{mainnet,testnet}/hosts.yml`. 

2. Run the playbook:

    ```
    cd ansible
    ansible-playbook -i env/{mainnet,testnet}/ qredochain-node.yaml
    ```
### 2.1.4. What the Ansible role will produce

- `/opt/qredochain`: The `qredochain` home directory.
- `//opt/qredochain/tmp`: A temporary directory used to store downloads and the public key for signing verification.
- `//opt/qredochain/.qredochain/{testnet,mainnet}/config/config.toml`: The `qredochain`/tendermint config file.
- `//etc/systemd/system/qredochain.service.d/`: Content `systemd` configuration for `qredochain`.

## 2.2. Option 2: Deploy with Docker Compose

**IMPORTANT:** All the files related to how to deploy `qredochain` with Docker Compose should be treated only as templates. This means that they can be used as examples, but never as a final version that can already be used.

## 2.2.1. Verify the Docker image

Like Qredochain signed binaries described above, Qredo Docker images are also signed.

Any Docker image downloaded from our public Docker repository should be verified following the steps below:

1. Install the [Cosign](https://docs.sigstore.dev/cosign/installation/) tool (version 2 and above).

2. Download the Docker image:
  
    ```bash
    docker pull qredohub/qredochain:X
    ```

3. Save the Qredo Cosign signing public key locally into a file (for example, `qredo.cosign.pub`):

    ```
    -----BEGIN PUBLIC KEY-----
    MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEAWHvuj3ispOtnsa/5JVZvBUz/w9V
    rvbQMwn+iKkF33Bh+k/mqXpl9MiMR8cmwkaapm4czLUpRF5Wx0kaHBuEJg==
    -----END PUBLIC KEY-----
    ```

4. Verify the Docker image and signature against the public key and expect a success message:

    ```bash
    cosign verify --key qredo.cosign.pub qredohub/qredochain:X
    ```

### 2.2.2. Install Docker and Docker Compose

Docker Compose is a tool that allows you to define and manage multi-container Docker applications. It provides a way to describe the configuration of multiple Docker containers, their dependencies, networks, and volumes, all in a single file  — `docker-compose.yml`.

In order to run `qredochain` with Docker Compose, you need to meet the following prerequisites:

- **Docker CLI:** A command-line interface for managing Docker.
- **Docker Engine:** A runtime environment for running Docker containers.
- **Docker Compose:** A command-line tool.

See Docker documentation to learn more:

- [How to install Docker Engine on Linux (Ubuntu, Debian, etc.)](https://docs.docker.com/engine/install/)
- [How to install Docker Compose on Linux (Ubuntu, Debian, etc.)](https://docs.docker.com/compose/install/linux/)

### 2.2.3. `docker-compose.yml` and `.env`

The deployment of `qredochain` with Docker Compose is done with two files:

- `docker-compose.yml`: A file where the container, ports, volumes, etc. are defined.
- `.env`: A file where the environment variables used in `docker-compose.yml` are defined.

This section provides details about these two files.

#### `docker-compose.yml`

**IMPORTANT:** You shouldn't update this file. All the parameters you can adjust are defined as variables in the `.env` file.

Here are some important fields in `docker-compose.yml`:

- **image:** The qredochain docker image that will be used on the Docker container.
- **command:** The `start` command and its parameters used to start the `qredochain` binary inside the Docker container.
- **ports:** The mapping between the host port (the number on the left of the colon), and the Docker container port (number on the right).
  - `26656`: Used for peering incoming connections. The node where the Docker container runs should have this port publicly exposed.
  - `26657`: Used for the RPC server to listen on.
  - `26660`: If metrics are enabled, this port is used for Prometheus collectors connections.
- **volumes:** The mapping between a directory on the host (path on the left of the colon) and a directory on the Docker container (path on the right of the colon).

#### `.env`

This file contains all the variables used for definitions in the **docker-compose.yml** file:

- `QREDOCHAIN_TAG`: Used to define the TAG for the Qredochain Docker image. For instance `vX.XX.XX`.
- `NETWORK`: It's the network where the `qredochain` will work. For instance `testnet` or `mainnet`.
- `SNAPSHOTS_PASSWORD`: It's the base64-encoded value for the username and password used to retrieve the snapshots.
- `LOCAL_DATA_DIR`: It's the path to a directory on the host where the Docker container runs in order to persist the data saved by the `qredochain` container.

### 2.2.4. Run Docker Compose

To run Docker Compose, take the following steps:

1. Open a terminal and go to the directory where the `docker-compose.yml` and `.env`files are located.
2. Update the `.env` file with the values for all the variables (see the previous section).
3. If the docker daemon is running as a different user (which is usually the case), then run the command `mkdir -p <local_data_dir>`. You need to specify `local_data_dir`: the value of the variable `LOCAL_DATA_DIR` in the `.env` file.
4. Run the following command: `docker-compose up -d`. This will start the Docker container named `qredochain`. The `-d` parameter allows running the container on background.
5. Run the following command to check the **status** of the container: `docker ps -a | grep qredochain`. The status should be `Running`.
6. Run the following command to check the **logs** of the container: `docker logs qredochain -f`.

### 2.2.5. Results

Running `qredochain` will create the following files and subdirectories in the `LOCAL_DATA_DIR` folder:

```yaml
├── docker-compose.yml
├── $LOCAL_DATA_DIR
│   ├── badger
│   ├── config
│   │   ├── addrbook.json
│   │   ├── config.toml
│   │   ├── genesis.json
│   │   ├── node_key.json
│   │   └── priv_validator_key.json
│   ├── data
│   │   ├── blockstore.db
│   │   ├── cs.wal
│   │   ├── evidence.db
│   │   ├── priv_validator_state.json
│   │   ├── state.db
│   │   └── tx_index.db
│   ├── qredochain.yml
│   └── txfetcher.yml
└── .env
```

# 3. Activate your validator

Once your node has synchronized to the chain tip, you're ready to activate your validator.

## 3.1. Create your wallet

There are two ways to create your wallet:

- Using the Qredo Web App (recommended)
- Using the Qredochain command-line tool

We recommend using our Web App since it's the fastest way to create a wallet in Qredo.

### 3.1.1. Option 1: Create your wallet in the Qredo Web App

1. Create an account in the [Qredo Web App](https://qredo.network/app).
2. Create a Fund or a Workspace defining the custody policy you want to govern wallets inside the workspace
3. Within the fund create a QRDO wallet (GOERLI_QRDO if on testnet).
4. Find and note down the **deposit address** of your QRDO wallet.

### 3.1.2. Option 2: Create your wallet with the Qredochain CLI

You can read the Qredochain command line documentation here:

- [Qredochain CLI: README](https://github.com/qredo/qredochain-cli/blob/main/README.md?pvs=21)
- [Qredochain CLI: Overview and features](https://www.notion.so/QC-CLI-PRD-5c6a34df2d9249988b80fb4b6206b63a?pvs=21)


To create your wallet with this tool, take the following steps:

1. Download the `qredochain-cli` from [GitHub](https://github.com/qredo/qredochain-cli) or build from source. The CLI will be installed as `qrdo`.

    ```bash
    $ git clone git@github.com:qredo/qredochain-cli.git
    $ cd qredochain-cli/cmd/qrdo
    $ go build
    $ sudo mv qrdo /usr/local/bin
    
    ```
    
2. Generate your 24-word mnemonic seed phrase and write the output to `seed.txt`:

    ```bash
    $ qrdo generate-seed > seed.txt
    $ cat seed.txt
    > tyre apple stock throw .... this
    ```
    
    **IMPORTANT:** Physically write down your mnemonic seed phrase. The Qredo Network can't recover your seed phrase, so validator assets are at risk if the seed phrase is lost or compromised.

3. Create you bls_key.json file
    ```bash
    $ qrdo recover --in seed.txt --out bls-key.json
    ```
   
    A `bls-key.json` file will be created locally, containing you seed, private key and public key

    ```bash
    $ cat bls-key.json 
    {
      "publicKey": "06d4a5e587278511f408d23d9b4a65b62b449de12cb41d98f908ecd89a1905e02bd7ef9008f71d4c194b8b789eea27b716c1201d8a645e253619397b2da08ff1cb42d406953d6fac7a2052a6dc7e27241cf77878e8650ffe4518db9ba75ca6b20715f43fa8f5d477bdc2aaf1518d39995821b135221b68ba5dc3c0df585182d8ab32f5dea362ad824c1d23c71aa3855610e2d3544946b9badbe900197cf66dada0a14628e77a7e48b41c0c0c4bc736047e539cdde79342dcc5c664d9ce97b47e",
      "privateKey": "000000000000000000000000000000005adbe3edaab9af6721b2263223699a782f57c4fcc32828b1b3f9b958b7a1d656",
      "seed": "88309047a2c01afaca256cabe075e76204767b966ea1f6504969d93ca0b9929ba752c4ecfb28f64c5a51a25f8a1b13a6d600941fbb383aff88eade08b9f1efaa",
      "mnemonic": "garage hurdle purity visual next kidney veteran depend hand hood season coyote story ramp hip deer below embark tourist cinnamon fragile panda lesson dignity"
    }
    ```

4. Once your node is fully synchronized (see 2.1, step 6), you can create and push your IDDoc using your `bls-key.json` file:

    ```bash
    $ qrdo create-iddoc --reference "validator-<name>" --in seed.txt --endpoint=<node-endpoint>
    ```

    The `<node-endpoint>` is the address exposed by your node for RPC requests e.g. `127.0.0.1:26657`.

5. Use your IDDoc to create a QRDO wallet. If working on the Qredo testnet create a GOERLI_QRDO wallet:

    ```bash
    $ qrdo create-wallet --endpoint=<node-endpoint> --coin QRDO --bls-file bls-key.json
    > 5b249883e4bde832032a9007ccd2ac678b176eadcd7b9c7014004b562b30343e
    ```

    (testnet)

    ```bash
    $ qrdo create-wallet --endpoint=<node-endpoint>  --coin GOERLI_QRDO --bls-file bls-key.json
    > 727e9ddb2cdcc201122891803eae737bc737e99e0c3e0e514938df91cd5b2d1d
    ```
  
6. Obtain the deposit address for the validator wallet:
  
    ```bash
    $ qrdo deposit-address --deposit-address=<wallet-id> --endpoint=<node-endpoint> 
    > 0x6A1B9033647CdEFaA39Aed8295f8724E87AE161d
    ```

    **IMPORTANT:** Only deposit QRDO (or GOERLI_QRDO for testnet) to this address ON THE ETHEREUM NETWORK. Depositing any other asset will result in permanent loss.

## 3.2. Extract the validator public key

1. To extract the validator public key, make a status request to the Qredochain node:
  
    ```bash
    $ curl localhost:26657/status
    ```

2. You will get the following response:

    ```json
    {
      "jsonrpc": "2.0",
      "id": -1,
      "result": {
        "node_info": {
          "protocol_version": {
            "p2p": "8",
            "block": "11",
            "app": "0"
          },
          "id": "8d3e8d147ae98362217579bea327229576554a40",
          "listen_addr": "tcp://0.0.0.0:26656",
          "network": "qredo-mainnet-v2",
          "version": "0.34.14",
          "channels": "40202122233038606100",
          "moniker": "alex-XPS-13-7390",
          "other": {
            "tx_index": "on",
            "rpc_address": "tcp://0.0.0.0:26657"
          }
        },
        "sync_info": {
          "latest_block_hash": "12DE9D87D2D5F66B7A2F7B1EC30A1B51FE4E25AE008DFCC5D948B06027CCC426",
          "latest_app_hash": "A6758A6DB4CF1FD523D368C8290E732F7AE82564C2A9A3E67F4285934E0B469A",
          "latest_block_height": "2148442",
          "latest_block_time": "2023-06-12T08:47:31.424072551Z",
          "earliest_block_hash": "80381631E332892FC524444711D90F88779863565569B1C039FCAD594F82DFE0",
          "earliest_app_hash": "",
          "earliest_block_height": "1",
          "earliest_block_time": "2022-10-31T14:50:59.741101392Z",
          "catching_up": false
        },
        "validator_info": {
          "address": "0A255058587092A300A77B2D5841062CA5703478",
          "pub_key": {
            "type": "tendermint/PubKeyEd25519",
            "value": "5MKec9nG5pvG6xVRPtyK3lTsE4kwrYDwD6XRDbqo5Tc="
          },
          "voting_power": "0"
        }
      }
    }
    ```
3. Find the last section of the response: `validator_info`. It contains information about the validator:

    - `pub_key`: The **validator public key**, e.g. `5MKec9nG5pvG6xVRPtyK3lTsE4kwrYDwD6XRDbqo5Tc=`
    - `address`: The **validator address**, e.g. `0A255058587092A300A77B2D5841062CA5703478`

    **Note:** You'll need the validator address to make sure that your node is an active validator on the network (see the next section).

4. Share the following information with the Qredo team:

   - The **validator public key** returned in the previous step, e.g. `5MKec9nG5pvG6xVRPtyK3lTsE4kwrYDwD6XRDbqo5Tc=`
    - The **deposit address** of the QRDO wallet you created before, e.g. `0x6A1B9033647CdEFaA39Aed8295f8724E87AE161d`

    **Note:** You can find your deposit address in the Qredo Web App.

## 3.3. Validator activation ceremony

The validator activation will be carried out by the Qredo node operators as part of a ceremony that updates a system contract.

You can monitor your node for validator activation by checking the block signatures:

```bash
$ curl localhost:26657/block
        ...
        "signatures": [
          {
            "block_id_flag": 2,
            "validator_address": "3CC74CDB0BB05B460A700ECD43E71AE1BEE663F6",
            "timestamp": "2023-06-12T08:54:06.578883878Z",
            "signature": "IH7QoV422VUub5dzaWMSloFRBhVNiGoF3lk2EnZLlwO5jtBzopHDqbWCw0eqDfASPCHD5hewrzl5jBW4dij7Cg=="
          },
          {
            "block_id_flag": 2,
            "validator_address": "4E4A7CD5F26B0DB5B514B4E734B7004CA042BDD9",
            "timestamp": "2023-06-12T08:54:06.567869497Z",
            "signature": "j43mnFL3pReG61VeL3bTgoEW882t/hhUJAEwoyj0E99bUIpBCNpPte++pXGy40NPWxrNAbGX6WnN0/KUlbWzDg=="
          },
          {
            "block_id_flag": 2,
            "validator_address": "627325F21F4D00108D1CE7D7692FE619CEA32446",
            "timestamp": "2023-06-12T08:54:06.574163756Z",
            "signature": "UR6kAjmWhr58fuLGEsMNwG9O/eCTwm+KNCpthxSTN6PrYLZmkSkW/mEd0aq3DSp0GwFn9BLG4/1c7Xjf++oJDg=="
          },
          {
            "block_id_flag": 2,
            "validator_address": "68787F6FF3A4ADED15F4E3BFCC593C7030C6BFA4",
            "timestamp": "2023-06-12T08:54:06.577970102Z",
            "signature": "ze+ZOdv4ufHgAQBNJFblj8luKFVrdZxz87T9r2Q+gOC4Qao+sWp5WA/SKdAd5EDIXakXh6M0pJuDH9Oq21ISBw=="
          },
          {
            "block_id_flag": 2,
            "validator_address": "7A47448EE7ED46816C3B644FB631CB96E4273474",
            "timestamp": "2023-06-12T08:54:06.567208184Z",
            "signature": "X27EXcfz6w5dOqZQLK68m7cd+e/9hGhoEJ7TDnk73Zgq4lRMlAGgX2anQknQHCfUROH7JjIGP+SA5K6VPsmtDA=="
          },
          {
            "block_id_flag": 2,
            "validator_address": "D823DD24A55EA371AB15DD01FE6573D5490124C2",
            "timestamp": "2023-06-12T08:54:06.575644589Z",
            "signature": "HQBQdkl5weRXMsn5NDCB2hMu3tbCE2pN0GdXS3NGLnZvX+XjMDzlCHjXa9OhcJ7/brVyHmCR/p8LnQNFmqTtDA=="
          }
        ]
```

Verify the list of signers against your `validator address`. If your address is present, then your node is an active validator on the network.

**Note:** To learn your `validator address`, you can run a status request to the Qredochain node. The address will be returned as `address`. See the previous section to learn more.

# 4. Monitor your reward wallet

There are different ways to monitor your wallet history:

- **Qredo Web App**

    In the Qredo Web App, log into your account and open up the fund containing your validator reward wallet. You will be able to see wallet history and balance.

- **Block explorer**

    Copy your `wallet-id` into the search bar and the explorer will take you to your wallet page. You can view your history and deposit address.

- **`qredochain-cli`**

    You can run the following `qredochain-cli` command:

    ```bash
    $ qrdo history <wallet-id> --endpoint=<node-endpoint>
    ```

    It returns the wallet history including deposits, settlements, and reward accrual.

