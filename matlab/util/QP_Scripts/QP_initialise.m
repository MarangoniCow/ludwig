
function [QuasiObj, VelObj] = QP_initialise(FolderStr, SystemSize, varargin)
    % ------------------------------------------------------------- %
    % ------------------------------------------------------------- %
    %       INITIALISE QUASI-PARAMETER FITTING VARIABLES 
    %
    % Initialise a QuasiData object from a LudwigData object
    % 
    % ------------------------------------------------------------- %
    % ------------------------------------------------------------- %



    % Parse inputs
    p = inputParser;

    % Folder string
    addRequired(p, 'FolderStr');

    % System size
    addRequired(p, 'SystemSize', @(x) isnumeric(x) && length(x) == 3);

    % Colloid size
    addOptional(p, 'ColloidRadius', [], ...
                        @(x) isnumeric(x) && isscalar(x))

    % Time-step
    addOptional(p, 'TimeStep', 1, ...
                        @(x) isnumeric(x) && isscalar(x))

    % Simulation name
    addOptional(p, 'SimulationName', '', ...
                        @(x) isstring(x) || ischar(x));

    % Parse inputs
    parse(p, FolderStr, SystemSize, varargin{:});


    % ------------------------------------------------------------- %
    %   Methodology:
    %       1) Initialise a velocity data object from the folder
    %       2) Set as many dependents as possible
    % ------------------------------------------------------------- %
    

    % Initialise VelocityData
    VelObj = VelocityData(FolderStr, p.Results.SimulationName);
    
    
    % Set system size
    if(~isempty(p.Results.SystemSize))
        simSize = p.Results.SystemSize;
        setSysDim(VelObj, simSize(1), simSize(2), simSize(3));
    end

    % Extract colloid displacement
    VelObj.colloid_a = p.Results.ColloidRadius;
    VelObj.extractColloid;
    

    % z_idx
    
    cs = VelObj.colloidDisp(1, :);
    

    % If not specificed, calculate the best timestep
    if any(strcmp(p.UsingDefaults, 'TimeStep'))
        idxList = VelObj.findChannelRuns;

        for i = 1:length(idxList)
            runStart = idxList{i}(1);
            runEnd = idxList{i}(end);
            runPercent{i} = (cs(runEnd) - cs(runStart))/VelObj.systemSize(1);
        end

        if(runPercent{end} > 0.8)
            runIdx = length(idxList);
        else
            runIdx = length(idxList) - 1;
        end

        % Use the second to last channel run *** potential bug *** 
        channelRun = VelObj.colloidDisp(1, idxList{runIdx});
        midChannel = VelObj.systemSize(1)/2;
        t = closestelement(channelRun, midChannel) + idxList{runIdx - 1}(end);
    else
        t = p.Results.TimeStep;
    end
        

    x0 = VelObj.colloidDisp(1, t);
    y0 = VelObj.colloidDisp(2, t);
    z0 = VelObj.colloidDisp(3, t);
    zidx = closestelement(1:VelObj.systemSize(3), z0);

    VelObj.extractVelocity;
    
    % Extract velocity plane
    extractPlane(VelObj, t, zidx);
    
    % Convert to polar
    convertPolar(VelObj, x0, y0);

    QuasiObj = QuasiData(VelObj);
    QuasiObj.estimateStreamFunction;

end