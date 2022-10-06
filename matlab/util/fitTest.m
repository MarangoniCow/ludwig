function z = fitTest(a, b, para, x, y)

r = sqrt(x.^2 + y.^2);
z = a*r.^2 + b*r;


end