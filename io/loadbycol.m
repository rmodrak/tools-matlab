function varargout = loadbycol(file)
%LOADBYCOL Loads text file column by column.

n = nargout;
array = load(file);

for i=1:n
   varargout{i}  = array(:,i);
end
