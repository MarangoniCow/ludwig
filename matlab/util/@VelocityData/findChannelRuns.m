
function idxList = findChannelRuns(this)

    % ------------------------------------------------------------ %
    % ------------------------------------------------------------ %
    %   findChannelRuns(this)
    %
    %       Find the indicies for each run of a colloid from x = 1 to x = end.
    %       Assume that we have periodic boundary conditions and we're
    %       only interested in runs in the x-direction.
    %
    % ------------------------------------------------------------ %
    % ------------------------------------------------------------ %
    
    
    % Fetch the colloid displacements
    x = this.colloidDisp(1, :);
    boundaryCrossPoints = find(~(diff(x)> 0));
    startOfRun = 1;

    if isempty(boundaryCrossPoints)
        idxList = 1:length(x);
        return;
    end
    
    
    for i = 1:length(boundaryCrossPoints)
        idxList{i} = startOfRun:boundaryCrossPoints(i);
        startOfRun = boundaryCrossPoints(i) + 1;
    end
    idxList{i + 1} = startOfRun:length(x);

end