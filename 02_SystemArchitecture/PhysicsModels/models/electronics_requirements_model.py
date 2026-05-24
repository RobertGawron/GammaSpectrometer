"""
Electronics Requirements Derivation Model

Derives analog front-end and ADC specifications from detector physics limits.
Calculates noise budgets, bandwidth requirements, and SNR.
"""

import numpy as np
from .constants import FWHM_TO_SIGMA


def electronics_noise_budget(sigma_scintillation, budget_fraction=0.18):
    """
    Calculate allowed electronics noise budget to remain detector-limited.
    
    Parameters
    ----------
    sigma_scintillation : float
        Detector statistical RMS resolution (as fraction, e.g., 0.018)
    budget_fraction : float, optional
        Fraction of detector noise allocated to electronics (default 0.18)
        
    Returns
    -------
    float
        Allowed electronics RMS noise (as fraction)
    """
    return sigma_scintillation * budget_fraction


def total_system_noise(sigma_scintillation, sigma_electronics):
    """
    Calculate total system noise (quadrature sum).
    
    Parameters
    ----------
    sigma_scintillation : float
        Detector statistical RMS (as fraction)
    sigma_electronics : float
        Electronics RMS noise (as fraction)
        
    Returns
    -------
    float
        Total system RMS noise (as fraction)
    """
    return np.sqrt(sigma_scintillation**2 + sigma_electronics**2)


def resolution_degradation(sigma_scintillation, sigma_electronics):
    """
    Calculate fractional resolution degradation due to electronics.
    
    Parameters
    ----------
    sigma_scintillation : float
        Detector statistical RMS (as fraction)
    sigma_electronics : float
        Electronics RMS noise (as fraction)
        
    Returns
    -------
    float
        Fractional degradation (as fraction, e.g., 0.018 for 1.8%)
    """
    sigma_total = total_system_noise(sigma_scintillation, sigma_electronics)
    return (sigma_total - sigma_scintillation) / sigma_scintillation


def fwhm_to_sigma(fwhm):
    """
    Convert FWHM to RMS sigma.
    
    Parameters
    ----------
    fwhm : float
        Full Width at Half Maximum (as fraction or percent)
        
    Returns
    -------
    float
        RMS sigma (same units as input)
    """
    return fwhm / FWHM_TO_SIGMA


def sigma_to_fwhm(sigma):
    """
    Convert RMS sigma to FWHM.
    
    Parameters
    ----------
    sigma : float
        RMS sigma (as fraction or percent)
        
    Returns
    -------
    float
        FWHM (same units as input)
    """
    return sigma * FWHM_TO_SIGMA


def snr_from_sigma(sigma_relative):
    """
    Calculate Signal-to-Noise Ratio from relative RMS.
    
    Parameters
    ----------
    sigma_relative : float
        Relative RMS noise (as fraction, e.g., 0.0475 for 4.75%)
        
    Returns
    -------
    float
        SNR (linear ratio)
    """
    return 1.0 / sigma_relative


def snr_to_db(snr_linear):
    """
    Convert linear SNR to decibels.
    
    Parameters
    ----------
    snr_linear : float
        SNR as linear ratio
        
    Returns
    -------
    float
        SNR in dB
    """
    return 20 * np.log10(snr_linear)


def db_to_snr(snr_db):
    """
    Convert SNR in decibels to linear ratio.
    
    Parameters
    ----------
    snr_db : float
        SNR in dB
        
    Returns
    -------
    float
        SNR as linear ratio
    """
    return 10 ** (snr_db / 20)


def detector_snr_db(sigma_scintillation):
    """
    Calculate detector-limited SNR in dB.
    
    Parameters
    ----------
    sigma_scintillation : float
        Detector statistical RMS (as fraction)
        
    Returns
    -------
    float
        SNR in dB
    """
    snr_linear = snr_from_sigma(sigma_scintillation)
    return snr_to_db(snr_linear)


def bandwidth_from_rise_time(t_rise):
    """
    Calculate -3dB bandwidth from 10%-90% rise time.
    
    Uses standard approximation: f_3dB ~= 0.35 / t_rise
    
    Parameters
    ----------
    t_rise : float
        10%-90% rise time in seconds
        
    Returns
    -------
    float
        -3dB bandwidth in Hz
    """
    return 0.35 / t_rise


def rise_time_from_bandwidth(f_3db):
    """
    Calculate 10%-90% rise time from -3dB bandwidth.
    
    Parameters
    ----------
    f_3db : float
        -3dB bandwidth in Hz
        
    Returns
    -------
    float
        10%-90% rise time in seconds
    """
    return 0.35 / f_3db


