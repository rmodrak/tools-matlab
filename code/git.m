function git(varargin)
%GIT  A thin MATLAB wrapper for Git.
%   Use this exactly as you would use the OS command-line verison of Git.
% 
% Contributors: (MR) Manu Raghavan
%               (TH) Timothy Hansell


    % check if git is installed
    status,~] = system('git --version');

    if (status==1)
        % If GIT Is NOT installed, then this should end the function.
        fprintf('git is not installed\n%s\n',...
               'Download it at http://git-scm.com/download');
    else
        % Otherwise we can call the real git with the arguments
        arguments = parse(varargin{:});  
        if ispc
          cmd = sprintf('git %s',arguments);
        else
          cmd = sprintf('git %s | cat',arguments);
        end
        [~,result] = system(cmd);

        % save current status of pagination, then turn it on
        morestatus=get(0,'More');
        more('on')
        % show result
        disp(result)
        % revert pagination to previous status
        more(morestatus)
    end


function list = parse(varargin)

    list = cell2mat(cellfun(@(s)([s,' ']),...
                    varargin,'UniformOutput',false));

