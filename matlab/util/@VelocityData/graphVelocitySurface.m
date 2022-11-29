%%%%% GRAPHVELOCITYPLANE %%%%%
%
% Acts on a VelocityPlane object to graph the velocity plane.


function fig = graphVelocitySurface(this, velComponentStr)

    % Check for plane existence
    this.checkForPolarPlane;
    
    % Extract plane dimensions
    [nx, ny, ~] = size(this.velocityPlaneCartesian);
    x = 1:nx; y = 1:ny;

    % Set surface mesh
    [X, Y] = meshgrid(x, y);

    % Determien component of interest
    switch velComponentStr
        case 'ux'
            Z = this.velocityPlaneCartesian(:, :, 1);
        case 'uy'
            Z = this.velocityPlaneCartesian(:, :, 2);
        case 'ur'
            Z = this.velocityPlanePolar(:, :, 1);
        case 'ut'
            Z = this.velocityPlanePolar(:, :, 2);
        case 'uz'
            Z = this.velocityData{this.timeStep}(:, :, this.extractHeight, 3);
        otherwise
            error('Invalid velocity component, valid options: ux, uy, ur, ut or uz')
    end
    
    fig = figure;
    surf(X', Y', Z);
    
    s = plotdefaults;
    xlabel('$x$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    ylabel('$y$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    zlabel(['$', velComponentStr, '$'], 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);

    ax = gca;
    D = ax.DataAspectRatio;
    ax.DataAspectRatio = [D(1), D(1), 1];
end