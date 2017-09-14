function fh = mergein(fh,n)
%MERGEIN Merges function input arguments.
%   MERGEIN creates a new function with one vector argument from original
%   function with multiple scalar arguments.

% check input arguments
error(nargchk(2,2,nargin))

if ~isa(fh,function_handle)
    error('FH must be a function handle.')

elseif ~isscalar(n)
    error('N must be a scalar.')
    
elseif (n < 2)
    error('N must be >= 2.')

end

% build arguments string
arguments = 'x1';
for i=2:n
    args = sprintf('%s,x%d',args,i);
end

% build command string
cmd = sprintf('fh=@(%s)%s([%s])',args,fh,args);

% create new function handle
evalc(cmd);
