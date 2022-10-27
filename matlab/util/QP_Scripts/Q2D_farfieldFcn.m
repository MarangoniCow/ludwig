function ur = Q2D_farfieldFcn(b1, b2, c1, c2, x0, y0, lambda, x, y)
%%%%%%%%%%%%%% Q2D_farfieldFcn(b1, b2, c1, c2, x0, y0, lambda, x, y) %%%%%%%%%%%%%%
% 
% Quasi-2D far-field approximation for a squirmer field in confinement.
%
% INPUT PARAMETERS
%   b1, b2, c1, c2          - Unknown constants to be solved for
%   x0, y0                  - Swimmer/colloid center
%   lambda                  - 'Screening length' parameter, should be set
%                               to sqrt(h^2/2)
%   x, y                    - Cartesian coordinates to be solved at

% Introduce polar coordinates
xd = x - x0;
yd = y - y0;

r = sqrt(xd.^2 + yd.^2);
theta = atan(yd./xd);

% Define radial component
ur = b1*r.^-2.*cos(theta) + 2*b2*r.^-3.*cos(2*theta) + ... 
        c1./r.*besselk(1, r./lambda).*cos(theta) + 2.*c2./r.*besselk(2, r./lambda).*cos(2*theta);

% Define angular component
% ur = b1*r.^-2.*sin(theta) + b2*r.^-3.*sin(2*theta) + ... 
%         c1./r.*(besselk(0, r./lambda) + r./lambda.*besselk(1, r./lambda)).*sin(theta) + ...
%         c2./r.*(besselk(1, r./lambda) + 2*r./lambda.*besselk(2, r./lambda)).*sin(2*theta);
% 


       


end