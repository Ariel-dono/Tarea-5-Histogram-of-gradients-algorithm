function drawDescriptors(image, descriptor, numVCells, numHCells, cellSize, numBins)
  imshow(image)
  hold on
  M = size(image,1);
  N = size(image,2);

  for k = 1:8:M
      x = [1 N];
      y = [k k];
      plot(x,y,'Color','w','LineStyle','-');
  end

  for k = 1:8:N
      x = [k k];
      y = [1 M];
      plot(x,y,'Color','w','LineStyle','-');
  end
  hold on
  for row = 1:numVCells        
    for col = 1:numHCells
      blockHists = descriptor(row,col,:);
      binCount=1;
      x = 1+cellSize*col-cellSize/2;
      y = 1+cellSize*row-cellSize/2;
      while (binCount<=numBins)
          currentAngle = binCount*pi/numBins;
          currentMagnitude = blockHists(binCount);
          x1=x-(currentMagnitude*cellSize/2);
          x2=x+(currentMagnitude*cellSize/2);
          mx=[ ...
           cos(currentAngle) sin(currentAngle)
           -sin(currentAngle) cos(currentAngle)
          ];
          x1_y1=mx*[[x1,x2]-x;[y,y]-y];
          xr=x1_y1(1,:)+x;
          yr=x1_y1(2,:)+y;
          binCount=binCount+1; 
          line(xr,yr,'Color','r','LineWidth',2);     
        end
        hold on
    end
   end 
endfunction