%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% brief: 系统运行参数设置
% File Name: setting.m
% Project Name: NavOS
% Author: Liu Ning
% CopyRight: 版权归北京信息科技大学高动态导航技术北京市重点实验室所有，最终解释权归该高动态导航技术北京市重点实验室所有
%            Copyright (c) 2020 Beijing key library of High dynamic navigation technology, ISC License (open source)
% Description:
% 
% Content
% Data      Author     Notes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 主函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  funtion u=settings() 
%> @brief 进行系统设置和惯导数据导入接口设置   
%> @param[out]  u 惯导数据，包含x、y、z陀螺仪和角速度、地磁信息 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u=settings(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 定义全局变量，全局内的系统仿真参数设置
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global simdata;
% 计算当地重力幅值
% 当地高度 [m]
simdata.altitude=116.3;
% 当地纬度 [degrees]
simdata.latitude=58;
% 当地加速度矢量值 [m/s^2]
simdata.g=gravity(simdata.latitude,simdata.altitude);
% 系统采样时间 [s]
simdata.Ts(1)=1/100;
% 导入惯性测量单元数据
u=load_dataset(filename);
% 初始航向角 [rad]
simdata.init_yaw    = 0*pi/180;
simdata.init_pitch  = 0*pi/180;
simdata.init_theta  = 0*pi/180;

% 初始位置 (x,y,z)-axis [m] 北东地坐标
simdata.init_pos=[0 0 0]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 背景模型检测参数设置
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 通过更改字符可改变不同的零速检测模式 
% GLRT - 最大似然估计
% MV   - 加速度测量方差检测
% MAG  - 加速度测量幅值检测
% ARE  - 角速度测量能量检测 
simdata.detector_type='GLRT';
% 加速度计标准差 [m/s^2]. 
% 用于进行载体模型辨识所需的状态特征识别用加速度计统计信息。
simdata.sigma_a=5.5; 
% 陀螺仪标准差 [rad/s]. 
% 用于进行载体模型辨识所需的状态特征识别用加速度计统计信息。
simdata.sigma_g=0.6*pi/180;     
% 载体模型辨识所需的缓冲数据长度 [samples] 
simdata.Window_size=10;
% 模型辨识阈值
simdata.gamma=0.1e5; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%滤波参数设置 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 滤波器可采用9维状态、12维、18维、24维(位置、速度、姿态)状态空间模型。状态空间模型中也可包括传感器偏差和标度因数偏差。

% 状态变量零偏数据开关，on是打开，off是关闭，以下未特别指出均按照此种方式。
simdata.biases='off';

% 状态变量标度因数数据开关
simdata.scalefactors='off';

% 对于过程噪声、测量噪声和初始状态协方差矩阵Q、R和P的设置，假设这三个矩阵都是对角矩阵，所有的设置都定义为标准差。
% 过程噪声：加速度计噪声 (x,y,z载体坐标系)[m/s^2].
simdata.sigma_acc =0.051*[1 1 1]';

% 过程噪声：陀螺仪噪声 (x,y,z载体坐标系)[m/s^2][rad/s].
simdata.sigma_gyro =0.08*[1 1 1]'*pi/180; % [rad/s]

% 过程噪声：加速度计零位稳定性噪声 (x,y,z载体坐标系)[m/s^2].
simdata.acc_bias_driving_noise=0.01*ones(3,1); 

% 过程噪声：加速度计零位稳定性噪声 (x,y,z载体坐标系)[m/s^2].
simdata.gyro_bias_driving_noise=0.01*pi/180*ones(3,1); 


% 量测噪声：速度测量噪声、位置测量噪声、姿态测量噪声
simdata.sigma_vel=[0.001 0.001 0.001];      %[m/s] 
simdata.sigma_pos=[0.001 0.001 0.001];      %[m]
simdata.sigma_att=[0.1   0.1   0.1  ];      %[rad]

% 对角矩阵，状态协方差阵设置 (P).    
simdata.sigma_initial_pos=0.0001*ones(3,1);                % 位置 (x,y,z 导航坐标系) [m]
simdata.sigma_initial_vel=0.0001*ones(3,1);                % 速度 (x,y,z 导航坐标系) [m/s]
simdata.sigma_initial_att=(pi/180*[0.01 0.01 0.01]');      % 姿态 (roll,pitch,heading 导航坐标系) [rad]
simdata.sigma_initial_acc_bias=0.3*ones(3,1);              % 加速度计零偏 (x,y,z 载体坐标系)[m/s^2]
simdata.sigma_initial_gyro_bias=0.5*pi/180*ones(3,1);      % 陀螺仪零偏 (x,y,z 载体坐标系) [rad/s]                               
simdata.sigma_initial_acc_scale=0.0001*ones(3,1);          % 加速度计标度因数 (x,y,z 载体坐标系)   
simdata.sigma_initial_gyro_scale=0.00001*ones(3,1);        % 陀螺仪标度因数 (x,y,z 载体坐标系)    

% 零偏不稳定性时间常数 [seconds]. 
simdata.acc_bias_instability_time_constant_filter=inf;
simdata.gyro_bias_instability_time_constant_filter=inf;



end
