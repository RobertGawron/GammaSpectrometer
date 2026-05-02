import numpy as np
from .constants import FWHM_TO_SIGMA

def crystal_area(diameter_mm):
    return np.pi * (diameter_mm / 2.0) ** 2

def sipm_area(size_mm):
    return size_mm ** 2

def geometric_coverage_fraction(crystal_diameter_mm, sipm_size_mm):
    area_crystal = crystal_area(crystal_diameter_mm)
    area_sipm = sipm_area(sipm_size_mm)
    return area_sipm / area_crystal

def apply_optical_efficiency(geometric_fraction, optical_efficiency):
    return geometric_fraction * optical_efficiency

def detected_photons(light_yield, energy_mev, coverage, pde):
    n_photons = light_yield * energy_mev
    return n_photons * coverage * pde

def statistical_resolution_percent(light_yield, energy_mev, coverage, pde):
    """
    A gamma ray deposits energy E in the scintillator.
    The number of produced photons is:

        N_photons = light_yield * energy_mev

    Only a fraction of those photons are detected:

        N_detected = N_photons * coverage * pde

    where:
        coverage = geometric_fraction * optical_efficiency
        pde = photon detection efficiency

    Photon detection follows Poisson statistics.
    The relative statistical fluctuation (sigma_rel) is:

        sigma_rel = 1 / sqrt(N_detected)

    Convert sigma_rel to FWHM resolution in percent:

        Resolution_percent = FWHM_TO_SIGMA * sigma_rel * 100

    where FWHM_TO_SIGMA is described in constants.py
    """
    n_detected = detected_photons(light_yield, energy_mev, coverage, pde)
    sigma_rel = 1.0 / np.sqrt(n_detected)
    return FWHM_TO_SIGMA * sigma_rel * 100.0