function v = catvec(varargin)
%CATVEC Concatenates two or more vectors.
%   CATVEC(vec1,vec2,...) concatenates vectors regardless of whether they 
%   are rows or columns.
%
%   see also: CAT, HORZCAT, VERTCAT

v = [];
for i=1:nargin
    
    vi = varargin{i};

    % check argument
    if ~isvector(vi) && ~isempty(vi)
            error('Argument %d must be a vector.',i);
    end

    % concatenate vector
    if isempty(v)
        v = vi;
        if iscolumn(v)
            if iscolumn(vi)
                v = vertcat(v,vi);
            else
                v = vertcat(v,vi.');
            end
        else
            if iscolumn(vi)
                v = horzcat(v,vi.');
            else
                v = horzcat(v,vi);
            end
        end
    end
    
end
