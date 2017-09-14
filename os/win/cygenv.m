function cygenv

% set up cygwin environment
if 1
    setenv('Path',sprintf('%s;%s','C:/cygwin/bin;C:/cygwin/usr/bin;C:/cygwin-home/bin',getenv('Path')));
    setpath({getpath('D:/My Documents/MATLAB/os/cygwin',0)},'-begin');
    setenv('CYGWIN','nodosfilewarning');
end