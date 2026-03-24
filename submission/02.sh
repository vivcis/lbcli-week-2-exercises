# Create a new Bitcoin address, for receiving change.

#!/bin/bash
WALLET_NAME="btrustwallet"

bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getrawchangeaddress