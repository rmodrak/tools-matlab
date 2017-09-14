function tokens = tokenize(string,delim)
%TOKENIZE Splits a string into tokens.

% check input arguments
if nargin < 2
    delim = ' ';
end
    
if ischar(string)
    tokens = textscan(string,'%s','delimiter',delim);
    tokens = cat(1,tokens{:})';

elseif iscellstr(string)
    % operate on each cell individually
    delim = repmat({delim},size(string));
    tokens = cellfun(@tokenize,string,delim,'UniformOutput',0);
    
else
    error('Input must be string or cell array of strings.')
    
end
