# Qredo Network

# Contents

1. The Qredo Network
2. Nodes and architecture
3. Proof-of-stake
4. Infrastructure considerations
5. Installation instructions

# 1. The Qredo Network

The **Qredo Network** is a distributed peer-to-peer system built on top of the **Tendermint protocol**. At its core lies a custom-built blockchain-based application called `qredochain`, a web application supported by Tendermint’s application blockchain interface (ABCI) framework.

**Tendermint** uses a proof of authority-based consensus mechanism by default. As of v1.9.0 `qredochain` can be upgraded from proof-of-authority to proof-of-stake, with QRDO forming the economic foundation of the network and a means by which validators are incited and rewarded.

# 2. Nodes and arcitecture

There are two types of nodes within the network:

- **Validators** are assigned voting power and participate in the confirmation of transactions through the creation of new blocks in collaboration with other validators.  
  
  In any confirmation round, 2/3 of the network voting power must agree on a block in order for that block to be appended to the blockchain and the transactions contained within them to be confirmed.

- **Non-validators** run identical software but have no voting power. They download transactions and block data as well as relay unconfirmed transaction data from other peers.

Non-validators can also perform a defensive role within the network, by exposing themselves to potentially malicious requests being sent from outside the network. Non-validators exposed to semi or untrusted parties are known as ‘sentry’ nodes. They form a shield that protects validators from a range of attacks and allows validator operators to better control the performance of their deployed validators.

To learn more, see [Sentry Node Architecture Overview](https://forum.cosmos.network/t/sentry-node-architecture-overview/454).

# 3. Proof-of-stake

Qredo's proof-of-stake reward mechanism is the process that determines each validator's contribution to the Qredo network and rewards them with QRDO.

### 3.1. Key principles

Key principles of the Qredo's reward mechanism are the following:

- Work pays: Validators who commit blocks to the Qredochain will earn QRDO.
- More stake, more pay: Validators who stake more earn more.
- Longer pays better: If you stake your coins for longer, you should accumulate more QRDO.
- Regular payouts: Qredo network validators should see their rewards increment on a regular basis (small epochs).

### 3.2. Technical details

Tendermint-based blockchains use a standard set of methods for executing each new block. These include `BeginBlock`, `Commit` and `EndBlock`. The latter permits the network to update the validator set. Qredo has added an additional method within the `EndBlock` (`maybeRewardValidators`) that re-distributes QRDO at fixed block intervals, dependent on the `Epoch` length.

The reward algorithm divides the blockchain into discrete epochs (an epoch is a fixed number of blocks). Within each epoch QRDO fees accumulate into the system fee wallet, `ffffffffffffffffffffffffffffffffffffffffffffffffffff00140001002b0`. A percentage of these fees are available to be distributed to validators on the network.

### 3.3. Reward sharing workflow

The amount rewarded to each validator is determined by two parameters: **blocks signed** and **value staked**.

At the end of an epoch, fees accumulated in the system fee wallet will be shared between validators based on a reward algorithm determined by stake value and number of blocks signed. A validator who signs a higher proportion number of blocks than its peers will increase its reward fraction. A validator that stakes proportionally more than its peers will increase its reward fraction.

At the beginning of each period, reward details are extracted and a set of conditions are checked to trigger reward distribution. The `timeToReward` function checks if the epoch has ended and executes the reward-sharing process if so. Throughout the epoch validator wallets are monitored. Validators are excluded from the reward distribution if they violate the following rules:

- Use their wallets to move QRDO.
- Do not stake the `MinimumStake` value as determined by the `reward` kvasset.

If coins have moved from a specified wallet, the status of the wallet will be updated and the validator will be excluded from reward distribution during the epoch.

The reward algorithm uses blockchain history to calculate the work contributed by each validator (in the form of block commit signatures). The `rewardFraction` is the final value representing the share of available validator rewards that will be paid out during the epoch.

Validator wallet balances are updated and finalized at the end of the block and parameters are reset for the beginning of the next epoch.

# 4. Infrastructure considerations

Running a node on the Qredo Network is relatively cheap, requiring minimal RAM and CPU and under 20GB of storage. At this time all validators on the Qredo Network are deployed onto `c5.xlarge` EC2 instances on AWS.

Since December 2022 the set of nodes on the Qredo Network are distributed between two AWS accounts managed by geographically separate teams spread across Europe. These are referred to as ‘side A’ and ‘side B’ in the documentation. Non-validators and validators alike are distributed across the Side A and B accounts.

The multiparty computation (MPC) infrastructure is also split between the two AWS accounts with ‘client’ services deployed to side A and ‘server’ services deployed to side B. The Qredo server is deployed on a separate AWS account — again, under the control of Qredo Ltd employees.

# 5. Installation instructions

To learn how  to install an external validator node, see our [Installation guide](docs/installation.md).

