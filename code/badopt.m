function msg = badname(name)
%BADNAME Generates error message.

% check input arguments
error(nargchk(1,1,nargin))

if ischar(name)
    msg = sprintf('NameError: ''%s''',name);
    
elseif ~isempty(inputname(1))
    msg = sprintf('NameError: %s',name);
    
else
    msg = sprintf('NameError');
    
end
