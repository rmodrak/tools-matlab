function newtoks = regtok(str, exp)
% REGTOK Improves on REGEXP.
%   REGEXP makes things difficult by returning nested cell arrays. REGTOK 
%   works around this problem.

oldtoks = regexp(str, exp, 'tokens');
newtoks = cell(1,length(oldtoks));

for i=1:length(oldtoks)
    newtoks{i} = oldtoks{i}{1};
end
