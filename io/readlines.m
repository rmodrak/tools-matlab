function lines = readlines(filename)
%READLINES Reads lines from text file, removing newlines.
%   LINES = READLINES(FILE)

narginchk(1,1)

if ~exist(filename,'file')
    error('Could not locate file: %s', filename)
end

fid = fopen(filename,'r');
if fid < 1
    error('Could not open file: %s', filename)
end

a = textscan(fid,'%s','Delimiter','\n');
lines = a{1};

fclose(fid);