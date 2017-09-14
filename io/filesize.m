function filesize = filesize(filename)
%FILESIZE Size of file in bytes.
%
%   fjsimons-at-alum.mit.edu


fid=fopen(filename,'r','l');
fseek(fid,0,1);
filesize=ftell(fid);
fclose(fid);
