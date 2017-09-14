function [sts, msg] = replace(string_old,string_new,file_old,file_new)
%REPLACE Replaces string in text file.
%   REPLACE(STRING_OLD, STRING_NEW, FILE_OLD, FILE_NEW) copies FILE_OLD to
%   FILE_NEW and replaces each occurence of STRING_OLD with STRING_NEW.
%
%   REPLACE(STRING_OLD, STRING_NEW, FILE) replaces each occurrence of
%   STRING_OLD with STRING_NEW, creating a backup.
%
%   REPLACE(STRING_OLD, STRING_NEW, FILE, '-nobackup') replaces each
%   occurrence of STRING_OLD with STRING_NEW, without creating a backup.
%
%   REPLACE(STRING_OLD, STRING_NEW) prompts user for FILE and replaces each
%   occurrence of STRING_OLD with STRING_NEW in the file after creating a
%   backup.
%
%   Copyright (c) 2009 Pekka Kumpulainen, All rights reserved

% check input arguments
msg = nargchk(2,4,nargin);
if ~isempty(msg)
    error(msg)
end

if ~ischar(string_new) || ~ischar(string_old)
    error('First two arguments must be strings.')
end

% escape special characters
switch string_new
    case {'\' '.'}
        string_new = ['\' string_new];
end

% prompt for file if not given
if nargin < 3;

    [fn, fpath] = uigetfile('*.*','FILE_OLD (open)');
    if ~ischar(fn)
        return
    end
    file_old = fullfile(fpath,fn);

    [fn, fpath] = uiputfile('*.*','FILE_NEW (save as)');
    if ~ischar(fn)
        return
    end
    file_new = fullfile(fpath,fn);
    
end

% generate command
perlcmd = sprintf('"%s"', fullfile(matlabroot,'sys\perl\win32\bin\perl'));
perlcmd = sprintf('%s -i.bak -pe"s/%s/%s/g" "%s"', ...
    perlcmd, string_new, string_old, file_old);

% replace text string
[sts,msg] = dos(perlcmd);
if ~isempty(msg)
    error(msg)
else
    if nargin > 3
        if strcmp('-nobackup',file_new)
            delete(sprintf('%s.bak',file_old));
        else
            movefile(file_old, file_new);
            movefile(sprintf('%s.bak',file_old), file_old);
        end
    end
end
