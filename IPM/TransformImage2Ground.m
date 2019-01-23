function [ xyLimits ] = TransformImage2Ground( uvLimits,cameraInfo )
%TransformImage2Ground Summary of this function goes here
%   Detailed explanation goes here
[row , col ] = size(uvLimits);
inPoints4 = zeros(row+2,col);
inPoints4(1:2,:) = uvLimits;
inPoints4(3,:) = 1;
inPoints3 = inPoints4(1:3,:);

c1 = cos(cameraInfo.pitch*pi/180);
s1 = sin(cameraInfo.pitch*pi/180);
c2 = cos(cameraInfo.yaw*pi/180);
s2 = sin(cameraInfo.yaw*pi/180);

matp= [
    -cameraInfo.cameraHeight*c2/cameraInfo.focalLengthX,cameraInfo.cameraHeight*s1*s2/cameraInfo.focalLengthY,(cameraInfo.cameraHeight*c2*cameraInfo.opticalCenterX/cameraInfo.focalLengthX)- (cameraInfo.cameraHeight *s1*s2* cameraInfo.opticalCenterY/ cameraInfo.focalLengthY) - cameraInfo.cameraHeight *c1*s2;

    cameraInfo.cameraHeight *s2/cameraInfo.focalLengthX, ...
    cameraInfo.cameraHeight *s1*c2/cameraInfo.focalLengthY, ...
    (-cameraInfo.cameraHeight *s2* cameraInfo.opticalCenterX ....
      /cameraInfo.focalLengthX)-(cameraInfo.cameraHeight *s1*c2* ....
      cameraInfo.opticalCenterY /cameraInfo.focalLengthY) -  ...
      cameraInfo.cameraHeight *c1*c2;

    0, cameraInfo.cameraHeight *c1/cameraInfo.focalLengthY, (-cameraInfo.cameraHeight *c1* cameraInfo.opticalCenterY/cameraInfo.focalLengthY)+cameraInfo.cameraHeight*s1;

    0, -c1 /cameraInfo.focalLengthY,(c1* cameraInfo.opticalCenterY /cameraInfo.focalLengthY) - s1];

inPoints4 = matp*inPoints3;
inPointsr4 = inPoints4(4,:);
div = inPointsr4;
inPoints4(1,:) = inPoints4(1,:)./div;
inPoints4(2,:) = inPoints4(2,:)./div;
inPoints2 = inPoints4(1:2,:);
xyLimits = inPoints2;

end

