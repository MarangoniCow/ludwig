function [X, Y] = generateRadialXYPoints(x0, y0, r)


    xd = floor(x0 - 1 - r):ceil(x0 + 1 + r);
    yd = floor(y0 - 1 - r):ceil(y0 + 1 + r);

    [X, Y] = meshgrid(xd, yd);
    X = X(:); Y = Y(:);
    
    idxList = [];
    
    for i = 1:length(X)
        R = sqrt((X(i) - x0)^2 + (Y(i) - y0)^2);

        if(ceil(R) > ceil(r) + 1)
            idxList = [idxList, i];
        end
    end

    X(idxList) = [];
    Y(idxList) = [];
end