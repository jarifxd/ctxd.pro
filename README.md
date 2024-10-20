# Solana Token Creation Script

![Solana Token Creation](https://via.placeholder.com/1200x300/000000/FFFFFF?text=Solana+Token+Creation+Script)

---

This repository contains a Bash script that automates the creation of a new token on the Solana blockchain using the Solana CLI and SPL Token CLI. This tool is designed for developers and enthusiasts looking to experiment with token creation on the Solana Devnet.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Important Notes](#important-notes)
- [Dependencies](#dependencies)
- [License](#license)
- [Contributing](#contributing)
- [Contact](#contact)

---

## Prerequisites

Before running the script, ensure that you have the following:

- A Unix-like operating system (Linux, macOS, etc.)
- An active internet connection
- `sudo` privileges to install packages

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/jarifxd/ctxd.pro.git
   cd ctxd.pro

2. **Make the Script Executable**:
   ```bash
   chmod +x script.sh
   
3. **Install Dependencies**:
   ```bash
   sudo apt update
   sudo apt install -y curl build-essential git pkg-config libssl-dev libudev-dev libclang-dev clang rustc cargo

4. **Run the Script**:
   ```bash
   sudo ./script.sh
   
5. **Provide Required Information**:
   Provide Required Information: The script will prompt you for the following details:

  Coin Name: The full name of your token (e.g., Mycoin).

  Short Name: A short symbol for your token (e.g., MYC).

  Coin Description: A brief summary of your token's purpose.

  Coin Image Link: A URL to the token's logo.

  Coin Website: A URL to the project's website.

  Amount of Coins to Mint: How many tokens you wish to create.

  Fixed Supply: Indicate if the token will have a fixed supply (yes/no).

  Special Features: Any additional functionalities (e.g., staking, governance).

  Metadata File URL: Where the metadata will be hosted.
   
3. **Confirm Token Creation**:
   
   After reviewing your inputs, you will be asked to confirm the creation of the token. Type yes to proceed.

--------------------------------------------------------------------------------------------------------------------------------------

Important Notes
This script operates on the Solana Devnet, which is intended for testing. Tokens created on Devnet have no real-world value.
All generated wallet and token information will be saved in a directory named my_coin_files within your home directory.
Ensure you keep your wallet file secure, as it contains sensitive information.
Dependencies
The script will automatically install the following dependencies:

curl
build-essential (essential packages for building software)
git (version control system)
pkg-config (helps in configuring packages)
libssl-dev (required for OpenSSL)
libudev-dev (library for device management)
libclang-dev (Clang development files)
clang (C/C++ compiler)
rustc (Rust programming language compiler)
cargo (Rust package manager)
Ensure you have sudo privileges to install these packages.

Contributing
Contributions are welcome! Feel free to submit issues or pull requests. If you have suggestions for improvements or additional features, please open an issue.

Contact
For questions or feedback, please reach out through GitHub issues or contact me directly via email at [support@ctxd.pro].

Thank you for using our Script! Happy coding!
