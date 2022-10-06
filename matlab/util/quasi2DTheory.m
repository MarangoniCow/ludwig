

% Define fit type
%   - x0, y0 are functions of the problem
%   - x, y is the matrix grid
ft = fittype('quasiFunction(b1, b2, c1, c2, x, x0, y0, lambda, y)', ...
    'independent', {'x', 'y'}, 'dependent', 'ur', 'problem',  {'x0', 'y0', 'lambda'});

extractPlane(ChannelData, 1, 16);
ChannelData.extractColloid;

% Fetch system dimensions
n_x = ChannelData.systemSize(1);
n_y = ChannelData.systemSize(2);

% Fetch system coordinates
t = 1;
x0 = ChannelData.colloidDisp(1, t);
y0 = ChannelData.colloidDisp(2, t);

convertPolar(ChannelData, x0, y0);

range = [1:12, 20:32];
% range = 1:32;
% Set workspace
x = range;
y = range;
[X, Y] = meshgrid(x, y);
X = X(:); Y = Y(:);


h = n_x;
lambda = sqrt(h^2/12);

Vr = ChannelData.velocityPlanePolar(range, range, 1);
vr = Vr(:);

sf = fit([X, Y], vr, ft, 'problem', {x0, y0, lambda}, 'start', [0.1, 0.1, 0.1, 0.1]);
plot(sf, [X, Y], vr);
zlim([-2e-4, 2e-4]);