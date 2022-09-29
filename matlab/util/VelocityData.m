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

        function convertPolar(this)

            % Check for plane existence
            try
                this.checkVelocityData;
            catch
                error('Plane must be extracted first');
            end

            [r, c, ~] = size(this.velocityPlaneCartesian);
            this.velocityPlanePolar = zeros(r, c, 2);


            for x = 1:r
                for y = 1:c
                    ux = this.velocityPlaneCartesian(x, y, 1);
                    uy = this.velocityPlaneCartesian(x, y, 1);
                    r  = sqrt(x^2 + y^2);
                    ur = (x*ux + y*uy)/r;
                    ut = (x*uy - y*ux)/r;
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


