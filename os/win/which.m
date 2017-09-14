function varargout = which(varargin)
%WHICH Overloads built-in.

if nargout > 1
    error('CYGWIN:WHICH:TooManyOutputArguments','Too many output arguments.')
end

listing = fullfile(builtin('which',varargin{:}));

if nargout == 0
    if ~isempty(listing)
        disp(char(listing))
    else
        disp('not found')
    end
else
    varargout{1} = listing;
end
