cd('/MATLAB Drive/ECG_Matlab_project')
addpath('/MATLAB Drive/ECG_Matlab_project/mcode')

[sig, Fs, tm] = rdsamp('100', 1);

ecg_5sec = sig(1:5*Fs);
t_5sec = tm(1:5*Fs);

figure
plot(t_5sec, ecg_5sec)
xlabel('Time (seconds)')
ylabel('ECG amplitude')
title('Real ECG Signal - 5 Seconds')
grid on
saveas(gcf, fullfile('figures', 'raw_ecg.png'))
d = designfilt('bandstopiir', ...
    'FilterOrder', 4, ...
    'HalfPowerFrequency1', 49, ...
    'HalfPowerFrequency2', 51, ...
    'DesignMethod', 'butter', ...
    'SampleRate', Fs);
noise = 0.1*sin(2*pi*50*t_5sec);
ecg_noisy = ecg_5sec + noise;
ecg_filtered = filtfilt(d, ecg_noisy);
figure
plot(t_5sec, ecg_noisy)
xlabel('Time (seconds)')
ylabel('ECG amplitude')
title('ECG with 50 Hz Noise')
grid on
saveas(gcf, fullfile('/MATLAB Drive/ECG_Matlab_project/figures', 'noisy_ecg.png'))
d = designfilt('bandstopiir', ...
    'FilterOrder', 4, ...
    'HalfPowerFrequency1', 49, ...
    'HalfPowerFrequency2', 51, ...
    'DesignMethod', 'butter', ...
    'SampleRate', Fs);
ecg_filtered = filtfilt(d, ecg_noisy);
figure
plot(t_5sec, ecg_noisy)
hold on
plot(t_5sec, ecg_filtered)
xlabel('Time (seconds)')
ylabel('ECG amplitude')
title('Noisy ECG vs Filtered ECG')
legend('Noisy ECG','Filtered ECG')
grid on
saveas(gcf, fullfile('/MATLAB Drive/ECG_Matlab_project/figures', 'filtered_ecg.png'))
N = length(ecg_noisy);
Y = fft(ecg_noisy);

f = (0:N-1)*(Fs/N);

figure
plot(f, abs(Y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Content of Noisy ECG')
xlim([0 100])
grid on
saveas(gcf, fullfile('/MATLAB Drive/ECG_Matlab_project/figures', 'frequency_spectrum_noisy.png'))
N = length(ecg_filtered);
Y_filtered = fft(ecg_filtered);

f = (0:N-1)*(Fs/N);

figure
plot(f, abs(Y_filtered))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Content of Filtered ECG')
xlim([0 100])
grid on
saveas(gcf, fullfile(pwd, 'figures', 'frequency_spectrum_filtered.png'))
baseline = 0.3*sin(2*pi*0.5*t_5sec);
ecg_baseline_noisy = ecg_5sec + baseline;
figure
plot(t_5sec, ecg_baseline_noisy)
xlabel('Time (seconds)')
ylabel('ECG amplitude')
title('ECG with Baseline Wander')
grid on
figure
plot(t_5sec, ecg_baseline_noisy)
hold on
plot(t_5sec, ecg_filtered)
xlabel('Time (seconds)')
ylabel('ECG amplitude')
title('Baseline Wander: Before vs After Filtering')
legend('Baseline Noisy','Filtered')
grid on

% R-peak detection in the real ECG
[pks, locs] = findpeaks(ecg_5sec, ...
    'MinPeakDistance', round(0.25*Fs), ...
    'MinPeakProminence', 0.4);

% Display detected R-peaks
figure
plot(t_5sec, ecg_5sec)
hold on
plot(t_5sec(locs), pks, 'rv', 'MarkerFaceColor', 'r')
xlabel('Time (seconds)')
ylabel('ECG amplitude (mV)')
title('Real ECG with Detected R-Peaks')
legend('ECG Signal', 'Detected R-Peaks')
grid on
hold off

% Count detected peaks
number_of_peaks = length(pks)

% Calculate heart rate from R-peak intervals
R_times = t_5sec(locs);
RR_intervals = diff(R_times);

heart_rate = 60 / mean(RR_intervals);

fprintf('Detected R-peaks: %d\n', length(pks));
fprintf('Estimated Heart Rate: %.2f BPM\n', heart_rate);

% Plot ECG with detected R-peaks
figure
plot(t_5sec, ecg_5sec)
hold on
plot(t_5sec(locs), pks, 'rv', 'MarkerFaceColor', 'r')
xlabel('Time (seconds)')
ylabel('ECG amplitude (mV)')
title('Real ECG with Detected R-Peaks')
legend('ECG Signal', 'Detected R-Peaks')
grid on
hold off

% Save the R-peak figure
saveas(gcf, fullfile(pwd, 'figures', 'r_peaks.png'))
