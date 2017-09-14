function p = powspec(y,dt,opt)
%POWSPEC Computes power spectral density.
%P = POWSPEC(Y,DT) calculates the power spectral density for a time series
%   with sample interval DT. If the first argument is a matrix, the power
%   spectral density is calculated for each row.
%
%   See also: SIGNAL PROCESSING TOOLBOX.

error(nargchk(2,3,nargin))

% check input arguments
if ~isvector(y)
    error('First argument must be a vector.')
elseif ~isscalar(dt)
    error('Second argument must be a scalar.')
end

if nargin < 2
    opt = 'welch';
end

switch opt
    case 'welch'
        % pass
    case 'periodogram'
        f = fft(y')';
        p = sqrt(real(f).^2 + imag(f).^2);
end
