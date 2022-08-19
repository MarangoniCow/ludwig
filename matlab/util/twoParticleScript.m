folderStr = '/home/matthew/Development/repos/ludwig/examples/3DC_S2/data';

filePattern = fullfile(folderStr, '*.csv');
S = dir(filePattern);
n = length(S);

colloid1_displacement = zeros(3, n);
colloid2_displacement = zeros(3, n);

colloid1_velocity = zeros(3, n);
colloid2_velocity = zeros(3, n);


for i = 1:n
    fileName = [folderStr, '/', S(i).name];
    C = extractColloidCSVData(fileName);
    
    colloid1_displacement(:, i) = C{1};
    colloid2_displacement(:, i) = C{4};

    colloid1_velocity(:, i) = C{2};
    colloid2_velocity(:, i) = C{5};
end

relVel = colloid1_velocity - colloid2_velocity;


