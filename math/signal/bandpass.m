function y = bandpass(y,freqlo,freqhi,fs,npass)
%BANDPASS Bandpass filter. 
%   BANDPASS(Y,FREQLO,FREQHI,FS,NPASS) applies Butterworth filter with
%   cutoff frequencies FREQLO and FREQHI.

error(nargchk(4,5,nargin))

% check input arguments
if ~isscalar(freqlo) || ~isscalar(freqhi)
    error(badval(freqlo,freqhi));
    
elseif (freqlo < 0) || (freqhi < freqlo)
    error(badval(freqlo,freqhi));

elseif ~isscalar(fs) || (fs < 0)
    error(badval(fs));

end

if nargin < 5
    npass = 2;
end

% create filter
wn = [freqlo freqhi]/(0.5*fs);
[b,a] = butter(npass,wn);

% apply filter
y = filtfilt(b,a,y);
