function out = ExponencorrMrtx(n, rho)
% ExponencorrMrtx generates an n x n exponential correlation matrix.
%
% Input:
%   n   - Matrix dimension
%   rho - Correlation coefficient
%
% Output:
%   out - Exponential correlation matrix

A = ones(n);
for i = 1:n
    for j = 1:n
        if i == j
            A(i, j) = 1;
        elseif i > j
            A(i, j) = rho^(i - j);
        else
            A(i, j) = rho^(j - i);
        end
    end
end
out = A;
end
