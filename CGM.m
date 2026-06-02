function out = CGM(nr, nt, Rr, Rt)
% CGM generates a complex Gaussian Rayleigh fading MIMO channel matrix.
%
% Inputs:
%   nr - Number of receive antennas
%   nt - Number of transmit antennas
%   Rr - Receive correlation matrix
%   Rt - Transmit correlation matrix
%
% Output:
%   out - Complex Gaussian MIMO channel matrix

X = sqrt(0.5) * randn(nr, nt) + 1i * sqrt(0.5) * randn(nr, nt);
out = sqrtm(Rr) * X * sqrtm(Rt);
end
