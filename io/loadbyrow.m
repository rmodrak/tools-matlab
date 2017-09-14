function varargout = loadbyrow(file)
%LOADBYROW Loads text file row by row.

n = nargout;
array = load(file);

for i=1:n
   varargout{i}  = array(i,:);
end