def required_rise_time(sampling_rate, n_samples_per_edge=4):
    """
    Calculate required analog rise time for pulse reconstruction.
    
    Parameters
    ----------
    sampling_rate : float
        ADC sampling rate in Hz (e.g., 40e6 for 40 MSPS)
    n_samples_per_edge : int, optional
        Required number of samples across rising edge (default 4)
        
    Returns
    -------
    float
        Required rise time in seconds
    """
    t_sample = 1.0 / sampling_rate
    return n_samples_per_edge * t_sample


def required_sampling_rate(t_rise, n_samples_per_edge=4):
    """
    Calculate required ADC sampling rate for given rise time.
    
    Parameters
    ----------
    t_rise : float
        Pulse rise time in seconds
    n_samples_per_edge : int, optional
        Desired number of samples across rising edge (default 4)
        
    Returns
    -------
    float
        Required sampling rate in Hz
    """
    t_sample = t_rise / n_samples_per_edge
    return 1.0 / t_sample


def nyquist_rate(bandwidth):
    """
    Calculate minimum Nyquist sampling rate.
    
    Parameters
    ----------
    bandwidth : float
        Signal bandwidth in Hz
        
    Returns
    -------
    float
        Minimum sampling rate in Hz
    """
    return 2.0 * bandwidth


def calculate_electronics_requirements(sigma_scintillation, fwhm_scintillation,
                                       tau_cell, adc_sampling_rate,
                                       budget_fraction=0.3,
                                       n_samples_per_edge=4):
    """
    Calculate complete electronics requirements from detector physics.
    
    Parameters
    ----------
    sigma_scintillation : float
        Detector statistical RMS (as fraction)
    fwhm_scintillation : float
        Detector FWHM (as fraction)
    tau_cell : float
        SiPM microcell recharge time constant in seconds
    adc_sampling_rate : float
        ADC sampling rate in Hz
    budget_fraction : float, optional
        Electronics noise budget fraction (default 0.3)
    n_samples_per_edge : int, optional
        Samples per rising edge (default 4)
        
    Returns
    -------
    dict
        Dictionary containing all derived requirements
    """
    # Noise budget
    sigma_elec_budget = electronics_noise_budget(sigma_scintillation, budget_fraction)
    sigma_total = total_system_noise(sigma_scintillation, sigma_elec_budget)
    degradation = resolution_degradation(sigma_scintillation, sigma_elec_budget)
    
    # SNR calculations
    snr_detector_linear = snr_from_sigma(sigma_scintillation)
    snr_detector_db = snr_to_db(snr_detector_linear)
    
    # Bandwidth from pulse shape
    t_rise_required = required_rise_time(adc_sampling_rate, n_samples_per_edge)
    f_3db_from_rise = bandwidth_from_rise_time(t_rise_required)
    
    # Sampling constraints
    t_sample = 1.0 / adc_sampling_rate
    f_nyquist = adc_sampling_rate / 2.0
    
    # Bandwidth from tau_cell (approximation: rise ~ tau_cell)
    f_3db_from_tau = bandwidth_from_rise_time(tau_cell)
    
    return {
        # Noise budget
        'sigma_scintillation': sigma_scintillation,
        'sigma_scintillation_pct': sigma_scintillation * 100,
        'fwhm_scintillation': fwhm_scintillation,
        'fwhm_scintillation_pct': fwhm_scintillation * 100,
        'budget_fraction': budget_fraction,
        'sigma_elec_budget': sigma_elec_budget,
        'sigma_elec_budget_pct': sigma_elec_budget * 100,
        'sigma_total': sigma_total,
        'sigma_total_pct': sigma_total * 100,
        'degradation': degradation,
        'degradation_pct': degradation * 100,
        
        # SNR
        'snr_detector_linear': snr_detector_linear,
        'snr_detector_db': snr_detector_db,
        
        # Timing
        'tau_cell_s': tau_cell,
        'tau_cell_ns': tau_cell * 1e9,
        'adc_sampling_rate_hz': adc_sampling_rate,
        'adc_sampling_rate_msps': adc_sampling_rate / 1e6,
        't_sample_s': t_sample,
        't_sample_ns': t_sample * 1e9,
        'n_samples_per_edge': n_samples_per_edge,
        't_rise_required_s': t_rise_required,
        't_rise_required_ns': t_rise_required * 1e9,
        
        # Bandwidth
        'f_3db_from_rise_hz': f_3db_from_rise,
        'f_3db_from_rise_mhz': f_3db_from_rise / 1e6,
        'f_3db_from_tau_hz': f_3db_from_tau,
        'f_3db_from_tau_mhz': f_3db_from_tau / 1e6,
        'f_nyquist_hz': f_nyquist,
        'f_nyquist_mhz': f_nyquist / 1e6,
    }