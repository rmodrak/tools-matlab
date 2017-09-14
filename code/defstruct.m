function defstruct(name,fields,values)
%DEFSTRUCT Assigns values to structure.
%   DEFSTRUCT(NAME,FIELDS,VALUES) creates the named structure and assigns
%   to it the specified fields and values. If the named structure already
%   exists, no new assignment is carried out. NAME must be a valid MATLAB
%   variable name enclosed by single quotes, FIELDS must be a cell array of
%   strings, and VALUES must be a cell array.
%
%   fjsimons-at-alum.mit.edu

% check input arguments
if ~isvarname(name)
    error(badval(name,'must be a variable name enclosed by single quotes'))

elseif ~iscellstr(fields);
    error(badval(fields,'must be a cell array of strings'))

elseif ~iscell(values);
    error(badval(values,'must be a cell array'))

elseif ~isequal(size(fields),size(values))
    error(badval({fields,values},'must have the same length'))

end

% check if structure already exists
chk = 1;

if evalin('caller',[ 'exist(''' name ''',''var'')']);
    chk = evalin('caller',[ 'isempty(' name ')']);
end

if chk
  % create cell array
  structinput=cell(2,length(fields));
  structinput(1,:)=fields';
  structinput(2,:)=values';

  % turn it into comma separated list and call struct
  s = struct(structinput{:});

  assignin('caller',name,s);

end
