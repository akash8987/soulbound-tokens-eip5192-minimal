# EIP-5192 Soulbound Tokens (Minimal)

A production-grade, highly secure implementation of Soulbound Tokens (SBTs) that natively supports the EIP-5192 standard. This framework expands the standard ERC-721 interface by establishing cryptographic programmatic locks that permanently bind tokens to their designated recipient addresses upon issuance.

## Features
- **EIP-5192 Standardization:** Native support for the explicit `Locked` and `Unlocked` interface checking functions.
- **Strict Non-Transferability:** Overridden token hooks block standard asset transfers via standard execution routes.
- **Dynamic Meta-Evocation:** Simple architectures enabling administrative minting paired with permanent structural locking logs.
- **Flat Architecture:** Zero subfolders for rapid local compiling, direct testing setups, and straightforward audits.

## Getting Started

### Installation
```bash
npm install
