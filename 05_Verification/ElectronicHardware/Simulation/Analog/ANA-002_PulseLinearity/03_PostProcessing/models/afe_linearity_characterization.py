from typing import Dict, Tuple

import numpy as np


def extract_waveform_metrics(
    raw,
    config: dict,
) -> Tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    """
    Extract waveform metrics from LTspice RAW object.

    Parameters
    ----------
    raw : RawRead
        Parsed LTspice RAW object.
    config : dict
        Configuration dictionary containing trace names.

    Returns
    -------
    input_amplitudes : ndarray
        Peak input current per step (A).
    output_peaks : ndarray
        Differential output peak amplitude per step (V).
    output_baselines : ndarray
        Differential baseline voltage per step (V).
    output_common_mode : ndarray
        Common-mode voltage per step (V).
    """

    steps = raw.get_steps()
    num_steps: int = len(steps)

    if num_steps == 0:
        raise RuntimeError("No simulation steps found in RAW file.")

    # ------------------------------------------------------------
    # Extract input current amplitude
    # I_peak = max(|I(t)|)
    # ------------------------------------------------------------
    input_amplitudes: list[float] = []

    try:
        current_trace = raw.get_trace("I(B1)")
    except Exception as exc:
        raise RuntimeError("Input current trace 'I(B1)' not found.") from exc

    for step_index in range(num_steps):
        i_wave: np.ndarray = np.real(current_trace.get_wave(step_index))
        i_peak: float = float(np.max(np.abs(i_wave)))
        input_amplitudes.append(i_peak)

    input_amplitudes_array: np.ndarray = np.array(input_amplitudes)

    # ------------------------------------------------------------
    # Extract differential output metrics
    # Vdiff = V(out_p) - V(out_n)
    # ------------------------------------------------------------
    output_peaks: list[float] = []
    output_baselines: list[float] = []
    output_common_mode: list[float] = []

    trace_p_name: str = config["simulation"]["trace"]["output_positive"]
    trace_n_name: str = config["simulation"]["trace"]["output_negative"]

    try:
        trace_p = raw.get_trace(trace_p_name)
        trace_n = raw.get_trace(trace_n_name)
    except Exception as exc:
        raise RuntimeError("Output traces not found in RAW file.") from exc

    for step_index in range(num_steps):
        vout_p: np.ndarray = np.real(trace_p.get_wave(step_index))
        vout_n: np.ndarray = np.real(trace_n.get_wave(step_index))

        # Differential voltage
        vdiff: np.ndarray = vout_p - vout_n

        # Common-mode voltage
        vcm: np.ndarray = (vout_p + vout_n) / 2.0

        baseline_samples: int = max(1, int(0.05 * len(vdiff)))

        baseline_diff: float = float(np.mean(vdiff[:baseline_samples]))
        baseline_cm: float = float(np.mean(vcm[:baseline_samples]))

        # Peak differential excursion from baseline
        peak_value: float = float(np.max(np.abs(vdiff - baseline_diff)))

        output_peaks.append(peak_value)
        output_baselines.append(baseline_diff)
        output_common_mode.append(baseline_cm)

    return (
        input_amplitudes_array,
        np.array(output_peaks),
        np.array(output_baselines),
        np.array(output_common_mode),
    )


