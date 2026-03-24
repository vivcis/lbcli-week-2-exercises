# Create a SegWit address.
# Add funds to the address.
# Return only the Address

#!/bin/bash

WALLET_NAME="btrustwallet"

# Create a SegWit (bech32) address
ADDRESS=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getnewaddress "" "bech32")

# Mine blocks to fund the address (101 blocks so coinbase is spendable)
bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" generatetoaddress 101 "$ADDRESS" > /dev/null 2>&1

# Return only the address
echo "$ADDRESS"
