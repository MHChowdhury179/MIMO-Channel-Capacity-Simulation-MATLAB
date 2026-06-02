function Erg_Cap = mimo_capacity(nt, nr, SNRdB, N, rhot, rhor, No)
% mimo_capacity calculates ergodic capacity of a Rayleigh fading MIMO channel.
%
% Inputs:
%   nt     - Number of transmit antennas
%   nr     - Number of receive antennas
%   SNRdB  - SNR values in dB
%   N      - Number of Monte Carlo iterations
%   rhot   - Transmitter antenna correlation coefficient
%   rhor   - Receiver antenna correlation coefficient
%   No     - Noise variance
%
% Output:
%   Erg_Cap - Ergodic capacity in bits/sec/Hz

Rt = ExponencorrMrtx(nt, rhot);   % Transmit correlation matrix
Rr = ExponencorrMrtx(nr, rhor);   % Receive correlation matrix

SNR = 10.^(0.1 .* SNRdB);         % Convert SNR from dB to linear scale
Erg_Cap = zeros(1, length(SNRdB));

for i = 1:length(SNRdB)
    C = zeros(1, N);
    for j = 1:N
        H = CGM(nr, nt, Rr, Rt);  % Generate Rayleigh fading channel
        C(j) = real(log2(det(eye(nr) + (SNR(i) / nt) * (H * H'))));
    end
    Erg_Cap(i) = mean(C);
    fprintf('SNR = %2d dB, Capacity = %.6f bits/sec/Hz\n', SNRdB(i), Erg_Cap(i));
end
end
