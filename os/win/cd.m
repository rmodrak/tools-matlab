function varargout = cd(varargin)
%CD Overloads built-in.

if nargout > 1
    error('CYGWIN:CD:TooManyOutputArguments','Too many output arguments.')
end

listing = fixdir(builtin('cd',varargin{:}));

if nargout == 1
    varargout{1} = listing;
end
