function ut = quasiFunction2(B1, B2, a, Us, x0, y0, lambda, x, y)


xd = x - x0;
yd = y - y0;

r = sqrt(xd.^2 + yd.^2);
theta = atan(yd./xd);


B1_besselTerms = (besselk(0, r./lambda) + lambda./r.*besselk(1, r./lambda))./besselk(1, a./lambda);
B2_besselTerms = (besselk(1, r./lambda) + 2*lambda./r.*besselk(2, r./lambda))./besselk(1, a./lambda);

dpsidr = B1.*sin(theta).*(-r.^-2 + 1./lambda.*(a.^-1 - Us.*a).*B1_besselTerms) + ...
            B2.*sin(2.*theta).*(-2.*r.^-3 + a.^-2./lambda.*B2_besselTerms);

ut = -dpsidr;      


end