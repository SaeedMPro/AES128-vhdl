SRC_DIR := src
TB_DIR := tb
WORK_DIR := work

GHDL := ghdl
GHDLFLAGS := --std=08

SRC_FILES := $(wildcard $(SRC_DIR)/*.vhd)
TB_FILE := $(TB_DIR)/aes_tb.vhd
TOP_ENTITY := aes_tb

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
	$(GHDL) -r $(GHDLFLAGS) $(TOP_ENTITY) --vcd=$(VCD_FILE)

wave:
	gtkwave $(VCD_FILE)

clean:
	rm -f $(EXEC) *.o *.cf $(VCD_FILE)

.PHONY: all analyze build run clean wave
