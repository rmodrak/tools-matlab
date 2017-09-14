function s = basename(string)
%BASENAME Behaves like UNIX 'basename'.

if ischar(string)

    try
        string = fixdir(string);
    catch
        %pass
    end

    % remove trailing slashes
    while string(end) == '/';
        string = string(1:end-1);
    end

    s = suffix(string,'/');
   
    %[status,name] = system(sprintf('basename %s',string));
    %name = name(1:end-1);

elseif iscellstr(string)
    s = cellfun(@basename,string,'UniformOutput',0);
    
else
    error('Input argument must be string or cell array of strings.')
    
end
