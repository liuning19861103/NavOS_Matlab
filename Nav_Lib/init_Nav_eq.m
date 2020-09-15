%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion [x quat]=init_Nav_eq(u)
%
%> @brief 导航参数初始化，包含静态初始对准、动态初始对准未添加.
%>
%> @details 初始对准
%>
%> @param[out]  x     初始导航向量
%> @param[out]  quat  初始四元数
%> @param[in]   u     传感器数据输入
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x quat]=init_Nav_eq(u)

    global simdata;

    % 统计静态加速度值
    f_u=mean(u(1,1:20));
    f_v=mean(u(2,1:20));
    f_w=mean(u(3,1:20));

    roll=atan2(-f_v,-f_w);
    pitch=atan2(f_u,sqrt(f_v^2+f_w^2));


    % 设置姿态向量
    attitude=[roll pitch simdata.init_yaw]';
    % 计算四元数
    Rb2t=Rt2b(attitude)';
    quat=dcm2q(Rb2t);

    % 设置初始状态向量
    x=zeros(9,1);
    x(1:3,1)=simdata.init_pos;
    x(7:9,1)=attitude;
end