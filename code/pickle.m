function structload(s,fields)
%STRUCTLOAD Loads workspace to structure.
%   STRUCTLOAD(S) Loads variables from workspace to structure. If an
%   existing structure is given as input, then its fields are updated. If a
%   character string is given, then a new structure is created containing
%   all the variables from the workspace.
%
%   STRUCTLOAD(S,FIELDS) updates given fields of an existing structure.


% check input arguments
if nargin == 0
    error('Not enough input arguments.')

elseif nargin == 1
    if isstruct(s)
        name = inputname(1);
        fields = fieldnames(s);
        
    elseif ischar(s)
        name = s;
        fields = evalin('caller','who');
        
    else
        error('S must be an existing structure.')
    end

elseif nargin == 2
    if ischar(fields)
        fields = {fields};
    end
    
    if ~isstruct(s)
        error('Error loading structure.')
    end
    
    if ~ischar(fields) && ~iscellstr(fields)
        error('FIELDS must be a cell array of strings.')
    end
    
    fields = union(fieldnames(s),fields);
    name = inputname(1);
    
else
    error('Too many input arguments.')
    
end

% get values, keeping track of which variables exist and which do not
values = cell(length(fields),1);
exists = false(length(fields),1);
for ii=1:length(fields)
    field = fields{ii};
    try
        values{ii} = {evalin('caller',field)};
    catch
        values{ii} = {getfield(s,field)};
    end
end

% prepare input for assignin
structinput = cell(2,length(fields));
structinput(1,:)=fields';
structinput(2,:)=values';

assignin('caller',name,struct(structinput{:}))
