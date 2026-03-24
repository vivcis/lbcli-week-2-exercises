# Create a raw transaction with an amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

#!/bin/bash

WALLET_NAME="btrustwallet"

raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

# Get the txid from the raw transaction
TXID=$(bitcoin-cli -regtest decoderawtransaction "$raw_tx" | jq -r '.txid')

# Get a change address
CHANGE_ADDRESS=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getrawchangeaddress "bech32")

# Calculate change: total output (23703684 sats) - send (20000000 sats) - fee (1000 sats)
# Output 0: 16438390 sats + Output 1: 7265294 sats = 23703684 sats
# Change: 23703684 - 20000000 - 1000 = 3702684 sats = 0.03702684 BTC
SEND_AMOUNT=0.20000000
CHANGE_AMOUNT=0.03702684

# Create the raw transaction using both UTXOs as inputs
bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" createrawtransaction \
  "[{\"txid\":\"$TXID\",\"vout\":0},{\"txid\":\"$TXID\",\"vout\":1}]" \
  "[{\"2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP\":$SEND_AMOUNT},{\"$CHANGE_ADDRESS\":$CHANGE_AMOUNT}]"