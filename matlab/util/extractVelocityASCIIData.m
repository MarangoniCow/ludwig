%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------- EXTRACTVELOCITYASCIIDATA ----------
% 
% extractVelocityASCIIData extracts the data from a ludwig-generated ASCII
% file containing the velocity values at a given time step. 
%
% INPUTS:
% filename      - string, assumed to be of the format 'filename.csv'
%
% OUTPUTS:
% matrixOut     - an 4D-matrix with dimensions (sys_x, sys_y, sys_z, 3)
%                   corresponding to the system velocity at x, y, z. 


function matrixOut = extractVelocityASCIIData(filename, sys_x, sys_y, sys_z)
    
    matrixOut = zeros(sys_x, sys_y, sys_z, 3); 
    tabularData = importdata(filename);

    for n = 1:length(tabularData)
        
        i = tabularData(n, 1);
        j = tabularData(n, 2);
        k = tabularData(n, 3);

        matrixOut(i, j, k, :) = tabularData(n, 4:6);

    end
end