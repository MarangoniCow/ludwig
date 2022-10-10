%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ======================== CLASS: DATAMETHODS =============================
%
% Class to encapsulate methods on LudwigData
%
% MEMBER VARIABLES
%   velocityPlaneCartesian      - Velocity data in array with size (n_x, n_y, 2)
%                                   where (x, y, 1) returns ux and (x, y, 2) returns uy.


classdef VelocityData < LudwigData
    properties
        velocityPlaneCartesian       {mustBeNumeric}     % Cartesian velocity plane of form (x, y, t_step)
        velocityPlanePolar           {mustBeNumeric}     % Polar velocity plane of the form (x, y, t_step)
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

                    % Update r and theta velocities
                    ur = (xd*ux + yd*uy)/r;
                    ut = (xd*uy - yd*ux)/r;

                    % Update velocity plane at that point
                    this.velocityPlanePolar(x, y, :) = [ur; ut];
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
                error('Polar velocity plane not extract');
            end
        end
    end
end


