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
        velocityPlaneCartesian       {mustBeNumeric}     % Velocity plane of form (x, y, t_step)
        velocityPlanePolar           {mustBeNumeric}                                             
    end

    methods
        function extractPlane(this, t_idx, z_idx)

            % Check system dimensions are defined before proceeding
            checkSysDim(this);

            % Check for velocity data extraction
            try
                this.checkVelocityData;
            catch
                this.extractVelocity;
            end

            % Check velocity data is defined
            % Number of time steps
            n_t = length(t_idx);

            this.velocityPlaneCartesian = zeros(this.systemSize(1), this.systemSize(2), 2, n_t);

            for idx = 1:length(t_idx)
                this.velocityPlaneCartesian(:, :, 1, idx) = this.velocityData{idx}(:, :, z_idx, 1);
                this.velocityPlaneCartesian(:, :, 2, idx) = this.velocityData{idx}(:, :, z_idx, 2);
            end
        end

        function convertPolar(this, x0, y0)

            % Set default x0/y0
            if nargin < 2
                x0 = 0;
                y0 = 0;
            end

            % Check for plane existence
            try
                this.checkVelocityData;
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

        function checkVelocityPlane(this)
            if isempty(this.velocityPlaneCartesian)
                error('Velocity plane not extracted');
            end
        end
    end
end


