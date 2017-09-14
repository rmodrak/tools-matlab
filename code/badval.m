function msg = badvalue(name)
%BADVALUE Generates ValueError message.

% check input arguments
error(nargchk(1,1,nargin))

if ischar(name)
    msg = sprintf('ValueError: ''%s''',name);
    
elseif ~isempty(inputname(1))
    msg = sprintf('ValueError: %s',name);
    
else
    msg = sprintf('ValueError');
    
end
