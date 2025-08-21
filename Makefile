SRC_DIR := src
TB_DIR := tb
WORK_DIR := work

GHDL := ghdl
GHDLFLAGS := --std=08

SRC_FILES := $(wildcard $(SRC_DIR)/*.vhd)

# uncomment each section that you wanna test that:
#------------------------------------------------
## for test `aes_top`
TB_FILE := $(TB_DIR)/tb_aes128.vhd
TOP_ENTITY := tb_aes128

## for test `decryptionCore`
# TB_FILE := $(TB_DIR)/tb_decryptionCore.vhd
# TOP_ENTITY := tb_decryptionCore

## for test `decryptionStage`
# TB_FILE := $(TB_DIR)/tb_decryptionStage.vhd
# TOP_ENTITY := tb_decryptionStage

## for test `encryptionCore`
# TB_FILE := $(TB_DIR)/tb_encryptionCore.vhd
# TOP_ENTITY := tb_encryptionCore

## for test `encryptionStage`
# TB_FILE := $(TB_DIR)/tb_encryptionStage.vhd
# TOP_ENTITY := tb_encryptionStage

## for test `pipelineRegister`
# TB_FILE := $(TB_DIR)/tb_pipelineRegister.vhd
# TOP_ENTITY := tb_pipelineRegister

## for test `subbytes`
# TB_FILE := $(TB_DIR)/tb_subbytes.vhd
# TOP_ENTITY := tb_subbytes

## for test `invSubBytes`
# TB_FILE := $(TB_DIR)/tb_invSubBytes.vhd
# TOP_ENTITY := tb_invSubBytes

## for test `shiftrows`
# TB_FILE := $(TB_DIR)/tb_shiftrows.vhd
# TOP_ENTITY := tb_shiftrows

## for test `invShiftRows`
# TB_FILE := $(TB_DIR)/tb_invShiftRows.vhd
# TOP_ENTITY := tb_invShiftRows

## for test `addRoundKey`
# TB_FILE := $(TB_DIR)/tb_addRoundKey.vhd
# TOP_ENTITY := tb_addRoundKey

## for test `mixColumn`
# TB_FILE := $(TB_DIR)/tb_mixColumn.vhd
# TOP_ENTITY := tb_mixColumn

## for test `invMixColumn`
# TB_FILE := $(TB_DIR)/tb_invMixColumn.vhd
# TOP_ENTITY := tb_invMixColumn

## for test `KeyExpansion`
# TB_FILE := $(TB_DIR)/tb_KeyExpansion.vhd
# TOP_ENTITY := tb_KeyExpansion
#------------------------------------------------


VCD_FILE := wave.vcd
EXEC := $(TOP_ENTITY)

all: run

analyze:
	@echo "Analyzing source files..."
	$(GHDL) -i $(GHDLFLAGS) $(SRC_FILES) $(TB_FILE)

build:
	@echo "Building..."
	$(GHDL) -m $(GHDLFLAGS) $(TOP_ENTITY)

run: analyze build
	@echo "Running simulation..."
	$(GHDL) -r $(GHDLFLAGS) $(TOP_ENTITY) --vcd=$(VCD_FILE) --stop-time=1000ns

wave:
	gtkwave $(VCD_FILE)

clean:
	rm -f $(EXEC) *.o *.cf $(VCD_FILE)

.PHONY: all analyze build run clean wave
