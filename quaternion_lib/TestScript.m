
close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal


axis = [1 2 3];
axis = axis / norm(axis);
angle = pi/2;

R = axisAngle2rotMat(axis, angle);
num = ' % 1.5f';
a = sprintf('\rAxis-angle to rotation matrix:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num), R(1,:));
c = sprintf(strcat('\r', num, '\t', num, '\t', num), R(2,:));
d = sprintf(strcat('\r', num, '\t', num, '\t', num), R(3,:));
disp(strcat(a,b,c,d));



q = axisAngle2quatern(axis, angle);
num = ' % 1.5f';
a = sprintf('\rAxis-angle to quaternion:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num, '\t', num), q);
disp(strcat(a,b));



R = quatern2rotMat(q);
num = ' % 1.5f';
a = sprintf('\rQuaternion to rotation matrix:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num), R(1,:));
c = sprintf(strcat('\r', num, '\t', num, '\t', num), R(2,:));
d = sprintf(strcat('\r', num, '\t', num, '\t', num), R(3,:));
disp(strcat(a,b,c,d));



q = rotMat2quatern(R);
num = ' % 1.5f';
a = sprintf('\rRotation matrix to quaternion:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num, '\t', num), q);
disp(strcat(a,b));



euler = rotMat2euler(R);
num = ' % 1.5f';
a = sprintf('\rRotation matrix to ZYX Euler angles:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num), euler);
disp(strcat(a,b));



euler = quatern2euler(q);
num = ' % 1.5f';
a = sprintf('\rQuaternion to ZYX Euler angles:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num), euler);
disp(strcat(a,b));



R = euler2rotMat(euler(1), euler(2), euler(3));
num = ' % 1.5f';
a = sprintf('\rZYX Euler angles to rotation matrix:');
b = sprintf(strcat('\r', num, '\t', num, '\t', num), R(1,:));
c = sprintf(strcat('\r', num, '\t', num, '\t', num), R(2,:));
d = sprintf(strcat('\r', num, '\t', num, '\t', num), R(3,:));
disp(strcat(a,b,c,d));
