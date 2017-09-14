function crash()
%CRASH Suggests various ways to crash MATLAB.

N = input('Choose sufficiently large N: ');
for i = 1:N
    a = {rand() a};
end
for i = 1:N
    a = a{2};
end
