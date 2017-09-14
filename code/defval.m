function defval(name,value)
%DEFVAL Assigns value to variable.
%   DEFVAL(NAME,VALUE) creates the named variable and assigns to it the 
%   specified value. If the named variable already exists, no new
%   assignment is carried out.
%
%   note: It appears defval('foo',functioncall) evaluates 'functioncall'
%   regardless of whether or not 'foo' has been assigned.
%
%   see also: DEFSTRUCT
%
%   fjsimons-at-alum.mit.edu


if ~isvarname(name)
   error('NAME must be a variable name enclosed by single quotes.') 
end

%check if variable already exists
ex = 1;
if evalin('caller',[ 'exist(''' name ''',''var'')']);
  ex = evalin('caller',[ 'isempty(' name ')']);
end

if ex
  assignin('caller',name,value);
end
