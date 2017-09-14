function s = prefix(string,delim)
%PREFIX Returns prefix of a string.
%   PREFIX(STRING,DELIM) returns the prefix of a string, defined as the
%   substring that preceeds the first occurrence of the delimiter.
%
%   see also: SUFFIX

defval('delim','.');

if ischar(string)
    s = strtok(string,delim);
    
elseif iscellstr(string)
    delim = repmat({delim},size(string));
    s = cellfun(@prefix,string,delim,'UniformOutput',0);
    
else
    error('Input must be string or cell array of strings.')
    
end
