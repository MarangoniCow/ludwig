%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ======================== CLASS: DATAMETHODS =============================
%
% Class to encapsulate methods on LudwigData
%
% MEMBER VARIABLES
%   velocityPlaneCartesian      - Velocity data in array with size (n_x, n_y, 2)
%                                   where (x, y, 1) returns ux and (x, y, 2) returns uy.
%   velocityPlanePolar          - Velocity data in array with size (n_x, n_y, 2)
%                                   where (x, y, 1/2) returns ur/ut.


classdef VelocityData < LudwigData
    properties
        velocityPlaneCartesian       {mustBeNumeric}     % Cartesian velocity plane of form (x, y, t_step)
        velocityPlanePolar           {mustBeNumeric}     % Polar velocity plane of the form (x, y, t_step)
        x0
        y0
        R
        Th
    end

    methods
        function extractPlane(this, t_idx, z_idx)
            % extractPlane(this, t_idx, z_idx)
            %
            % Extracts a plane from the cartesian velocity data at a given
            % height and point in time of the simulation.
            % 
            % INPUTS
            %   this    - VelocityData object
            %   t_idx   - Point of time of interest
            %   z_idx   - Plane height of interest
            % OUTPUTS
            %   Writes output to this.velocityPlaneCartesian

            % Check system dimensions are defined before proceeding
            checkSysDim(this);

            % Check for velocity data extraction
            try
                this.checkVelocityData;
            catch
                this.extractVelocity;
            end

            this.velocityPlaneCartesian = zeros(this.systemSize(1), this.systemSize(2), 2);

            this.velocityPlaneCartesian(:, :, 1) = this.velocityData{t_idx}(:, :, z_idx, 1);
            this.velocityPlaneCartesian(:, :, 2) = this.velocityData{t_idx}(:, :, z_idx, 2);
            
        end

        function convertPolar(this, x0, y0)
            % converPolar(this, x0, y0)
            %
            % Converts this.velocityPlaneCartesian to a polar velocity
            % description centered around x0, y0. The velocity cartesian
            % plane must be extracted first before running convertPolar.
            %
            % INPUTS
            %   x0      - x-coordinate for new origin
            %   y0      - y-coordinate for new origin
            % OUTPUTS
            %   Writes to this.velocityPlanePolar

            % Set default x0/y0
            if nargin < 2
                x0 = 0;
                y0 = 0;
            end
            
            this.x0 = x0;
            this.y0 = y0;

            % Check for plane existence
            try
                this.checkForCartesianPlane;
            catch
                error('Plane must be extracted first');
            end

            [row, col, ~] = size(this.velocityPlaneCartesian);
            this.velocityPlanePolar = zeros(row, col, 2);


            for x = 1:row
                for y = 1:col

                    % Define coordinate transformation
                    xd = x - x0;
                    yd = y - y0;
                    

                    % Fetch local fluid velocity
                    ux = this.velocityPlaneCartesian(x, y, 1);
                    uy = this.velocityPlaneCartesian(x, y, 2);

                    % Fetch centre of source
                    r  = sqrt(xd^2 + yd^2);
                    theta = atan(yd./xd);

                    % Update r and theta velocities
                    ur = (xd*ux + yd*uy)/r;
                    ut = (xd*uy - yd*ux)/r;

                    % Update velocity plane at that point
                    this.velocityPlanePolar(x, y, 1) = ur;
                    this.velocityPlanePolar(x, y, 2) = ut;

                end
            end


        end

        function checkForCartesianPlane(this)
            % checkForCartesianPlane(this)
            %
            % Checks for the existence of velocityPlaneCartesian
            if isempty(this.velocityPlaneCartesian)
                error('Cartesaian velocity plane not extracted');
            end
        end

        function checkForPolarPlane(this)
            % checkForPolarPlane(this)
            %
            % Checks for the existence of velocityPlanePolar
            if isempty(this.velocityPlanePolar)
                error('Polar velocity plane not extracted');
            end
        end


        function estimatePolarSwimmerStreamFunction(this, a)
            % estimatePolarStreamFunction(this)
            %
            % Converts velocityPlanePolar into a polar stream function
            % Assumes stream function is zero on a swimmer based at x0,y0 
            % with radius a.
            
            checkForPolarPlane(this)

            % Define a meshgrid based on system dimensions
            dim = this.systemSize;
            L = dim(1); W = dim(2);
            B = floor(min(L - this.x0, W - this.y0));

            % Define a polar meshgrid:
            r = ceil(a):0.5:B;
            % dTheta is defined as the angle difference between the two
            % furthest points in the square
            dTheta = 0.1;
            dr = r(2) - r(1);
            theta = 0:dTheta:2*pi;

            [R_pol, Th_pol] = meshgrid(r, theta);
            [X_pol, Y_pol] = pol2cart(Th_pol.', R_pol.');

            x = 1:L;
            y = 1:W;
            xd = x - this.x0;
            yd = y - this.y0;
            [X, Y] = meshgrid(xd, yd);


            % Linearly interpolate polar velocity values at R and Th
            vr_pol = interp2(X, Y, this.velocityPlanePolar(:, :, 1)', X_pol, Y_pol);
            vt_pol = interp2(X, Y, this.velocityPlanePolar(:, :, 2)', X_pol, Y_pol);

            % scatter3(X_pol(:), Y_pol(:), vrInterp(:))
            % scatter3(X_pol(:), Y_pol(:), vrInterp(:))

            n_r = length(r);
            n_t = length(theta);


            psi = zeros(n_r, n_t);
            psi(1, 1) = 0;

            R_pol = R_pol';
            Th_pol = Th_pol';
            

            for ir = 1:n_r
                for it = 1:n_t
                    
                    if(ir == 1 && it == 1)
                        psi(ir, it) = 0;
                        continue;
                    elseif(it == 1)
                        % psi(ir, it) = psi(ir, it) - dr*(vt_pol(ir, it) + vt_pol(ir - 1, it))/2;
                        psi(ir, it) = psi(ir, it) - dr*vt_pol(ir, it);
                        continue;
                    end

                    % psi(ir, it) = psi(ir, it - 1) + dTheta*(R_pol(ir, it) + R_pol(ir, it - 1))/2*(vr_pol(ir, it) + vr_pol(ir, it -1))/2;
                    psi(ir, it) = psi(ir, it - 1) + dTheta*R_pol(ir, it)*vr_pol(ir, it);
                end
            end


            scatter3(X_pol(:)', Y_pol(:)', psi(:)');
            

            xlabel('$y$', 'interpreter', 'latex');
            ylabel('$x$', 'interpreter', 'latex');







        end

    end
end


