function HistogramOfGradients()
    imagen = imread('image4.jpg');
    imagen = rgb2gray(imagen);
    imagen = double(imagen);
    alpha = 6;
    dmasky = fspecial('sobel')*(1/alpha);
    dmaskx = dmasky';
    gradienteX = conv2(imagen, dmaskx,'same');
    gradienteY = conv2(imagen, dmasky, 'same');
    vectorAngles = atan2(gradienteY,gradienteX);
    magnitudGradientes = sqrt(gradienteX.^2+gradienteY.^2);
    gradVectorAngles = (vectorAngles.*180)./pi;
    bins = 9;
    window = 8;
    [vcells, hcells, listHist] = histograms(gradVectorAngles, bins, window);
end

function [vcells,hcells,matrixHist] = histograms(gradients, bins, winSize)
    listHist = [];
    matrixHist = [];
    [maxi, maxj] = size(gradients);
    vcells =  maxj/winSize;
    vcells = round(vcells);
    hcells =  maxi/winSize;
    hcells = round(hcells);
    i = 1;
    j = 1;
    cells = 1;
    while i+(winSize-1) < maxi
        while j+(winSize-1)< maxj
            window = gradients(i:i+(winSize-1), j:j+(winSize-1));
            windowHist = histogram(window, winSize, bins);
            listHist = [listHist; windowHist];
            j=j+winSize;
        end
        matrixHist(cells,:,:) = listHist;
        listHist = [];
        j = 1;
        i=i+winSize;
        cells = cells + 1;
    end
end

function result = histogram(window, windowSize, bins)
    hist = zeros(1,bins);
    for i = 1:windowSize
        for j = 1:windowSize
            binsSelected = binSelection(window(i,j), bins);
            hist(binsSelected) = hist(binsSelected)+1;
        end
    end
    result = hist;
end

function result = binSelection(vectorAngle, bins)
    angle = abs(vectorAngle);
    if(angle >= 180)
        angle = 179;
    end
    binSize = floor(180/bins);
    result = floor(angle/binSize)+1;
end