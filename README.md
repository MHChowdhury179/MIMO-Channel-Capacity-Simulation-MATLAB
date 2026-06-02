# MIMO Channel Capacity Simulation using MATLAB

## Project Overview

This repository contains a MATLAB-based simulation project for analyzing the capacity of a Multi-Input Multi-Output (MIMO) wireless communication channel.

The main focus of this project is to observe how the number of transmitting antennas and receiving antennas affects the ergodic capacity of a MIMO channel under different Signal-to-Noise Ratio (SNR) values.

This project is based on a Digital Communication Sessional experiment titled:

**Finding the Effect of Transmitting and Receiving Antennas on the Capacity of Multi-Input Multi-Output (MIMO) Channel**



## Objective

The main objectives of this project are:

- To understand the capacity of a MIMO wireless channel.
- To analyze the effect of transmitting antennas on channel capacity.
- To analyze the effect of receiving antennas on channel capacity.
- To observe the variation of ergodic capacity with respect to SNR.
- To simulate Rayleigh fading MIMO channels using MATLAB.
- To compare the influence of transmit and receive antennas on system performance.



## Background

MIMO technology uses multiple antennas at both the transmitter and receiver sides to improve wireless communication performance. By using multiple antennas, a wireless system can increase data rate, improve reliability, and reduce the effect of fading.

The capacity of a MIMO channel depends on several factors, including:

- Number of transmitting antennas
- Number of receiving antennas
- Signal-to-Noise Ratio
- Channel fading condition
- Antenna correlation
- Noise power

In this project, MATLAB simulation is used to calculate and visualize the ergodic capacity of a MIMO fading channel.


## Mathematical Expression

The covariance matrix of the transmit signal is:

```math
R_x = E[xx^\dagger] = \frac{P_T}{n_T} I_{n_T}
```

The covariance matrix of the noise signal is:

```math
R_z = E[zz^\dagger] = N_0 I_{n_R}
```

The covariance matrix of the received signal is:

```math
R_y = \frac{P_T}{n_T}HH^\dagger + N_0 I_{n_R}
```

The entropy of the noise signal is:

```math
H(z) = \log_2 \det(\pi e N_0 I_{n_R})
```

The entropy of the received signal is:

```math
H(y) = \log_2 \det \left[\pi e \left(\frac{P_T}{n_T}HH^\dagger + N_0 I_{n_R}\right)\right]
```

The mutual information is:

```math
I(x;y) = \log_2 \det \left[I_{n_R} + \frac{P_T}{N_0 n_T}HH^\dagger\right]
```

Therefore, the MIMO channel capacity is:

```math
C = \log_2 \det \left[I_{n_R} + \frac{P_T}{N_0 n_T}HH^\dagger\right]
```



## Computer Program

### MATLAB Code for Finding MIMO Channel Capacity

```matlab
% Ergodic Capacity of Nr x Nt fading MIMO Channel with
% no channel knowledge at the transmitter.

clc;
clear all;
close all;

N = 30000;      % Number of iterations for channel matrix H
No = 1;         % Noise variance

nt = 2;         % Number of transmit antennas
nr = 2;         % Number of receive antennas

% Correlation of antennas
rhot = 0;       % Correlation coefficient at transmitter side
rhor = 0;       % Correlation coefficient at receiver side

Rt = ExponencorrMrtx(nt, rhot);   % Transmit correlation matrix
Rr = ExponencorrMrtx(nr, rhor);   % Receive correlation matrix

% SNR of channel
SNRdB = 0:1:15;                   % Signal-to-Noise Ratio in dB
l = length(SNRdB);
SNR = zeros(1, l);

% Conversion of SNR from dB to linear scale
for i = 1:l
    SNR(i) = 10^(0.1 * SNRdB(i));
    P(i) = SNR(i) * No;
end

% Calculation of ergodic capacity
Erg_Cap_unknown = zeros(1, l);

for i = 1:l
    C_unknown = zeros(1, N);

    % Calculation of capacity for each channel realization
    for j = 1:N
        H = CGM(nr, nt, Rr, Rt);   % Generate Rayleigh distributed fading channel
        C_unknown(j) = log2(det(eye(nr) + (SNR(i) / nt) * (H * H')));
    end

    % Average capacity
    Erg_Cap_unknown(i) = mean(C_unknown);

    % Printing data
    fprintf('%e\t%e\n', SNRdB(i), Erg_Cap_unknown(i));
end

% Plotting ergodic capacity versus SNR
plot(SNRdB, Erg_Cap_unknown, ':r*');
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bits/sec/Hz)');
title('Ergodic Capacity versus SNR');
grid on;
hold on;
```



## User Defined Function: Exponential Correlation Matrix

