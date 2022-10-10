%%%%% GRAPHVELOCITYPLANE %%%%%
%
% Acts on a VelocityPlane object to graph the velocity plane.


function graphVelocityPlane(VelocityDataObj, velComponentStr)

    % Check for plane existence
    VelocityDataObj.checkForPolarPlane;
    
    % Extract plane dimensions
    [nx, ny, ~] = size(VelocityDataObj.velocityPlaneCartesian);
    x = 1:nx; y = 1:ny;

    % Set surface mesh
    [X, Y] = meshgrid(x, y);

    % Determien component of interest
    switch velComponentStr
        case 'ux'
            Z = VelocityDataObj.velocityPlaneCartesian(:, :, 1);
        case 'uy'
            Z = VelocityDataObj.velocityPlaneCartesian(:, :, 2);
        case 'ur'
            Z = VelocityDataObj.velocityPlanePolar(:, :, 1);
        case 'ut'
            Z = VelocityDataObj.velocityPlanePolar(:, :, 2);
        otherwise
            error('Invalid velocity component, valid options: ux, uy, ur, ut')
    end

    surf(X', Y', Z);
    
    s = plotdefaults;
    xlabel('$x$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    ylabel('$y$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    zlabel(['$', velComponentStr, '$'], 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);

    ax = gca;
    D = ax.DataAspectRatio;
    ax.DataAspectRatio = [D(1), D(1), 1];
end