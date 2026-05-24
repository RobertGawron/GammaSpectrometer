from typing import Dict, Tuple

import numpy as np


def extract_waveform_metrics(
    raw,
    config: dict,
) -> Tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    # Duplicated from afe_linearity_characterization for ANA-003 independence.

    steps = raw.get_steps()
    num_steps: int = len(steps)

    if num_steps == 0:
        raise RuntimeError("No simulation steps found.")

    input_amplitudes: list[float] = []

    current_trace = raw.get_trace("I(B1)")

    for step_index in range(num_steps):
        i_wave = np.real(current_trace.get_wave(step_index))
        i_peak = float(np.max(np.abs(i_wave)))
        input_amplitudes.append(i_peak)

    input_amplitudes_array = np.array(input_amplitudes)

    output_peaks: list[float] = []
    output_baselines: list[float] = []
    output_common_mode: list[float] = []

    trace_p_name = config["simulation"]["trace"]["output_positive"]
    trace_n_name = config["simulation"]["trace"]["output_negative"]

    trace_p = raw.get_trace(trace_p_name)
    trace_n = raw.get_trace(trace_n_name)

    for step_index in range(num_steps):
        vout_p = np.real(trace_p.get_wave(step_index))
        vout_n = np.real(trace_n.get_wave(step_index))

        vdiff = vout_p - vout_n
        vcm = (vout_p + vout_n) / 2.0

        baseline_samples = max(1, int(0.05 * len(vdiff)))

        baseline_diff = float(np.mean(vdiff[:baseline_samples]))
        baseline_cm = float(np.mean(vcm[:baseline_samples]))

        peak_value = float(np.max(np.abs(vdiff - baseline_diff)))

        output_peaks.append(peak_value)
        output_baselines.append(baseline_diff)
        output_common_mode.append(baseline_cm)

    return (
        input_amplitudes_array,
        np.array(output_peaks),
        np.array(output_baselines),
        np.array(output_common_mode),
    )


def evaluate_dc_operating_point(
    output_baselines: np.ndarray,
    output_common_mode: np.ndarray,
    full_scale_voltage: float,
    vref: float,
) -> Dict[str, float]:
    # Duplicated from afe_linearity_characterization for ANA-003 independence.

    mean_diff = float(np.mean(output_baselines))
    mean_cm = float(np.mean(output_common_mode))

    fs_peak = full_scale_voltage / 2.0

    diff_ok = abs(mean_diff) < 0.05 * fs_peak
    cm_ok = abs(mean_cm - vref) < 0.05 * vref

    return {
        "mean_diff": mean_diff,
        "mean_cm": mean_cm,
        "dc_check": diff_ok and cm_ok,
    }


def compute_adc_utilization(
    gain_measured: float,
    max_detector_current: float,
    full_scale_voltage: float,
) -> Tuple[float, float]:

    fs_peak = full_scale_voltage / 2.0
    v_peak = gain_measured * max_detector_current
    utilization_percent = (v_peak / fs_peak) * 100.0

    return v_peak, utilization_percent


def compute_gain_compression(
    input_amplitudes: np.ndarray,
    output_peaks: np.ndarray,
    points_for_high_region: int = 3,
) -> Tuple[float, float, float]:
    """
    Compute gain compression using last N sweep points.

    gain_full: regression over entire sweep
    gain_high: regression over last N points
    """

    if len(input_amplitudes) < points_for_high_region + 2:
        raise RuntimeError("Insufficient sweep points for gain compression.")

    # Full-scale regression
    coeffs_full = np.polyfit(input_amplitudes, output_peaks, 1)
    gain_full = float(coeffs_full[0])

    # High-scale regression using last N points
    high_indices = np.arange(
        len(input_amplitudes) - points_for_high_region,
        len(input_amplitudes),
    )

    coeffs_high = np.polyfit(
        input_amplitudes[high_indices],
        output_peaks[high_indices],
        1,
    )

    gain_high = float(coeffs_high[0])

    compression_percent = ((gain_full - gain_high) / gain_full) * 100.0

    return gain_full, gain_high, compression_percent


def detect_clipping(
    output_peaks: np.ndarray,
    full_scale_voltage: float,
) -> bool:

    fs_peak = full_scale_voltage / 2.0
    return bool(np.any(output_peaks > fs_peak))
