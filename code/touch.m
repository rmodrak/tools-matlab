function touch(file)
%TOUCH Generates a function m-file with header text.

% create file
if exist(file, 'file')
   error([file 'already exists in the current directory.']);
end
if strcmp(suffix(file),'m')
    file = strip(file,'.m');
end
fid = fopen([file '.m'], 'w');

% print header
fprintf(fid, 'function %s\n', file);
fprintf(fid, '%%%s Brief description.\n', upper(file));
fprintf(fid, '%%   %s detailed description.\n', upper(file));
fprintf(fid, '%%   \n');
%fprintf(fid, '%% %sAuthor: %s $',  '$', uname);
%fprintf(fid, '%% %sDate: %s $',  '$', datestr(now, 'yyyy/mm/dd HH:MM:SS'));

% open file for editing
edit(file)
fclose(fid);

% ----------------------------------------
function name = uname
if ispc
   name = getenv('UserName');
else
   name = getenv('USER');
end
if isempty(name)
   warning('EmptyName', 'NAME is empty');
end
