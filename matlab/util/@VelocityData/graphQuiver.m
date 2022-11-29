%%%%% plotPlaneVectorField %%%%%
%
% VelocityData method to plot the plane vectorfield plot.


function fig = graphQuiver(this)

    % Check for plane existence
    this.checkForPolarPlane;
    
    % Fetch coordinates
    X = this.X;
    Y = this.Y;
    U = this.velocityPlaneCartesian(:, :, 1);
    V = this.velocityPlaneCartesian(:, :, 2);
    
    s = plotdefaults;
    fig = figure;
    quiver(X, Y, U, V, 'color', s.col.blue(9, :), 'LineWidth', 0.75*s.std.LineWidth);

    xlabel('$x$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    ylabel('$y$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);

    ax = gca;
    D = ax.DataAspectRatio;
    ax.DataAspectRatio = [D(1), D(1), 1];
end