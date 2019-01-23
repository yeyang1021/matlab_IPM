function [ vp ] = GetVanishingPoint( cameraInfo )
%GetVanishingPoint Summary of this function goes here
%   Detailed explanation goes here
 vpp = [ sin(cameraInfo.yaw*pi/180)/cos(cameraInfo.pitch*pi/180);cos(cameraInfo.yaw*pi/180)/cos(cameraInfo.pitch*pi/180);0];

 tyawp = [
	  cos(cameraInfo.yaw*pi/180), -sin(cameraInfo.yaw*pi/180), 0;         
	  sin(cameraInfo.yaw*pi/180), cos(cameraInfo.yaw*pi/180), 0;
      0, 0, 1];
  
 tpitchp = [1, 0, 0;
            0, -sin(cameraInfo.pitch*pi/180), -cos(cameraInfo.pitch*pi/180);
            0, cos(cameraInfo.pitch*pi/180), -sin(cameraInfo.pitch*pi/180)];
  
 transform = tyawp*tpitchp;
 
 
 t1p = [
    cameraInfo.focalLengthX, 0, cameraInfo.opticalCenterX;
    0, cameraInfo.focalLengthY, cameraInfo.opticalCenterY;
    0, 0, 1];
transform = t1p*transform;

vp = transform*vpp;
 
end

