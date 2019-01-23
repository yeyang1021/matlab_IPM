
%% LoadInfo    [cameraInfo, ipmInfo]
[cameraInfo, ipmInfo] = GetInfo;
% GetInfo  the information IPM need
%% IPM 
outImage = zeros(ipmInfo.ipmHeight,ipmInfo.ipmWidth);

I = imread('IMG00996.jpg');
R = I(:,:,1);
[Rheight, Rwidth] =  size(R);
u = Rheight;
v = Rwidth;

vpp = GetVanishingPoint(cameraInfo);
vp.x = vpp(1);
vp.y = vpp(2);


uvLimitsp = [ vp.x,         ipmInfo.ipmRight, ipmInfo.ipmLeft,  vp.x;
              ipmInfo.ipmTop, ipmInfo.ipmTop, ipmInfo.ipmTop,   ipmInfo.ipmBottom];

xyLimits = TransformImage2Ground(uvLimitsp,cameraInfo);

row1 = xyLimits(1,:);
row2 = xyLimits(2,:);
xfMin = min(row1); xfMax = max(row1);
yfMin = min(row2); yfMax = max(row2);

[outRow outCol] = size(outImage);
stepRow = (yfMax - yfMin)/outRow;
stepCol = (xfMax - xfMin)/outCol;
xyGrid = zeros(2,outRow*outCol);
y = yfMax-0.5*stepRow;

for i = 1:outRow
    x = xfMin+0.5*stepCol;
    for j = 1:outCol
        xyGrid(1,(i-1)*outCol+j) = x;
        xyGrid(2,(i-1)*outCol+j) = y;
        x = x + stepCol;
    end
    y = y - stepRow;
end
%TransformGround2Image
uvGrid = TransformGround2Image(xyGrid,cameraInfo);
% mean value of the image
means = mean(R(:))/255;
RR = double(R)/255;
for i=1:outRow
    for j = 1:outCol;
        ui = uvGrid(1,(i-1)*outCol+j);
        vi = uvGrid(2,(i-1)*outCol+j);
         if (ui<ipmInfo.ipmLeft || ui>ipmInfo.ipmRight || vi<ipmInfo.ipmTop || vi>ipmInfo.ipmBottom) 
          outImage(i,j) = means;
         else
             x1 = int32(ui); x2 = int32(ui+1);
             y1 = int32(vi); y2 = int32(vi+1);
              x = ui-double(x1) ;  y = vi-double(y1);
             val = double(RR(y1,x1))*(1-x)*(1-y)+double(RR(y1,x2))*x*(1-y)+double(RR(y2,x1))*(1-x)*y+double(RR(y2,x2))*x*y;
              outImage(i,j) = val;
         end
    end
end
%%  show the result
figure,imshow(outImage);
%% save image
imwrite(outImage,'pp.jpg');
