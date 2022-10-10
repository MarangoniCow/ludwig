%%%%% INITIALISE QUASI-PARAMETER FITTING VARIABLES %%%%%

% Initialise ChannelData
VelData_QP = VelocityData('~/Documents/ludwig_viking_data/3DC_Pu_QP_01/data/', '3DC_Pu_QP_01');
setSysDim(VelData_QP, 128, 72, 36);
VelData_QP.colloid_a = 7.25;

% Choose a time step: Picked a time where the collid is close to the middle
% of the plane
t = 11;

% Extract the colloid displacement
VelData_QP.extractColloid;

% Set x0,y0,z0 based on the colloid position at t
x0 = VelData_QP.colloidDisp(1, t);
y0 = VelData_QP.colloidDisp(2, t);
z0  = VelData_QP.colloidDisp(3, t);

% z_idx
zidx = closestelement(1:VelData_QP.systemSize(3), z0);

% Extract velocity plane
extractPlane(VelData_QP, t, zidx);

% Convert to polar
convertPolar(VelData_QP, x0, y0);