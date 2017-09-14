function s = lower(string)
%LOWER Overloads builtin

if ischar(string)
    s = builtin('lower',string);

elseif iscellstr(string)
    s = cellfun(@lower,string,'UniformOutput',0);

else
    error('Input must be string or cell array of strings.')

end
