function relabel(opt,varargin)

defval('fmt','%d')

if nargin == 1 || nargin == 2
    c = varargin{1};
elseif nargin == 3 || nargin == 4
    c = linspace(varargin{1},varargin{2},varargin{3});
end

% prepare cell arrays
c = num2cell(c);
if ischar(fmt)
    fmt = repmat({fmt},size(c));
end
c = cellfun(@format,c,fmt,'UniformOutput',0);

switch opt
    case 'x'
        set(gca,'xticklabel',c)
    case 'y'
        set(gca,'yticklabel',c)
end

function str = format(x,fmt)
str = sprintf(fmt,x);