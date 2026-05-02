"""
Monte Carlo simulation of SiPM dark count noise contribution to gamma spectra.

SiPM Device:
    ON Semiconductor C-Series
    Model: MICROFC-60035-SMT
    Active area: 6 mm x 6 mm
    Microcell size: 35 um

Datasheet:
    ON Semiconductor, C-Series SiPM Sensors
    Publication Order Number: MICROC-SERIES/D
    Rev. 9, February 2022

Notes:
    - SiPM intrinsic parameters (DCR, gain, microcell count,
      temperature coefficients) are taken from the above datasheet.
    - Scintillation light yield and integration window are
      system-level assumptions.
    - Crosstalk and afterpulsing are NOT included in this model.
    - Temperature dependence of DCR uses simplified doubling approximation.
"""

import numpy as np


# =============================================================================
# SiPM Device Constants: MICROFC-60035-SMT (6 mm x 6 mm, 35 um)
# Datasheet: MICROC-SERIES/D (Rev. 9, Feb 2022)
# =============================================================================

# --- Geometry ---
ACTIVE_AREA_MM2 = 6 * 6
# Source: Page 5, Table 2 - Active area (60035: 6 x 6 mm2)

MICROCELL_SIZE_UM = 35
# Source: Page 15 - 60035 series (35 um microcell)

N_MICROCELLS = 18980
# Source: Page 5, Table 2 - No. of microcells (60035)

# --- Gain ---
GAIN_TYPICAL = 3e6
# Source: Page 2, Table 1 - Gain @ Vbr + 2.5 V (6 mm, 35 um)

# --- Dark Count Rate ---
DCR_21C_TYP = 1.2e6  # Hz
# Source: Page 3, Table 1 - Dark Count Rate @ 21 C (Typ 1200 kHz)

DCR_21C_MAX = 3.4e6  # Hz
# Source: Page 3, Table 1 - Dark Count Rate @ 21 C (Max 3400 kHz)

# --- Temperature Coefficients ---
TEMP_COEFF_VBR = 21.5e-3   # V/C
# Source: Page 4 - Temperature dependence of Vbr

TEMP_COEFF_GAIN = -0.008   # relative change per C
# Source: Page 4 - Temperature dependence of Gain (-0.8 %/C)

# --- Temperature Model ---
TEMP_REFERENCE_C    = 21.0  # C (datasheet reference temperature)
DCR_DOUBLING_TEMP_C = 10.0  # empirical: DCR doubles every 10 C


# =============================================================================
# Physics Functions
# =============================================================================

def scale_dcr_with_temperature(dcr_ref, temperature_c):
    """
    Scale DCR from reference temperature using doubling approximation.

    DCR(T) = DCR_ref * 2 ^ ((T - T_ref) / T_doubling)

    This is a simplified empirical model.
    Crosstalk and afterpulsing are not included.
    """
    return dcr_ref * 2 ** (
        (temperature_c - TEMP_REFERENCE_C) / DCR_DOUBLING_TEMP_C
    )


def simulate_sipm_spectrum(
    temperature_c,
    isotopes,
    events_per_peak,
    pe_per_kev,
    n_sipm,
    integration_time,
    n_bins,
    e_max,
    rng,
):
    """
    Simulate detected energy spectrum at a given temperature.

    For each gamma line, signal PE and dark PE are sampled independently
    from Poisson distributions and combined into a measured energy estimate.

    Signal PE:
        mean_signal_pe = energy_kev * pe_per_kev

    Dark PE:
        dark_mean = DCR(T) * n_sipm * integration_time

    Measured energy:
        measured_energy = (signal_pe + dark_pe) / pe_per_kev
    """

    dcr_single = scale_dcr_with_temperature(DCR_21C_TYP, temperature_c)
    dcr_array  = dcr_single * n_sipm
    dark_mean  = dcr_array * integration_time

    all_measured_energies = []

    for energy_kev, intensity in isotopes:

        n_events = int(events_per_peak * intensity)
        mean_signal_pe = energy_kev * pe_per_kev

        signal_pe = rng.poisson(mean_signal_pe, size=n_events)
        dark_pe   = rng.poisson(dark_mean,      size=n_events)

        measured_energy = (signal_pe + dark_pe) / pe_per_kev
        all_measured_energies.append(measured_energy)

    all_measured_energies = np.concatenate(all_measured_energies)

    spectrum, bin_edges = np.histogram(
        all_measured_energies,
        bins=n_bins,
        range=(0, e_max)
    )

    bin_centers = 0.5 * (bin_edges[:-1] + bin_edges[1:])

    return spectrum, bin_centers