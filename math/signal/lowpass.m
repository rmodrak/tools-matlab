function y = lowpass(y,freq,df,npass)
%LOWPASS Lowpass filter. 
%   LOWPASS(Y,FREQ,DF,NPASS) applies Butterworth filter with cutoff
%   frequency FREQ.

error(nargchk(3,4,nargin))

% check input arguments
if ~isscalar(freq) || (freq < 0)
    error('freq must be a positive scalar.');

elseif ~isscalar(df) || (df < 0)
    error('df must be a positive scalar.');
    
end

if nargin < 4
    npass = 2;
end

% create filter
freqny = 0.5*df;
cutoff = freq/freqny;
[b,a] = butter(npass,cutoff,'low');

% apply filter
y = filtfilt(b,a,y);
