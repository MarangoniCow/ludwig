%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------- EXTRACTCOLLOIDCSVDATA ----------
% 
% extractColloidCSVData extracts the data from a ludwig-generated CSV file
% containing the displacement and velocity profiles of n colloids.
%
% INPUTS:
% filename      - string, assumed to be of the format 'filename.csv'
%
% OUTPUTS:
% cellOut       - cell, whose jth, (j + 1)th, (j + 2)th elements are the
%                   displacement, velocity and normal vectors of the jth
%                   colloid.


function cellOut = extractColloidCSVData(filename)

    % Read the CSV file
    M = readmatrix(filename);
    [row, ~] = size(M);

    % Loop over all colloids 
    for i = 1:row
        j = 3*(i - 1) + 1;
        % Assign to dataOut
        cellOut{j} = M(i, 2:4);
        cellOut{j + 1} = M(i, 5:7);
        cellOut{j + 2} = M(i, 8);
    end
end