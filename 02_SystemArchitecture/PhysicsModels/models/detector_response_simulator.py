import numpy as np
from .constants import FWHM_TO_SIGMA


"""
Reference energy used for resolution scaling.
Commonly 662 keV (Cs-137) is used as calibration reference.
This is not an intrinsic SiPM parameter.
The actual reference energy should be taken from the SiPM datasheet.
"""
E_REF = 662.0  # keV (Cs-137 gamma line)

def fwhm_at_energy(E, fwhm_662, e_ref=E_REF):
    """
    The number of detected photons N is proportional 
    to deposited energy E:

        N proportional to E

    Statistical fluctuations follow Poisson statistics:

        sigma_N proportional to sqrt(N)

    Relative fluctuation:

        (sigma_N / N) proportional to (1 / sqrt(N))

    Since N proportional to E:

        (resolution) proportional to (1 / sqrt(E))

    Therefore, if the resolution is known at a reference energy E_ref:

        R(E) = R(E_ref) * sqrt(E_ref / E)

    This model assumes:
        - Resolution is dominated by statistical (photon counting) term
        - Electronic noise contribution is negligible
        - No significant non-proportionality effects
        - No additional constant or 1/E noise terms

    This is approximation for architecture-level, 
    not a full detector response model.
    """
    if np.any(np.asarray(E) <= 0):
        raise ValueError("Energy must be positive for resolution scaling.")

    return fwhm_662 * np.sqrt(e_ref / E)



def fwhm_scaled_by_sipm_count(fwhm_single, n_sipm):
    """
    Resolution scales as 1/sqrt(N_sipm).
    """
    return fwhm_single / np.sqrt(n_sipm)


def generate_peak_samples(energy, intensity, fwhm_662, events_per_peak, rng):
    """
    Generate Gaussian-distributed samples for a gamma peak.
    """
     # fwhm is relative (dimensionless), multiply by energy to get keV
    fwhm = fwhm_at_energy(energy, fwhm_662)
    sigma = (fwhm * energy) / FWHM_TO_SIGMA

    n_events = int(events_per_peak * intensity)

    return rng.normal(loc=energy, scale=sigma, size=n_events)


def simulate_spectrum(
    isotopes,
    fwhm_662,
    energy_max,
    bins,
    events_per_peak,
    background_rate=5,
    seed=None,
):
    rng = np.random.default_rng(seed)

    spectrum = np.zeros(bins)

    for energy, intensity in isotopes:
        samples = generate_peak_samples(
            energy,
            intensity,
            fwhm_662,
            events_per_peak,
            rng,
        )

        hist, _ = np.histogram(samples, bins=bins, range=(0, energy_max))
        spectrum += hist

    background = rng.poisson(background_rate, size=bins)
    spectrum += background

    return spectrum
