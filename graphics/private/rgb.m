function c = rgb
%RGB Red-gray-blue colormap

c0 = [103    0       31;
    178     24      43;
    214     96      77;
    244     165     130;
    253     219     199;
    247     247     247;
    209     229     240;
    146     197     222;
    67      147     195;
    33      102     172;
    5       48      97];

n = 3;
r = 2;
c = zeros(r*length(c0),n);
for i=1:n
    c(:,i) = interp(c0(:,i),r);
end
c = flipud(c(1:21,:)/255);
