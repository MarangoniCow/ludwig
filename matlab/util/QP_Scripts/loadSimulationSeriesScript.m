

RootFolder = '~/Documents/ludwig_viking_data/';
Data = '/data';
Series =        [
                '3DP_Pl_Q2D_01';
                '3DP_Pl_Q2D_02';
                '3DP_Pl_Q2D_03';
                '3DP_Pl_Q2D_04';
                '3DP_Pl_Q2D_05';
                '3DP_Pu_Q2D_01';
                '3DP_Pu_Q2D_02';
                '3DP_Pu_Q2D_03';
                '3DP_Pu_Q2D_04';
                '3DP_Pu_Q2D_05'
                ];

[row, ~] = size(Series);
SystemSize = [192, 108, 52];
colloidRadius = 11.33;


for i = 1:row

    folderStr = [RootFolder, Series(i, :), Data];

    [QuasiObj, VelObj] = QP_initialise(folderStr, SystemSize,  'SimulationName', Series(i, :), 'ColloidRadius', 11.33);
    save(['../Data/', VelObj.seriesID], 'QuasiObj', 'VelObj', '-v7.3')
end