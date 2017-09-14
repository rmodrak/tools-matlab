function tf = txtprompt(prompt)
%TXTPROMPT Prompts for yes or no.
%   TXTPROMPT(STRING) displays STRING and waits for keyboard input. Returns
%   true for 'y' or Y' and false for 'n' or 'N'.

if nargin < 1
    prompt = 'Accept?[yn]\n';
end

while ~exist('tf','var')
    clc
    c = input(prompt,'s');
    switch c;
        case {'n','N'};  tf = false;
        case {'y','Y'};  tf = true;
    end
end
