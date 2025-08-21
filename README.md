# AES-128 VHDL Implementation

## Project Overview

This project implements the **AES-128 encryption and decryption algorithm** in VHDL with a **pipelined architecture**. It is suitable for **FPGA synthesis** or **simulation environments** and includes a **modular design** for all AES stages:

* **AddRoundKey**
* **SubBytes / InvSubBytes**
* **ShiftRows / InvShiftRows**
* **MixColumns / InvMixColumns**
* **Key Expansion**

The project also includes **comprehensive testbenches** to verify individual modules and the full AES-128 pipeline.

---

## Directory Structure

```
project/
│
├── Makefile
├── README.md
├── src
│   ├── addroundkey.vhd
│   ├── aes128.vhd
│   ├── decryptionCore.vhd
│   ├── decryptionStage.vhd
│   ├── encryptionCore.vhd
│   ├── encryptionStage.vhd
│   ├── invMixColumn.vhd
│   ├── invShiftRows.vhd
│   ├── invSubBytes.vhd
│   ├── KeyExpansion.vhd
│   ├── mixColumn.vhd
│   ├── pipelineRegister.vhd
│   ├── shiftrows.vhd
│   ├── subbytes.vhd
│   └── Utilities.vhd
├── tb
│   ├─ tb_addRoundKey.vhd
│   ├── tb_aes128.vhd
│   ├── tb_decryptionCore.vhd
│   ├── tb_decryptionStage.vhd
│   ├── tb_encryptionCore.vhd
│   ├── tb_encryptionStage.vhd
│   ├── tb_invMixColumn.vhd
│   ├── tb_invShiftRows.vhd
│   ├── tb_invSubBytes.vhd
│   ├── tb_KeyExpansion.vhd
│   ├── tb_mixColumn.vhd
│   ├── tb_pipelineRegister.vhd
│   ├── tb_shiftrows.vhd
│   └── tb_subbytes.vhd
```

---

## Features

* **AES-128 Encryption/Decryption**: 128-bit block size with 128-bit key.
* **Pipelined Architecture**: Allows stage-by-stage data processing for faster throughput.
* **Modular Design**: Easy to reuse, test, and extend to AES-192/256.
* **Testbenches Included**: Verify each stage and the complete AES pipeline.
* **Waveform Support**: Generate GTKWave visualizations for debugging.

---

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/SaeedMPro/AES128-vhdl.git
cd AES128-vhdl
```

2. Use the **Makefile** for compilation, simulation, and waveform generation:

```bash
# Analyze and elaborate all files
make

# Run simulation and generate GTKWave waveform
make wave

# Clean build and simulation files
make clean
```

3. Check the waveform or console output for **PASS/FAIL** results from the testbenches.

---

## Notes

* The project uses a **custom MATRIX type** defined in `Utilities.vhd` for 4x4 byte matrices.
* Sequential operations are supported with **clock and reset signals** for FPGA synthesis.
* Easily extendable for **AES-192 and AES-256** by modifying key expansion and stage modules.
* All testbenches include multiple **test vectors** to ensure correct functionality.

