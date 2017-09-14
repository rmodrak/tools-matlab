function s = dirname(string)
%DIRNAME Behaves like UNIX 'dirname'.

if ischar(string)
    
    s = strip(fixdir(string),'/');

    while strcmp(string(end),'/')
        string = string(1:end-1);
    end
    
    %[status,name] = system(sprintf('basename %s',string));
    %name = name(1:end-1);
    
elseif iscellstr(string)
    s = cellfun(@dirname,string,'UniformOutput',0);
    
else
    error('Input argument must be string or cell array of strings.')
    
end
