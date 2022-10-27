

% Define fit type
%   - x0, y0 are functions of the problem
%   - x, y is the matrix grid
ft = fittype('Q2D_farfieldFcn(b1, b2, c1, c2, x0, y0, lambda, x, y)', ...
    'independent', {'x', 'y'}, 'dependent', 'ur', 'problem',  {'x0', 'y0', 'lambda'});




% Fetch parameter data
dim = VelData_QP.systemSize;

% Fetch height and define lambda
l = dim(1);
w = dim(2);
h = dim(3);
% lambda = sqrt(h.^2/12);

midpoint = floor(l/2);

x = midpoint - w/2:midpoint + w/2;
y = 1:w;
[X, Y] = meshgrid(x, y);
X = X'; Y = Y';
X = X(:); Y = Y(:);

% Fetch data
vr = VelData_QP.velocityPlanePolar(x, y, 1);
vt = VelData_QP.velocityPlanePolar(x, y, 2);

vr = vr(:);
vt = vt(:);

% Generate list of points to exclude
a = VelData_QP.colloid_a;
[Xc, Yc] = generateRadialXYPoints(x0, y0, a + 3);

% Generate idx list of points
idxList = [];
for i = 1:length(Xc)
    for j = 1:length(X)

        if(Xc(i) == X(j) && Yc(i) == Y(j))
            idxList = [idxList, j];
            break;
        end
    end
end

% Delete relevant points
X(idxList) = [];
Y(idxList) = [];
vr(idxList) = [];
vt(idxList) = [];





sf = fit([X, Y], vr, ft, 'problem', {x0, y0, lambda}, 'start', [0.1, 0.1, 0.1, 0.1]);
plot(sf, [X, Y], vr)
% scatter3(X, Y, vr);
ax = gca;


zlim([-3e-2, 3e-2]);
ax.DataAspectRatio = [ax.DataAspectRatio(1), ax.DataAspectRatio(2), 1];

    s = plotdefaults;
    xlabel('$x$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    ylabel('$y$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);