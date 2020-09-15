%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion [P Q R H]=init_filter()
%
%> @brief 滤波初始化
%>
%> @details 卡尔曼滤波初始化. 相关设置见：settings.m
%>
%> @param[out]   P     状态协方差矩阵
%> @param[out]   Q     过程噪声协方差矩阵
%> @param[out]   R     量测噪声协方差矩阵
%> @param[out]   H     观测矩阵
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [P Q R H]=init_filter

global simdata;

% 确定状态方程

if (strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'on')) % Both scale and bias errors included
    
    
    
    %  初始化状态矩阵
    P=zeros(9+6+6);
    P(10:12,10:12)=diag(simdata.sigma_initial_acc_bias.^2);
    P(13:15,13:15)=diag(simdata.sigma_initial_gyro_bias.^2);
    P(16:18,16:18)=diag(simdata.sigma_initial_acc_scale.^2);
    P(19:21,19:21)=diag(simdata.sigma_initial_gyro_scale.^2);
    
    
    
    Q=zeros(12);
    Q(7:9,7:9)=diag(simdata.acc_bias_driving_noise.^2);
    Q(10:12,10:12)=diag(simdata.gyro_bias_driving_noise.^2);
    
    
    H=zeros(3,9+6+6);
    
elseif strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'off') % Scale errors included
    
    
    
    %  初始化状态矩阵
    P=zeros(9+6);
    P(10:12,10:12)=diag(simdata.sigma_initial_acc_scale.^2);
    P(13:15,13:15)=diag(simdata.sigma_initial_gyro_scale.^2);
    
    % 过程噪声
    Q=zeros(6);
    
    % 观测矩阵
    H=zeros(3,9+6);
    
elseif strcmp(simdata.scalefactors,'off') && strcmp(simdata.biases,'on') % Bias errors included
    
    
    
    %  初始化状态矩阵
    P=zeros(9+6);
    P(10:12,10:12)=diag(simdata.sigma_initial_acc_bias.^2);
    P(13:15,13:15)=diag(simdata.sigma_initial_gyro_bias.^2);
    
    % 过程噪声
    Q=zeros(12);
    Q(7:9,7:9)=diag(simdata.acc_bias_driving_noise.^2);
    Q(10:12,10:12)=diag(simdata.gyro_bias_driving_noise.^2);
    
    %观测矩阵
    H=zeros(3,9+6);
    
else 
    
    % 初始化状态矩阵
    P=zeros(9);
    
    % 过程噪声
    Q=zeros(6);
    
    % 观测矩阵
    H=zeros(3,9);
end


% 观测矩阵初始化 H，速度观测
H(1:3,4:6)=eye(3);

% 协方差矩阵初始化 P
P(1:3,1:3)=diag(simdata.sigma_initial_pos.^2);
P(4:6,4:6)=diag(simdata.sigma_initial_vel.^2);
P(7:9,7:9)=diag(simdata.sigma_initial_att.^2);

% 过程噪声矩阵初始化 Q
Q(1:3,1:3)=diag(simdata.sigma_acc.^2);
Q(4:6,4:6)=diag(simdata.sigma_gyro.^2);

% 量测噪声矩阵初始化 R
R=diag(simdata.sigma_vel.^2);

end