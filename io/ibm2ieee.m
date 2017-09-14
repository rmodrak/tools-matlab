function d = ibm2ieee (ibmf)
%IBM2IEEE Converts IMB- to IEEE-formatted data.

aibmf = sprintf('%08x',ibmf);
%
% hexd(1) - 1st hex digit - first bit is sign, next 3 bits high order exponent
% hexd(2) - 2nd hex digit - bits of low order exponent
% hexd(3) - 3rd-8th hex digit - bits of fraction
%
hexd = sscanf(aibmf,'%1x%1x%6x',[3,inf]);
d = (1 - (hexd(1,:) >= 8) .* 2) .* ...
16 .^ ((hexd(1,:) - (hexd(1,:) >= 8) .* 8) .* 16 + hexd(2,:) ...
- 70).* hexd(3,:);
d = reshape(d,size(ibmf));
