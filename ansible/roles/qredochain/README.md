# playbooks
- qredochain-node

## qredochain role

This role will setup a qredochain node connected to testnet or mainnet Qredo's network.

### Role Variables
--------------
- testnet: ../inventory/env/testnet/group_vars/all.yml
- mainnet: ../inventory/env/mainnet/group_vars/all.yml

# Running the playbook

``` sh
ansible-playbook -i env/testnet playbooks/qredochain-node.yaml --extra-vars "qredochain_snapshot_auth=<VALUE>"
```

*<VALUE>* must be replaced with the secret given by Qredo.
