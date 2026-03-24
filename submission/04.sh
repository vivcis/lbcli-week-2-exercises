# List the current UTXOs in your wallet.

#!/bin/bash

WALLET_NAME="btrustwallet"

bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" listunspent
