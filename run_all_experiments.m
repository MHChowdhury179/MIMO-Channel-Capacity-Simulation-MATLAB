% run_all_experiments.m
% MIMO Channel Capacity Simulation
% This script reproduces the major simulation cases from the report.

clc;
clear;
close all;

N = 30000;              % Number of Monte Carlo iterations
No = 1;                 % Noise variance
SNRdB = 0:1:35;         % SNR range in dB
rhot = 0;               % Transmit antenna correlation coefficient
rhor = 0;               % Receive antenna correlation coefficient

%% Figure 1: Effect of transmitting antennas, nr = 4
nr = 4;
nt_values = [2 4 6];
figure;
hold on;
for k = 1:length(nt_values)
    nt = nt_values(k);
    cap = mimo_capacity(nt, nr, SNRdB, N, rhot, rhor, No);
    plot(SNRdB, cap, 'LineWidth', 1.5, 'DisplayName', ['nt = ' num2str(nt)]);
end
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Ergodic capacity versus SNR');
grid on;
legend('show');
saveas(gcf, 'fig_transmit_effect_nr4.png');

%% Figure 2: Effect of transmitting antennas, nr = 2
nr = 2;
nt_values = [2 4 6 8 10 12];
figure;
hold on;
for k = 1:length(nt_values)
    nt = nt_values(k);
    cap = mimo_capacity(nt, nr, SNRdB, N, rhot, rhor, No);
    plot(SNRdB, cap, 'LineWidth', 1.5, 'DisplayName', ['nt = ' num2str(nt)]);
end
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Effect of Transmitting Antennas');
grid on;
legend('show');
saveas(gcf, 'fig_transmit_effect_nr2.png');

%% Figure 3: Effect of receiving antennas, nt = 4
nt = 4;
nr_values = [2 4 6];
figure;
hold on;
for k = 1:length(nr_values)
    nr = nr_values(k);
    cap = mimo_capacity(nt, nr, SNRdB, N, rhot, rhor, No);
    plot(SNRdB, cap, 'LineWidth', 1.5, 'DisplayName', ['nr = ' num2str(nr)]);
end
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Ergodic capacity versus SNR');
grid on;
legend('show');
saveas(gcf, 'fig_receive_effect_nt4.png');

%% Figure 4: Effect of receiving antennas, nt = 4
nt = 4;
nr_values = [2 4 6 8 10 12];
figure;
hold on;
for k = 1:length(nr_values)
    nr = nr_values(k);
    cap = mimo_capacity(nt, nr, SNRdB, N, rhot, rhor, No);
    plot(SNRdB, cap, 'LineWidth', 1.5, 'DisplayName', ['nr = ' num2str(nr)]);
end
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Effect of Receiving Antennas');
grid on;
legend('show');
saveas(gcf, 'fig_receive_effect_nt4_multiple.png');

%% Figure 5: Combined comparison
cases = [2 2; 4 2; 2 4];
labels = {'nt = 2, nr = 2', 'nt = 4, nr = 2', 'nt = 2, nr = 4'};
figure;
hold on;
for k = 1:size(cases, 1)
    nt = cases(k, 1);
    nr = cases(k, 2);
    cap = mimo_capacity(nt, nr, SNRdB, N, rhot, rhor, No);
    plot(SNRdB, cap, 'LineWidth', 1.5, 'DisplayName', labels{k});
end
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Combined Effect of Transmit and Receive Antennas');
grid on;
legend('show');
saveas(gcf, 'fig_combined_effect.png');
