function ZS = gridsmooth(Z,span,opt)
%GRIDSMOOTH Smooth grid data.
%   GRIDSMOOTH(Z,SPAN,OPT) smooths grid data by applying filter of length
%   SPAN.

% check input
error(nargchk(2,3,nargin))

if nargin < 3
    opt = 'moving';
end

if span == 0
    ZS = Z;
    return
elseif numel(span) == 1
    span = [span span];
elseif numel(span) == 2
    % pass
else
    error(badval)
end

W = ones(size(Z));

% address NaNs
inan = isnan(Z);
if any(inan)
    Z(inan) = 0;
    W(inan) = 0;
end

switch opt
    case 'moving'
        [nr,nc] = size(Z);
        SL = spdiags(ones(nr,2*span(1)+1),(-span(1):span(1)),nr,nr);
        SR = spdiags(ones(nc,2*span(2)+1),(-span(2):span(2)),nc,nc);
        
        ZS = SL*Z*SR;
        WS = SL*W*SR;
        ZS = ZS./WS;
        
    case {'gauss' 'gaussian'}
        [X,Y] = meshgrid(2*(-span:span),2*(-span:span));
        sigma = diag(span).^2;
        F = gauss2(X,Y,[0 0],sigma);
        F = F/sum(F(:));

        ZS = convn(Z,F,'same');
        WS = convn(W,F,'same');
        ZS = ZS./WS;
        
    case 'laplacian'
        [X,Y] = meshgrid(1:size(Z,2),1:size(Z,1));
        ZS = meshsmooth(X(:),Y(:),Z(:),span,'laplacian');
        ZS = reshape(ZS,size(Z));

    case 'legacy'
        % same as 'moving', except slower
        F = ones(2*span(1)+1,2*span(2)+1)/((2*span(1)+1)*(2*span(2)+1));

        ZS = convn(Z,F,'same');
        WS = convn(W,F,'same');
        ZS = ZS./WS;

end

if any(inan)
    ZS(inan) = NaN;
end
