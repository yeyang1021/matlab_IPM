function [ cameraInfo, ipmInfo ] = GetInfo
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%   camera Info
% focal length
cameraInfo.focalLengthX=1200.6831;
cameraInfo.focalLengthY=1200.6831;

% optical center
cameraInfo.opticalCenterX=638.1608;
cameraInfo.opticalCenterY=738.8648;

% height of the camera in mm
cameraInfo.cameraHeight=1879.8 ;
% 393.7 + 1786.1

% pitch of the camera
cameraInfo.pitch=15.5;

% yaw of the camera
cameraInfo.yaw=0.0;

% imag width and height
cameraInfo.imageWidth=1280;
cameraInfo.imageHeight=1024;

%%   ipmInfo
%settings for stop line perceptor
%128
ipmInfo.ipmWidth = 640;
%160%320%160 
%96
ipmInfo.ipmHeight = 480;
%120%240%120
ipmInfo.ipmLeft = 256;
%80 %90 %115 %140 %50 %85 %100 %85
ipmInfo.ipmRight = 1024;
%500 %530 %500 %590 %550
ipmInfo.ipmTop = 500;
%220 %200 %50
ipmInfo.ipmBottom = 1000;
%360 %350 %380
%0 bilinear, 1: NN
ipmInfo.ipmInterpolation = 0;
ipmInfo.ipmVpPortion = 0;
%.09 %0.06 %.05 %.125 %.2 %.15 %.075%0.1 %.05


end

