#!/usr/bin/env python3
"""
VUnit test runner for GammaSpectrometer FPGA.

Options:
  --wave            Generate one GHW waveform per test run.
  --with-coverage   Reserved for future coverage integration.
"""

from pathlib import Path
from vunit import VUnit
import sys

ROOT = Path(__file__).resolve().parent

# V-model directory paths
DESIGN_DIR = ROOT / ".." / ".." / "03_SubsystemDesign" / "DigitalLogic"
VERIFY_DIR = ROOT / ".." / ".." / "05_Verification" / "DigitalLogic"
BUILD_DIR  = ROOT / "Build"
VUNIT_OUT  = BUILD_DIR / "VUnitOut"

GENERATE_WAVES = "--wave" in sys.argv
if GENERATE_WAVES:
    sys.argv.remove("--wave")

WITH_COVERAGE = "--with-coverage" in sys.argv
if WITH_COVERAGE:
    sys.argv.remove("--with-coverage")

# Force VUnit output into Build/VUnitOut regardless of CWD
if "-o" not in sys.argv and "--output-path" not in sys.argv:
    sys.argv.extend(["-o", str(VUNIT_OUT)])

# Fix VUnit deprecation warning
vu = VUnit.from_argv(vhdl_standard="2008", compile_builtins=False)
vu.add_vhdl_builtins()

lib = vu.add_library("gammaspec_lib")

# -----------------------------------------------------------------------------
# Source files (from Design phase)
# -----------------------------------------------------------------------------
lib.add_source_file(str(DESIGN_DIR / "Source" / "Packages" / "ConstantsPkg.vhdl"))
lib.add_source_file(str(DESIGN_DIR / "Source" / "Packages" / "TypesPkg.vhdl"))
lib.add_source_file(str(DESIGN_DIR / "Source" / "Core" / "ClockDivider.vhdl"))
lib.add_source_file(str(DESIGN_DIR / "Source" / "Peripherals" / "Display" / "Display.vhdl"))
lib.add_source_file(str(DESIGN_DIR / "Source" / "Top" / "Top.vhdl"))

# -----------------------------------------------------------------------------
# Testbench files (from Verification phase)
# -----------------------------------------------------------------------------
lib.add_source_file(str(VERIFY_DIR / "UnitVerification" / "Peripherals" / "Display" / "tb_Display.vhdl"))
lib.add_source_file(str(VERIFY_DIR / "UnitVerification" / "Core" / "tb_Top.vhdl"))

# -----------------------------------------------------------------------------
# Compile options
# -----------------------------------------------------------------------------
lib.set_compile_option("ghdl.a_flags", ["--std=08", "-fsynopsys", "-frelaxed"])

# -----------------------------------------------------------------------------
# Per-test waveform generation
# -----------------------------------------------------------------------------
WAVE_DIR = BUILD_DIR / "Waves"

if GENERATE_WAVES:
    WAVE_DIR.mkdir(parents=True, exist_ok=True)

    def sanitize(name: str) -> str:
        return name.replace(" ", "_").replace("/", "_").replace(":", "_")

    for test_bench in lib.get_test_benches():
        for test in test_bench.get_tests():
            wave_name = f"{sanitize(test_bench.name)}.{sanitize(test.name)}.ghw"
            wave_path = WAVE_DIR / wave_name
            test.set_sim_option("ghdl.sim_flags", [f"--wave={wave_path.resolve()}"])

vu.main()