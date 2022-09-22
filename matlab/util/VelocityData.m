%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ======================== CLASS: DATAMETHODS =============================
%
% Class to encapsulate methods on LudwigData
%
% MEMBER VARIABLES


classdef VelocityData < LudwigData
    properties
        velocityPlaneCartesian       {mustBeNumeric}     % Velocity plane of form (x, y, t_step)
        velocityPlanePolar           {mustBeNumeric}                                             
    end

    methods
        function extractPlane(this, t_idx, z_idx)

            % Check system dimensions before proceeding
            checkSysDim(this);

            % Check for velocity data extraction
            try
                checkVelocityData(this.velocityData);
            catch
                extractVelocity(this);
            end

            % Check velocity data is defined
            % Number of planes desired
            n = length(t_idx);

            this.velocityPlaneCartesian = zeros(this.n_x, this.n_y, 2, n);

            for idx = 1:length(t_idx)
                this.velocityPlaneCartesian(:, :, 1, idx) = this.velocityData{idx}(:, :, z_idx, 1);
                this.velocityPlaneCartesian(:, :, 2, idx) = this.velocityData{idx}(:, :, z_idx, 2);
            end
        end

        function convertPolar(this, x0, y0)

            % Check for plane existence
            try
                checkVelocityPlane(this);
            catch
                error('Plane must be extracted first');
            end
            
            [~, ~, ~, n] = size(this.velocityPlaneCartesian);
            this.velocityPlanePolar = zeros(this.n_x, this.n_y, 2, n);

            for idx = 1:n
                x = this.velocityPlaneCartesian(:, :, 1, idx);
                y = this.velocityPlaneCartesian(:, :, 2, idx);
                
                ###########
                % can't make a distance from a velocity you twit!
                r = sqrt((x0 - x).^2 + (y0 - y).^2);
                theta = atan((y0 - y)./(x0 - x));

                this.velocityPlanePolar(:, :, 1, idx) = r;
                this.velocityPlanePolar(:, :, 2, idx) = theta;
                
            end
        end

        function checkVelocityPlane(this)
            if isempty(this.velocityPlaneCartesian)
                error('Velocity plane not extracted');
            end
        end
    end
end


