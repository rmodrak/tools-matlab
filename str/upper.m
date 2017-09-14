function s = upper(string,delim)
%UPPER Overloads builtin

if ischar(string)
    s = builtin('upper',string);

elseif iscellstr(string)
    s = cellfun(@upper,string,'UniformOutput',0);

else
    error('Input must be string or cell array of strings.')

end
