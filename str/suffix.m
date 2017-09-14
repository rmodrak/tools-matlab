function s = suffix(string,delim)
%SUFFIX Returns the suffix of a string.
%   SUFFIX(STRING,DELIM) returns the suffix of a string, defined as the
%   subtring that follows the last occurrence of the delimiter.
% 
%   see also: PREFIX

defval('delim','.');

if ischar(string)
    len=length(delim);
    [s,t] = strtok(string,delim);
    if isempty(t)
        return
    else
        s = suffix(t(len+1:end),delim);
    end

elseif iscellstr(string)
    delim = repmat({delim},size(string));
    s = cellfun(@suffix,string,delim,'UniformOutput',0);

else
    error('Input must be string or cell array of strings.')

end
