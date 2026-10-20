# ECG MATLAB Signal Analyzer

A beginner biomedical engineering project using MATLAB to explore ECG signals, simulate noise, apply digital filtering, and detect R-peaks to estimate heart rate.

## Project Overview

Electrocardiography (ECG) records the electrical activity of the heart. ECG signals can be affected by noise, making signal processing important for clearer analysis.

In this project, I used a real ECG recording from the MIT-BIH Arrhythmia Database to practice basic biomedical signal processing.

## Objectives

- Load and visualize a real ECG signal.
- Simulate 50 Hz power-line interference.
- Design and apply a Butterworth band-stop filter.
- Compare signals in the time and frequency domains.
- Detect R-peaks and estimate heart rate.

## Methods and Results

### 1. Original ECG Signal

The first five seconds of the ECG recording were selected for analysis.

![Original ECG signal](figures/raw_ecg.png)

### 2. Simulated Noise

A 50 Hz sinusoidal signal was added to demonstrate how power-line interference can affect an ECG.

![Noisy ECG signal](figures/noisy_ecg.png)

### 3. Filtering

A Butterworth band-stop filter targeting 49–51 Hz was applied using MATLAB's `designfilt` and `filtfilt` functions.

![Filtered ECG signal](figures/filtered_ecg.png)

### 4. Frequency Spectrum

The frequency spectra were compared to examine the effect of filtering on the 50 Hz interference.

**Before filtering**

![Noisy frequency spectrum](figures/frequency_spectrum_noisy.png)

**After filtering**

![Filtered frequency spectrum](figures/frequency_spectrum_filtered.png)

### 5. R-Peak Detection and Heart Rate

MATLAB's `findpeaks` function was used to detect R-peaks. The detected peaks were used to calculate RR intervals and estimate heart rate.

![Detected ECG R-peaks](figures/r_peaks.png)

The current five-second segment produced six detected R-peaks and an estimated heart rate of approximately **75.10 beats per minute (BPM)**. This is an estimate based on the selected segment and detection settings.

## Tools Used

- MATLAB
- Digital signal processing
- Butterworth band-stop filtering
- Fast Fourier Transform (FFT)
- R-peak detection and RR interval analysis

## Dataset

The ECG recording is from the **MIT-BIH Arrhythmia Database**, available through PhysioNet:

https://physionet.org/content/mitdb/1.0.0/

Please follow the dataset's access and usage terms. The original dataset files are not included in this repository.

## How to Run

1. Obtain record `100` from the MIT-BIH Arrhythmia Database.
2. Install or configure the WFDB toolbox for MATLAB so that `rdsamp` is available.
3. Place the dataset files and configure the paths as required by the script.
4. Open `ECG_project.m` in MATLAB and run it.

## Limitations

- The 50 Hz interference is simulated rather than recorded from a noisy ECG.
- R-peak detection depends on the selected parameters and may miss or incorrectly identify peaks.
- The heart-rate estimate is based on a short ECG segment.
- This project is for educational purposes only and is not intended for clinical diagnosis.

## Future Improvements

- Improve R-peak detection and validate it against reference annotations.
- Explore baseline-wander removal.
- Test filtering and detection on longer ECG recordings.
- Compare estimated heart rate with reference values.

## Author
Betselot Abdi
Biomedical Engineering student at Addis Ababa University.
# ECG-MATLAB-Signal-Analyzer
MATLAB project for ECG signal analysis, noise removal, FFT, and R-peak detection.
