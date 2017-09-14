function [opt,r] = select(c)
%TXTSELECT Behaves like UNIX 'select'.
%   TXTSELECT(CELLARRAY) generates a numbered list from the entries of
%   CELLARRAY, prompts for user selection, and returns selected entry.

% generate numbered list
n = length(c);
menu = cell(n,1);
for i=1:n
    menu{i} = sprintf('%d) %s\\n',i,c{i});
end

% prompt for user selection
while ~exist('opt','var')
    clc
    r = input(strcat(menu{:}));
    switch r
        case num2cell(1:n)
            opt = c{r};
    end
end 

