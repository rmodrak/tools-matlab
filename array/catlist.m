function c = catlist(varargin)
%CATLIST Concatenates comma-separated list.
%   MATLAB operations on a cell array or structure array sometimes return
%   comma-separated lists. CATLIST takes the output from such an operation
%   operation and packages it more compactly in the form a single cell
%   array.

c = cat(2,varargin{:});
