function [ uvGrid ] = TransformGround2Image( xyGrid, cameraInfo )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

inPoints2 = xyGrid(1:2,:);
inPointsr3 = ones(1,size(xyGrid,2))*-cameraInfo.cameraHeight;
inPoints3 = [inPoints2;inPointsr3];

c1 = cos(cameraInfo.pitch*pi/180);
s1 = sin(cameraInfo.pitch*pi/180);
c2 = cos(cameraInfo.yaw*pi/180);
s2 = sin(cameraInfo.yaw*pi/180);

 matp = [
    cameraInfo.focalLengthX * c2 + c1*s2* cameraInfo.opticalCenterX, ...
    -cameraInfo.focalLengthX * s2 + c1*c2* cameraInfo.opticalCenterX, ...
    - s1 * cameraInfo.opticalCenterX;

    s2 * (-cameraInfo.focalLengthY * s1 + c1* cameraInfo.opticalCenterY), ...
    c2 * (-cameraInfo.focalLengthY * s1 + c1* cameraInfo.opticalCenterY), ...
    -cameraInfo.focalLengthY * c1 - s1* cameraInfo.opticalCenterY;
    
    c1*s2, c1*c2, -s1];

inPoints3 = matp*inPoints3;
inPointsr3 = inPoints3(3,:);
div = inPointsr3;
inPoints3(1,:) = inPoints3(1,:)./div;
inPoints3(2,:) = inPoints3(2,:)./div;
inPoints2 = inPoints3(1:2,:);
uvGrid = inPoints2;
end

