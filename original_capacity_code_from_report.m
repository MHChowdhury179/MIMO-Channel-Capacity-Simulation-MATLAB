% original_capacity_code_from_report.m
% MATLAB code for finding ergodic capacity of Nr x Nt fading MIMO channel
% with no channel knowledge at the transmitter.

clc;
clear all;

N = 30000;          % Number of iterations for H
No = 1;             % Noise variance
nt = 2;             % Number of transmit antennas
nr = 2;             % Number of receive antennas

% Correlation of antennas
rhot = 0;           % Correlation coefficient at transmitter
rhor = 0;           % Correlation coefficient at receiver
Rt = ExponencorrMrtx(nt, rhot);
Rr = ExponencorrMrtx(nr, rhor);

% SNR of channel
SNRdB = 0:1:15;
l = length(SNRdB);
SNR = zeros(1, l);
P = zeros(1, l);

% Creation of SNR from 1 to L
for i = 1:l
    SNR(i) = 10^(0.1 * SNRdB(i));
    P(i) = SNR(i) * No;
end

% Calculation of ergodic capacity
Erg_Cap_unknown = zeros(1, l);

for i = 1:l
    C_unknown = zeros(1, N);
    for j = 1:N
        H = CGM(nr, nt, Rr, Rt);
        C_unknown(j) = real(log2(det(eye(nr) + (SNR(i) / nt) * (H * H'))));
    end
    Erg_Cap_unknown(i) = mean(C_unknown);
    fprintf('%e\t%e\n', SNRdB(i), Erg_Cap_unknown(i));
end

% Plotting of ergodic capacity versus SNR
plot(SNRdB, Erg_Cap_unknown, ':r*');
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Ergodic capacity versus SNR');
grid on;
hold on;
