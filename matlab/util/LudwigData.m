%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ======================== CLASS: LUDWIGDATA ==============================
%
% Class to encapsulate velocity and colloid data from a Ludwig simulation
% for processing and visualisation using native MATLAB tools.
%
% MEMBER VARIABLES
%   seriesID        -   string, shorthand ID identifying simulation series
%   folderStr       -   string, data location
%   n_x             -   int, system x dimension
%   n_y             -   int, system y dimension
%   n_z             -   int, system z dimension
%   velocityData    -   matrix of dimension (n_x, n_y, n_z, 3) containing
%                           fluid velocity values
%   colloidDisp     -   colloid displacement values
%   colloidVel      -   colloid velocity values
%
% MEMBER FUNCTIONS
%   LudwigData(folderStr, seriesID)
%                   - Assigns folder string and series ID
%   setSysDim(this, x, y, z)
%                   - Assigns n_x, n_y, n_z
%   extractColloid(this)
%                   - Extract colloidal displacement and velocity
%   extractVelocity(this)
%                   - Extract velocity field 


classdef LudwigData < matlab.mixin.SetGet
    properties
        seriesID        char        % Data information
        folderStr       char
        n_x             int16       % System sisze
        n_y             int16
        n_z             int16
        colloidDisp     {mustBeNumeric}
        colloidVel      {mustBeNumeric}
        velocityData    
    end
    methods
        % Constructor: Assigns folder string and series ID.
        function this = LudwigData(folderStr, seriesID)
            
            if nargin == 1
                this.folderStr = folderStr;
                this.seriesID = '#';
            else
                this.seriesID = seriesID;
                this.folderStr = folderStr;
            end
        end
        % Must be set to extract velocity field
        function setSysDim(this, x, y, z)

            this.n_x = x;
            this.n_y = y;
            this.n_z = z;

        end
        % Extract colloid position and velocity
        function extractColloid(this)

                       
            filePattern = fullfile(this.folderStr, '*.csv');
            S = dir(filePattern);
            n = length(S);
            
            col_disp_cell = zeros(3, n);
            col_vel_cell = zeros(3, n);
                        
            
            for i = 1:n
                fileName = [this.folderStr, '/', S(i).name];
                C = extractColloidCSVData(fileName);
                col_disp_cell(:, i) = C{1};
                col_vel_cell(:, i) = C{2};
            end

            this.colloidDisp = col_disp_cell;
            this.colloidVel = col_vel_cell;
        end
        % Extract velocity field
        function extractVelocity(this)
            
            % Check system dimensions before proceeding
            checkSysDim(this);
            
                
            filePattern = fullfile(this.folderStr, 'vel-*');
            
            % Fetch file names from folder
            S = dir(filePattern);
            % ASCII files have no extension, so we double check we don't
            % have any extensions and delete.
            hasDot = contains({S.name}, '.');
            S(hasDot) = [];
            % n = number of files left.
            n = length(S);
            C = cell(n, 1);
            
            for i = 1:n
                fileName = [this.folderStr, '/', S(i).name];
                C{i} = extractVelocityASCIIData(fileName, this.n_x, this.n_y, this.n_z);
            end
            
            % Update velocity field with cell. 
            this.velocityData = C; 
        end
        function checkSysDim(this)

            if isempty(this.n_x) || isempty(this.n_y) || isempty(this.n_z)
                error('System dimensions unknown: set using setSysDim');
            end
        end
        function checkVelocityData(this)

            if isempty(velocityData)
                error('Velocity data not extracted')
            end
        end


        
    end
end