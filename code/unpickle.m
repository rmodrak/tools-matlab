function structunload(structure,fields)
%STRUCTUNLOAD Unloads structure to workspace.

% check input arguments
assert(isstruct(structure), ...
    'First argument must be a structure.')
if nargin == 1
    fields = fieldnames(structure);
elseif nargin == 2
    if ischar(fields)
        fields = {fields};
    end
    assert(iscellstr(fields), ...
        'Second argument must be a string or cell array of strings.')
end

% for field in fields
for ii=1:length(fields)
    % get a particular field
    field = fields{ii};

    % get corresponding value
    value = getfield(structure,fields{ii});
  
    % unload to workspace
     assignin('caller',field,value);
end
