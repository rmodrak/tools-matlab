function varargout = resize(fgh,ar,len,units)
%RESIZE Resizes figure.
%   Changes the aspect ratio and length of the diagonal.

if nargin < 2
        error('Not enough input arguments.')
        
elseif nargin < 3
        if ~isscalar(ar) || ar < 0
            error(badvalue(ar))
        end
        pos = get(fgh,'Position');
        units = get(fgh,'Units');
        len = sqrt(pos(3).^2+pos(4).^2);
        
elseif nargin < 4
        if ~isscalar(len) || len < 0
            error(badvalue(len))
        elseif ~isscalar(ar) || ar < 0
            error(badvalue(ar))
        end
        pos = get(fgh,'Position');
        units = get(fgh,'Units');
        
else
        if ~isscalar(len) || len < 0
            error(badvalue(len))
        elseif ~isscalar(ar) || ar < 0
            error(badvalue(ar))
        end
        pos = get(fgh,'Position');
        
end

% resize
pos(3) = ar*len/sqrt(1+ar^2);
pos(4) = len/sqrt(1+ar^2);
set(fgh,'Units',units);
set(fgh,'Position',pos);

if nargout == 0
    % pass
elseif nargout == 1
    varargout = pos;
else
    error('Too many output arguments.')
end
