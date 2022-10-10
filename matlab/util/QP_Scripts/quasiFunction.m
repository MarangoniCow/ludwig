function ur = quasiFunction(b1, b2, c1, c2, x0, y0, lambda, x, y)


xd = x - x0;
yd = y - y0;

r = sqrt(xd.^2 + yd.^2);
theta = atan(yd./xd);


ur = b1*r.^-2.*cos(theta) + 2*b2*r.^-3.*cos(2*theta) + ... 
        c1./r.*besselk(1, r./lambda).*cos(theta) + 2.*c2./r.*besselk(2, r./lambda).*cos(2*theta);


       


end