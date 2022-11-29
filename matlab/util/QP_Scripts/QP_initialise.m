%%%%% INITIALISE QUASI-PARAMETER FITTING VARIABLES %%%%%

% Initialise ChannelData
VelData = VelocityData('~/Documents/ludwig_viking_data/3DP_Q2D_01/data/', '3DC_Pu_QP_01');
setSysDim(VelData, 128, 72, 36);
VelData.colloid_a = 7.25;

% Choose a time step: Picked a time where the collid is close to the middle
% of the plane
t = 11;

% Extract the colloid displacement
VelData.extractColloid;

% Set x0,y0,z0 based on the colloid position at t
x0 = VelData.colloidDisp(1, t);
y0 = VelData.colloidDisp(2, t);
z0  = VelData.colloidDisp(3, t);

% z_idx
zidx = closestelement(1:VelData.systemSize(3), z0);

% Extract velocity plane
extractPlane(VelData, t, zidx);

% Convert to polar
convertPolar(VelData, x0, y0);