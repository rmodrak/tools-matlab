function writelines(filename, lines)
%READLINES Reads lines from text file, removing newlines.
%   LINES = READLINES(FILE)

narginchk(2,2)

assert(iscellstr(lines))

fid = fopen(filename,'w');
if fid < 1
    error('Could not open file: %s', filename)
end

for i=1:length(lines)
    fprintf(fid, '%s\n', lines{i});
end
fclose(fid);