function dirname = fixdir(dirname)
%FIXDIR Converts to Unix style directory.
%
%   Last modified by rmodrak-at-gmail.com, 2012-08-05

dirname = strrep(dirname,'\','/');

while ~isempty(strfind(dirname,'//'))
    strrep(dirname,'//','/');
end

if ~strcmp(dirname(end),'/')
    dirname = [dirname '/'];
end

