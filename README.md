## 1. Overview

```
ansible
├── inventory
│   └── env
│       ├── mainnet
│       │   ├── group_vars
│       │   │   └── all.yml                  # Mainet variables. Variables used when you need to run mainnet Qredochain Validator.
│       │   └── hosts.yaml                   # Configure host connections. 
│       └── testnet
│           ├── group_vars
│           │   └── all.yml                  # Testnet variables. Variables used when you need to run testnet Qredochain Validator.
│           └── hosts.yaml                   # Configure host connections. 
├── main.yaml
└── qredochain
    ├── README.md
    ├── defaults
    │   └── main.yml
    ├── files
    │   └── pub.pem
    ├── handlers
    │   └── main.yml
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

# Environment Variables

* MAINNET  - all variables are located into inventory/env/mainnet/group_vars/all.yml
* TESTNET  - all variables are located into inventory/env/testnet/group_vars/all.yml

--------------------------------------------------------------------------------------------
|           NAME            |     Description                                               |
|---------------------------|---------------------------------------------------------------|
| env                       |    Name of the environment                                    |
| qredochain_version        |    Version of qredochain                                      |
| qredochain_file_short_sha |    Used with the version to target specific build             |
| qredochain_file_sufix     |    Sufix of the files                                         |
| qredochain_sig_file_sifux |    Sufix of the signature file                                |
| qredochain_release_url    |    Public github release repo                                 |
| qredochain_snapshot_auth  |    Used by qredochain to authenticate to the snapshot endpoint|
| qredochain_sentry_endpoint|    Used to configure qredochain`s persistent_peers value      |
| qredochain_peer_1_port    |    TPC port of peer 1. Used for configuring qredochain        |
| qredochain_peer_1_id      |    p2p address of peer 1. Used for configuring qredochain     |
| qredochain_peer_2_port    |    TPC port of peer 2. Used for configuring qredochain        |
| qredochain_peer_2_id      |    p2p address of peer 2. Used for configuring qredochain     | 
--------------------------------------------------------------------------------------------

## 2. Install Qredochain Validator using ansible role

Currently the role supports only ubuntu20.04 operation system

# Step 1 

At the start we need to configure either mainnet or testnet vars located into inventory/env/{mainnet,testnet}/hosts.yml
Into that file we need to configure ip addresses or hostnames to the target hosts. Once we configure that information we are ready to run the playbook

# Step 2 

* Run the playbook

```
cd ansible
ansible-playbook -i inventory/env/{mainnet,testnet}/ main.yml
```
