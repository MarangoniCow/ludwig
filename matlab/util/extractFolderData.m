%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   EXTRACTFOLDERDATA(FOLDERSTR) 
%
% extractFolderData will convert all the data from a simulation
% found in folderStr to a local Matalb matrix.
%
% INPUTS
%   - folderStr             Path to folder of interest
%
% OUTPUTS
%   - coll_displacement     Matlab 3-by-n matrix containing colloid
%                           displacement over n sample queries
%   - coll_velocity         Matlab 3-by-n matrix containing colloid
%                           velocity over n sample queries


function [coll_displacement, coll_velocity] = extractFolderData(folderStr)
    % Define file patern as .csv files 
    filePattern = fullfile(folderStr, '*.csv');
    S = dir(filePattern);
    n = length(S);
    
    % Initialise variables 
    coll_displacement = zeros(3, n);
    coll_velocity = zeros(3, n);
    
    % Loop over all files...    
    for i = 1:n
        fileName = [folderStr, '/', S(i).name];
        % ...extract CSV data
        C = extractColloidCSVData(fileName);
        % parse to local variables for output
        coll_displacement(:, i) = C{1};
        coll_velocity(:, i) = C{2};
    end
end