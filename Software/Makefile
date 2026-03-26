# ==============================================================================
# GammaSpectrometer FPGA Build System
# Target: iCE40HX4K-TQ144
# ==============================================================================

# Target board configuration
DEVICE  = hx8k
PACKAGE = tq144:4k
PCF     = Constraints/Pins.pcf

# Top level entity
TOP = Top

# Source files (add new files here)
VHDL_SRC = \
    Source/Core/Types.vhdl \
    Source/Core/Top.vhdl \
    Source/Core/ClockDivider.vhdl \
    Source/Utilities/EdgeDetector.vhdl

# Testbench files
TB_SRC = Testbench/Core/TbTop.vhdl
TB_TOP = TbTop

# Build directory
BUILD = Build

# Simulation directory
SIM = Simulation

.PHONY: all synth pnr bitstream sim clean help flash

# ==============================================================================
# Targets
# ==============================================================================

all: bitstream

help:
	@echo "GammaSpectrometer FPGA Build Targets:"
	@echo "  all        - Build complete bitstream (default)"
	@echo "  synth      - Synthesize VHDL to JSON netlist"
	@echo "  pnr        - Place and route"
	@echo "  bitstream  - Generate .bin file"
	@echo "  sim        - Run testbench simulation"
	@echo "  flash      - Program FPGA"
	@echo "  clean      - Remove build files"
	@echo ""
	@echo "Project structure:"
	@echo "  Source/        - VHDL source files"
	@echo "  Testbench/     - Testbench files"
	@echo "  Constraints/   - Pin constraints"
	@echo "  Build/         - Build artifacts"
	@echo "  Simulation/    - Simulation waveforms"

# ------------------------------------------------------------------------------
# Synthesis
# ------------------------------------------------------------------------------
synth: $(BUILD)/$(TOP).json

$(BUILD)/$(TOP).json: $(VHDL_SRC) | $(BUILD)
	@echo "=== Synthesizing VHDL with GHDL + Yosys ==="
	yosys -m ghdl -p \
		"ghdl --std=08 $(VHDL_SRC) -e $(TOP); \
		 synth_ice40 -top $(TOP) -json $@"
	@echo "Synthesis complete: $@"

# ------------------------------------------------------------------------------
# Place & Route
# ------------------------------------------------------------------------------
pnr: $(BUILD)/$(TOP).asc

$(BUILD)/$(TOP).asc: $(BUILD)/$(TOP).json $(PCF)
	@echo "=== Place and Route with nextpnr ==="
	nextpnr-ice40 \
		--$(DEVICE) \
		--package $(PACKAGE) \
		--pcf $(PCF) \
		--json $< \
		--asc $@
	@echo "Place & Route complete: $@"

# ------------------------------------------------------------------------------
# Bitstream Generation
# ------------------------------------------------------------------------------
bitstream: $(BUILD)/$(TOP).bin

$(BUILD)/$(TOP).bin: $(BUILD)/$(TOP).asc
	@echo "=== Generating bitstream with icepack ==="
	icepack $< $@
	@echo "Bitstream ready: $@"
	@ls -lh $@
	@echo ""
	@echo " Build complete! Flash with: make flash"

# ------------------------------------------------------------------------------
# Simulation
# ------------------------------------------------------------------------------
sim: | $(BUILD) $(SIM)
	@echo "=== Running simulation ==="
	cd $(BUILD) && \
	ghdl -a --std=08 $(addprefix ../,$(VHDL_SRC)) $(addprefix ../,$(TB_SRC)) && \
	ghdl -e --std=08 $(TB_TOP) && \
	ghdl -r --std=08 $(TB_TOP) --vcd=../$(SIM)/Waves.vcd --stop-time=15ms
	@echo "Simulation complete: $(SIM)/Waves.vcd"
	@echo "View with: gtkwave $(SIM)/Waves.vcd"

# ------------------------------------------------------------------------------
# Program FPGA
# ------------------------------------------------------------------------------
flash: $(BUILD)/$(TOP).bin
	@echo "=== Programming FPGA ==="
	iceprog $<

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------
$(BUILD):
	mkdir -p $(BUILD)

$(SIM):
	mkdir -p $(SIM)

clean:
	rm -rf $(BUILD)/*
	rm -rf $(SIM)/*
	@echo "Clean complete"

# Show project stats
stats: $(BUILD)/$(TOP).asc
	@echo "=== Resource Usage ==="
	icebox_stat $<