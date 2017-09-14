function [status,result] = cygwin(varargin)
%CYGWIN Executes command and returns result.

[status,result] = dos(varargin{:});
