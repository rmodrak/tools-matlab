function flipaxis(axh,opt)
%FLIPAXIS Reverses direction of axis.

% check input arguments
if nargin < 1
    axh = gca;
end
if nargin < 2,
    opt = select({'x','y','z'});
end

switch opt
    case {'x','y','z'}
        property=strcat(opt,'dir');
    otherwise
        error('Invalid option.')
end

value=get(axh,property);
if strcmp(value,'normal')
    set(axh,property,'reverse')
    
elseif strcmp(value,'reverse')
    set(axh,property,'normal')
    
end

