function varargout=ls(varargin)
%LS List directory.
%   LS displays the results of the 'ls' command on UNIX. On UNIX, 
%   LS returns a character row vector of filenames separated 
%   by tab and space characters. On Windows, LS returns an m-by-n 
%   character array of filenames, where m is the number of filenames 
%   and n is the number of characters in the longest filename found. 
%   Filenames shorter than n characters are padded with space characters.
%
%   You can pass any flags to LS as well that your operating system supports.
%
%   See also DIR, MKDIR, RMDIR, FILEATTRIB, COPYFILE, MOVEFILE, DELETE.

%   Copyright 1984-2008 The MathWorks, Inc.
%   $Revision: 5.17.4.8 $  $Date: 2008/09/15 20:39:18 $
%

%=============================================================================
%   Modified as follows:
%
%   If ISCYGWIN is true, then calls cygwin ls.exe executable, provided that
%   it lies first in the Windows path. Before passing arguments to
%   'ls.exe', all occurences of '\' are replaced with '/'.
%
%   If nargout == 0, the output is identical to 'ls.exe' invoked in a 
%   standard cygwin shell. In particular, the contents of any directories
%   supplied as input arguments are fully listed.
%
%   If nargout ~= 0, listing directory contents is suppressed, and a cell
%   array of strings is returned rather than a character array as in the
%   original implementation.
%
%   If ISCYGWIN is false, reverts to original implementation.
%   
%=============================================================================

% validate input parameters
if ~iscellstr(varargin)
    error('MATLAB:ls:InputsMustBeStrings', 'Inputs must be strings.');
end

% check output arguments
if nargout > 1
    error('MATLAB:LS:TooManyOutputArguments','Too many output arguments.')
end

% platform specific directory listing
if isunix || ismac
    if nargout == 0
        args = strrep(varargin,'\','/');
        listing = ls_unix('-1', args{:});
    else
        args = strrep(varargin,'\','/');
        listing = ls_unix('-1 -d', args{:});
    end
    
% elseif iscygwin
%     if nargout == 0
%         args = strrep(varargin,'\','/');
%         listing = ls_cygwin(args{:});
%     else
%         args = strrep(varargin,'\','/');
%         listing = ls_cygwin('-d','--group-directories-first',args{:});
%     end

else
    listing = ls_windows(varargin{:});
    
end

% determine output mode, depending on presence of output arguments
if nargout == 0
    disp(listing)
    
elseif isunix || ismac % | iscygwin
    % return a cell array of strings rather than a two-dimensional character array
    n = numel(strfind(listing,sprintf('\n')));
    cellarray = cell(n,1);
    for i=1:n
        [tok,rem] = strtok(listing,sprintf('\n'));
        cellarray{i} = tok;
        listing = rem;
    end
    varargout{1} = cellarray;

else
    varargout{1} = listing;
    
end

%---------------------------------------------------------------------------
function listing = ls_unix(args, varargin)

if nargin == 0
    [s,listing] = unix(['ls ' args]);
else
    [s,listing] = unix(['ls ', args, quoteUnixCmdArg(varargin{:})]);
end


%---------------------------------------------------------------------------
function listing = ls_cygwin(varargin)
%cygwin binaries must exist on windows path

if nargin == 0
    [s,listing] = cygwin('ls');
else
    [s,listing] = cygwin(['ls', quoteUnixCmdArg(varargin{:})]);
end

%---------------------------------------------------------------------------
function listing = ls_windows(varargin)
if nargin == 0
    %hack to display output of dir in wide format.  dir; prints out
    %info.  d=dir does not!
    if nargout == 0
        dir;
    else
        d = dir;
        listing = char(d.name);
    end
elseif nargin == 1
    if nargout == 0
        dir(varargin{1});
    else
        d = dir(varargin{1});
        listing = char(d.name);
    end
else
    error('MATLAB:ls:TooManyInputArguments', 'Too many input arguments.')
end

%---------------------------------------------------------------------------
function quotedArgs = quoteUnixCmdArg(varargin)
% Algorithm: Start and end each argument with a single quote (squote).
%            Within each argument:
%            1. squote -> squote '\' squote squote
%            2. '!'    -> squote '\' '!' squote
%            3. '*'    -> squote '*' squote	(MATLAB globbing character)
%

% Do any tilde expansion first 
tildeArgs = varargin; 
ix = find(strncmp(tildeArgs,'~',1)); 
if ~isempty(ix)  
  tildeArgs(ix) = unix_tilde_expansion(tildeArgs(ix)); 
end 

% Special cases to maintain as literal: single quote or ! with '\thing_I_found'
quotedArgs= regexprep(tildeArgs,'[''!]','''\\$&''');

% Special cases to maintain as NOT literal: Replace * with 'thing_I_found'
quotedArgs= regexprep(quotedArgs,'[*]','''$&''');

quotedArgs = strcat(' ''', quotedArgs, '''');
quotedArgs = [quotedArgs{:}];