def fit_gain(
    input_amplitudes: np.ndarray,
    output_peaks: np.ndarray,
    full_scale_voltage: float,
) -> Tuple[float, np.ndarray, np.ndarray]:
    """
    Perform linear regression fit over valid full-scale region.

    Equation:
        V_fit = a * I + b

    where:
        I = input current (A)
        V = differential peak voltage (V)

    Parameters
    ----------
    input_amplitudes : ndarray
        Input current per step (A).
    output_peaks : ndarray
        Differential peak amplitude per step (V).
    full_scale_voltage : float
        ADC full-scale differential voltage (Vpp).

    Returns
    -------
    gain_measured : float
        Measured transimpedance gain (V/A).
    fit_line : ndarray
        Fitted output voltage for all input points (V).
    valid_region : ndarray
        Boolean mask of points within full-scale region.
    """

    # Full-scale peak amplitude:
    # V_FS_peak = V_FS_pp / 2
    FS_peak: float = full_scale_voltage / 2.0

    valid_region: np.ndarray = output_peaks <= FS_peak

    if np.sum(valid_region) < 3:
        raise RuntimeError("Insufficient points within full-scale region.")

    x: np.ndarray = input_amplitudes[valid_region]
    y: np.ndarray = output_peaks[valid_region]

    # Linear regression:
    # coeffs[0] = slope (gain)
    # coeffs[1] = intercept
    coeffs: np.ndarray = np.polyfit(x, y, 1)

    gain_measured: float = float(coeffs[0])
    fit_line: np.ndarray = np.polyval(coeffs, input_amplitudes)

    return gain_measured, fit_line, valid_region


def compute_inl(
    output_peaks: np.ndarray,
    fit_line: np.ndarray,
    linear_region: np.ndarray,
    full_scale_voltage: float,
    adc_lsb: float,
) -> Tuple[np.ndarray, np.ndarray, np.ndarray, float, float, float]:
    """
    Compute integral non-linearity (INL).

    INL definition:
        INL_volts = V_measured - V_fit

    Normalization:
        INL_percent = INL_volts / V_FS_peak * 100

    Parameters
    ----------
    output_peaks : ndarray
        Measured differential peak amplitudes (V).
    fit_line : ndarray
        Linear regression fitted values (V).
    linear_region : ndarray
        Boolean mask of valid full-scale region.
    full_scale_voltage : float
        ADC differential full-scale voltage (Vpp).
    adc_lsb : float
        ADC least significant bit size (V).

    Returns
    -------
    inl_volts : ndarray
    inl_percent : ndarray
    inl_lsb : ndarray
    max_inl_volts : float
    max_inl_percent : float
    max_inl_lsb : float
    """

    FS_peak: float = full_scale_voltage / 2.0

    # INL in volts
    inl_volts: np.ndarray = output_peaks - fit_line

    # INL normalized to full-scale peak
    inl_percent: np.ndarray = (inl_volts / FS_peak) * 100.0

    # INL in LSB
    inl_lsb: np.ndarray = inl_volts / adc_lsb

    max_inl_volts: float = float(np.max(np.abs(inl_volts[linear_region])))
    max_inl_percent: float = float(np.max(np.abs(inl_percent[linear_region])))
    max_inl_lsb: float = float(np.max(np.abs(inl_lsb[linear_region])))

    return (
        inl_volts,
        inl_percent,
        inl_lsb,
        max_inl_volts,
        max_inl_percent,
        max_inl_lsb,
    )


def evaluate_dc_operating_point(
    output_baselines: np.ndarray,
    output_common_mode: np.ndarray,
    full_scale_voltage: float,
    vref: float,
) -> Dict[str, float]:
    """
    Evaluate DC operating point stability.

    Conditions:
        Differential baseline near 0 V
        Common-mode near reference voltage

    Differential tolerance:
        5 percent of full-scale peak

    Common-mode tolerance:
        5 percent of reference voltage
    """

    mean_diff: float = float(np.mean(output_baselines))
    diff_drift: float = float(np.max(output_baselines) - np.min(output_baselines))

    mean_cm: float = float(np.mean(output_common_mode))
    cm_drift: float = float(np.max(output_common_mode) - np.min(output_common_mode))

    FS_peak: float = full_scale_voltage / 2.0

    diff_ok: bool = abs(mean_diff) < 0.05 * FS_peak
    cm_ok: bool = abs(mean_cm - vref) < 0.05 * vref

    return {
        "mean_diff": mean_diff,
        "diff_drift": diff_drift,
        "mean_cm": mean_cm,
        "cm_drift": cm_drift,
        "diff_ok": diff_ok,
        "cm_ok": cm_ok,
        "dc_check": diff_ok and cm_ok,
    }
