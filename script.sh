#!/bin/bash

# Install necessary packages
apt update -y
apt install -y curl build-essential git pkg-config libssl-dev libudev-dev libclang-dev clang rustc cargo

# Upgrade the installed packages
apt upgrade -y

# Install Solana CLI version 1.18.5
sh -c "$(curl -sSfL https://release.solana.com/v1.18.5/install)"

# Ensure SPL Token CLI is installed
if ! command -v spl-token &> /dev/null; then
    echo "SPL Token CLI not found. Installing..."
    cargo install spl-token-cli
fi

# Set up the Solana environment to use Devnet
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
solana config set --url https://api.devnet.solana.com

# Verify the installation
solana --version

# Create a directory for coin files
COIN_DIR="$HOME/my_coin_files"
mkdir -p "$COIN_DIR"

# Create a new Solana wallet for the token
TOKEN_WALLET_FILE="$COIN_DIR/my-solana-token-wallet.json"
solana-keygen new --outfile "$TOKEN_WALLET_FILE" --force

# Display the wallet address
TOKEN_WALLET_ADDRESS=$(solana-keygen pubkey "$TOKEN_WALLET_FILE")
echo -e "\nToken Wallet Address: $TOKEN_WALLET_ADDRESS\n"

# Get user input for token metadata
echo "Please provide the following details for your new token:\n"

read -p "Coin Name (e.g., MyCoin): " COIN_NAME
read -p "Short Name (e.g., MYC): " SHORT_NAME
read -p "Coin Description (brief summary): " COIN_DESCRIPTION
read -p "Coin Image Link (URL to logo): " COIN_IMAGE_LINK
read -p "Coin Website (URL to project site): " COIN_WEBSITE
read -p "Amount of coins to mint: " MINT_AMOUNT
read -p "Will this coin have a fixed supply? (yes/no): " FIXED_SUPPLY
read -p "Any special features or utilities for this coin? (e.g., staking, governance): " SPECIAL_FEATURES
read -p "Metadata file URL (where the metadata will be hosted): " METADATA_URL

# Confirmation prompt
echo -e "\nWarning: This coin will be created on Devnet."
read -p "Are you sure you want to proceed with creating this coin? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Token creation aborted."
    exit 1
fi

# Create a new token on Devnet
TOKEN_MINT_ADDRESS=$(spl-token create-token | awk '/Creating token/ {print $3}')
echo -e "\nToken Mint Address: $TOKEN_MINT_ADDRESS\n"

# Create an associated token account for the new wallet
TOKEN_ACCOUNT_ADDRESS=$(spl-token create-account "$TOKEN_MINT_ADDRESS" | awk '/Creating account/ {print $3}')
echo -e "Token Account Address: $TOKEN_ACCOUNT_ADDRESS\n"

# Mint the specified amount of tokens to the new wallet
spl-token mint "$TOKEN_MINT_ADDRESS" "$MINT_AMOUNT" "$TOKEN_ACCOUNT_ADDRESS"
echo -e "Minted $MINT_AMOUNT tokens to the account.\n"

# Create metadata JSON
METADATA_FILE="$COIN_DIR/metadata.json"
cat <<EOF > "$METADATA_FILE"
{
  "name": "$COIN_NAME",
  "symbol": "$SHORT_NAME",
  "uri": {
    "image": "$COIN_IMAGE_LINK",
    "website": "$COIN_WEBSITE",
    "description": "$COIN_DESCRIPTION",
    "metadata_url": "$METADATA_URL"
  },
  "fixed_supply": "$FIXED_SUPPLY",
  "special_features": "$SPECIAL_FEATURES"
}
EOF

# Display success message with full token information
echo -e "\nToken creation successful! Here are the details:\n"
echo "---------------------------------------------"
echo "Coin Name:                $COIN_NAME"
echo "Short Name:              $SHORT_NAME"
echo "Description:             $COIN_DESCRIPTION"
echo "Image Link:              $COIN_IMAGE_LINK"
echo "Website:                 $COIN_WEBSITE"
echo "Mint Address:            $TOKEN_MINT_ADDRESS"
echo "Account Address:         $TOKEN_ACCOUNT_ADDRESS"
echo "Total Supply Minted:     $MINT_AMOUNT"
echo "Fixed Supply:            $FIXED_SUPPLY"
echo "Special Features:        $SPECIAL_FEATURES"
echo "Metadata URL:           $METADATA_URL"
echo "Explorer Link:           https://explorer.solana.com/address/$TOKEN_MINT_ADDRESS?cluster=devnet"
echo -e "Metadata file created at: $METADATA_FILE"
echo "---------------------------------------------"
echo "Token setup complete!"