```matlab
function out = ExponencorrMrtx(n, rho)
% Generate an n x n exponential correlation matrix

A = ones(n);

for i = 1:n
    for j = 1:n
        if i == j
            A(i,j) = 1;
        end

        if i > j
            A(i,j) = rho^(i-j);
        else
            A(i,j) = rho^(j-i);
        end
    end
end

out = A;
end
```



## User Defined Function: Complex Gaussian Matrix

```matlab
function out = CGM(nr, nt, Rr, Rt)
% Generate Complex Gaussian matrix for Rayleigh fading channel

X = sqrt(0.5) * randn(nr, nt) + 1i * sqrt(0.5) * randn(nr, nt);

out = Rr^(1/2) * X * Rt^(1/2);
end
```



## Simulation Methodology

The simulation follows these major steps:

1. Define the number of transmitting antennas and receiving antennas.
2. Define the SNR range.
3. Generate the Rayleigh fading MIMO channel matrix.
4. Calculate the channel capacity for each SNR value.
5. Repeat the simulation for multiple channel realizations.
6. Calculate the average or ergodic capacity.
7. Plot ergodic capacity versus SNR.
8. Compare the effects of increasing transmitting and receiving antennas.



## Tools Used

- MATLAB
- MIMO Channel Model
- Rayleigh Fading Channel
- Ergodic Capacity Calculation
- SNR-based Performance Analysis



## MATLAB Functions Used

The simulation uses the following main MATLAB functions:

- `mimo_capacity.m`  
  Calculates the ergodic capacity of the MIMO channel.

- `CGM.m`  
  Generates a complex Gaussian matrix for Rayleigh fading channel simulation.

- `ExponencorrMrtx.m`  
  Generates an exponential correlation matrix for antenna correlation.

- `run_all_experiments.m`  
  Runs all simulation cases and plots the results.


## Results and Analysis

### Effect of Transmitting Antennas

The simulation shows that increasing the number of transmitting antennas increases the channel capacity. However, the improvement is comparatively smaller when the number of receiving antennas remains fixed.

This happens because the transmitter side does not directly experience the same noise variation as the receiver side. Therefore, changing the number of transmitting antennas has a moderate effect on the overall capacity.



### Effect of Receiving Antennas

The simulation also shows that increasing the number of receiving antennas significantly improves the channel capacity.

When more receiving antennas are used, the receiver obtains multiple versions of the transmitted signal through different propagation paths. This improves the chance of receiving a stronger signal with better SNR. As a result, the channel capacity increases noticeably.



### Combined Effect

When both transmitting and receiving antennas are increased, the MIMO channel capacity improves. However, the effect of increasing the receiving antennas is more significant than increasing the transmitting antennas.

From the simulation results, it can be concluded that the receiving antenna has a stronger influence on channel capacity compared to the transmitting antenna.



## Observation

From the simulation graphs, it is observed that the capacity of the MIMO channel increases with the increase of SNR. At low SNR values, the capacity is relatively low. As the SNR increases, the channel capacity also increases gradually.

It is also observed that increasing the number of transmitting antennas improves the capacity, but the improvement is not very large when the number of receiving antennas is fixed.

On the other hand, increasing the number of receiving antennas provides a greater improvement in capacity. This indicates that the receiver-side antenna diversity plays an important role in improving MIMO channel performance.



## Discussion

The MIMO channel capacity depends strongly on the number of antennas and the SNR value. In this project, MATLAB simulation was used to analyze the capacity variation for different antenna configurations.

The graphs show that capacity increases with SNR for all antenna combinations. This is expected because a higher SNR means the received signal is stronger compared to the noise level.

When the number of transmitting antennas is increased, the capacity increases due to spatial multiplexing. However, this improvement is limited when the number of receiving antennas remains constant.

When the number of receiving antennas is increased, the capacity improves more significantly. This is because the receiver can collect signals from multiple paths and select or combine signal components with better SNR and lower error probability.

Therefore, the receiving antenna has a more significant impact on the capacity of a MIMO channel compared to the transmitting antenna.



## Conclusion

In this project, the capacity of a MIMO wireless communication channel was analyzed using MATLAB simulation. The effect of transmitting and receiving antennas on ergodic capacity was studied by varying the number of antennas and SNR values.

The simulation results show that increasing both transmitting and receiving antennas improves channel capacity. However, increasing the number of receiving antennas has a greater impact than increasing the number of transmitting antennas.

Thus, the project successfully demonstrates the importance of antenna configuration in MIMO communication systems and shows how MATLAB can be used to analyze wireless channel capacity.



## Applications

This type of MIMO capacity analysis is useful in:

- Wireless communication systems
- 4G and 5G networks
- Antenna system design
- Digital communication studies
- Signal processing research
- Channel modeling and simulation
- Wireless network performance analysis

