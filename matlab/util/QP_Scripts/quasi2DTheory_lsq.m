

% Fetch parameter data
dim = VelData_QP.systemSize;

% Fetch height and define lambda
l = dim(1);
w = dim(2);
h = dim(3);
lambda = sqrt(h.^2/12);

% Take the midpoint of x
midpoint = floor(l/2);

% Address this later
x = midpoint - w/2 + 1:midpoint + w/2;
y = 1:w;
[Xm, Ym] = meshgrid(x, y);



% Fetch data
vr = VelData_QP.velocityPlanePolar(x, y, 1);

% vt = VelData_QP.velocityPlanePolar(x, y, 2);

% Linearise
vr = vr(:)';
vt = vt(:);

% Generate list of points to exclude
a = VelData_QP.colloid_a;
[Xc, Yc] = generateRadialXYPoints(x0, y0, a + 3);
% 
% % Generate idx list of points
idxList = [];
for i = 1:length(Xc)
    for j = 1:length(Xm)

        if(Xc(i) == Xm(j) && Yc(i) == Ym(j))
            idxList = [idxList, j];
            break;
        end
    end
end

% Delete relevant points
Xm(idxList) = [];
Ym(idxList) = [];
vr(idxList) = [];
vt(idxList) = [];


% Setting up solver
% Starting points
C0 = [0.1, 0.1, 0.1, 0.1];

input = [Xm];

fprintf('Input array size: (%d, %d)', size(input))
fprintf('\nInput array size: (%d, %d)', size(vr))
fprintf('\n')





output = lsqcurvefit(@(C, X)functionToFit(C, X, x0, y0, lambda), C0, input, vr);

function ur = functionToFit(C, X, x0, y0, lambda)
    b1 = C(1);
    b2 = C(2);
    c1 = C(3);
    c2 = C(4);
    
    % Introduce polar coordinates
    xd = X(1) - x0;
    yd = X(2) - y0;
    r = sqrt(xd.^2 + yd.^2);
    theta = atan(yd./xd);
           
    % Radial component
    ur = b1.*r.^-2.*cos(theta) + 2.*b2.*r.^-3.*cos(2.*theta) + ... 
            c1./r.*besselk(1, r./lambda).*cos(theta) + 2.*c2./r.*besselk(2, r./lambda).*cos(2*theta);
end

