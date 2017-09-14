function s = strip(string,delim)
%STRING Strips the suffix from a string.
%   STRIP(STRING,DELIM) strips the suffix from a string, defined as the
%   subtring that follows the last occurrence of the delimiter.
% 
%   see also: SUFFIX, PREFIX

defval('delim','.');

if ischar(string)
    len = length(delim);
    [s,t] = strtok(fliplr(string),delim);
    if isempty(t)
        s = fliplr(s);
    else
        s = fliplr(t(len+1:end));
    end
    
elseif iscellstr(string)
    delim = repmat({delim},size(string));
    s = cellfun(@strip,string,delim,'UniformOutput',0);
    
else
   error('Input must be string or cell array of strings.')
    
end
