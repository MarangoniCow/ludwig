%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ========================== CLASS: Q2DDATA ===============================
%
% Class to encapsulate methods for Quasi-2D parameter estimations
%
% MEMBER VARIABLES
%   - VelData               VelocityData object
%   - B_near                Near-field coefficients
%   - B_far                 Far-field coefficients
%   - psi_near              Fitted near-field streamfunction
%   - psi_far               Fitted far-field streamfunction
%   - lambda                `Screening' parameter
%   - colloidRadius         Colloid radius, used in fitting
%   - colloidVelocity       Colloid velocity, used in fitting
%
% MEMBER FUNCTIONS
%   - esimateStreamFunction(this)   Estimate the near & farfield streamfunction
%   - nearStreamFunction            Return the analytically-determined
%                                   near-streamfunction
%   - farStreamFunction             Return the analytically-determined
%                                   far-streamfunction
%   - checkForVelData               Throws error if VelData not set

classdef QuasiData < matlab.mixin.SetGet

    properties
        VelData             % VelocityData object
        B_far               % Far-field coefficients
        B_near              % Near-field coefficients
        psi_near
        psi_far
        lambda
        colloidRadius
        colloidVelocity
    end

    methods

        function this = QuasiData(VelData)
            % Set velocity data
            this.VelData = VelData;
        end

        function checkForVelData(this)
            if isempty(this.VelData)
                error('VelocityData object uninitiated');
            end
        end
        
        function psi = nearStreamfunction(this, R, Th)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % nearStreamFunction(R, Th)
            %
            % Returns the analytically defined stream function at R and Th
            %
            % INPUTS:
            %   - R                 Polar-coordinate for radius
            %   - Th                Polar-coordinate for theta
            %
            % OUTPUTS:
            %   - psi               Analytically-defined stream function

            b1 = this.B_near(1);
            b2 = this.B_near(2);
            a = this.colloidRadius;
            U = this.colloidVelocity;
            [rows, cols] = size(R);
            psi = zeros(size(R));

            kappa1 = besselk(1, a./this.lambda);
            kappa2 = besselk(2, a./this.lambda);
                    
            for i = 1:rows
                for j = 1:cols
            
                    r = R(i, j);
                    theta = Th(i, j);
    
                    Kt1 = besselk(1, r./this.lambda)./kappa1;
                    Kt2 = besselk(2, r./this.lambda)./kappa2;
                    
                    if(r < a)
                        psi(i, j) = 0;
                    else
                        psi(i, j) = r.^-1.*b1.*cos(theta).*(r^-1 - a.^-1.*Kt1) + U.*a.*sin(theta).*Kt1 + ...
                            b2.*sin(2.*theta).*(r^-2 - a.^-2.*Kt2);
                    end
                end
            end

        end
        function psi = farStreamfunction(this, R, Th)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555
            % farStreamFunction(R, Th)
            %
            % Returns the analytically defined stream function at R and Th
            %
            % INPUTS:
            %   - R                 Polar-coordinate for radius
            %   - Th                Polar-coordinate for theta
            %
            % OUTPUTS:
            %   - psi               Analytically-defined stream function

            b1 = this.B_far(1);
            b2 = this.B_far(2);
            c1 = this.B_far(3);
            c2 = this.B_far(4);
            a = this.colloidRadius;
            
            [rows, cols] = size(R);
            psi = zeros(size(R));
    
            for i = 1:rows
                for j = 1:cols
            
                    r = R(i, j);
                    theta = Th(i, j);
                    
                    if(r < a)
                        psi(i, j) = 0;
                    else
                        psi(i, j) = b1.*r.^-1.*sin(theta) + b2.*r.^-2.*sin(2.*theta) + ...
                            c1.*besselk(1, r./this.lambda).*sin(theta) + c2.*besselk(2, r./this.lambda).*sin(2*theta);
                    end
                end
            end
        end
    end
end
