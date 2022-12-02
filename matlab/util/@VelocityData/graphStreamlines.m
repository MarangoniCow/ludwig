%%%%% GRAPHVELOCITYPLANE %%%%%
%
% Acts on a VelocityPlane object to graph the velocity plane.


function fig = graphStreamlines(this)

    % 

    % Generate a new figure
    fig = figure;

    

    % Check for plane existence
    this.checkForPolarPlane;
    
    % Fetch coordinates
    X = this.X;
    Y = this.Y;
    U = this.velocityPlaneCartesian(:, :, 1);
    V = this.velocityPlaneCartesian(:, :, 2);

    s = plotdefaults;
    
    % Colourmap plot: absolute value of velocity.
    
    hold on
    Uabs = abs(U) + abs(V);
    pcolor(X, Y, Uabs);
    colormap parula
    shading interp

    hf = streamslice(X', Y', U', V');

    % Change streamline colours
    
    for i = 1:length(hf)
        hf(i).Color = s.col.blue(1, :);
        hf(i).LineWidth = 1.3;
    end


    hold off
    
    % Labels
    xlabel('$x$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);
    ylabel('$y$', 'interpreter', 'latex', 'FontSize', s.std.FontSizeLab);

    ax = gca;
    D = ax.DataAspectRatio;
    ax.DataAspectRatio = [D(1), D(1), 1];


end