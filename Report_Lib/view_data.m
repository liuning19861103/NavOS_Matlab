%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% file view_data.m  
%
% brief 曲线输出
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global simdata;


close all

N=length(cov);
t=0:simdata.Ts:(N-1)*simdata.Ts;


%% 传感器数据
figure
clf
subplot(2,1,1)
plot(t,u(1:3,:)')
xlabel('时间 [s]')
ylabel('加速度 [m/s^2]')
title('加速度测量')
legend('x-axis','y-axis','z-axis')
box on
grid on

subplot(2,1,2)
plot(t,u(4:6,:)'*180/pi)
xlabel('时间 [s]')
ylabel('角速率  [deg/s]')
title('角速率测量')
legend('x-axis','y-axis','z-axis')
box on
grid on


%% 绘制轨迹
figure
clf
[Row,Line]=size(x_h);
plot(x_h(2,:),x_h(1,:))
hold
plot(x_h(2,1),x_h(1,1),'rs')
plot(x_h(2,Line),x_h(1,Line),'gs')
title('运动轨迹显示')
text=legend('实际运动轨迹','起始运动点','终止运动点');
set(text,'Location','NorthWest')
set(text,'Interpreter','none')
xlabel('x [m]')
ylabel('y [m]')
axis equal
grid on
box on


%% 姿态输出

figure
clf
plot(t,(x_h(7:9,:)')*180/pi)
title('姿态')
xlabel('时间 [s]')
ylabel('角度 [deg]')
legend('Roll','Pitch','Yaw')
grid on
box on


figure
clf

subplot(3,1,1)
plot(t,sqrt(cov(1:3,:))')
title('位置协方差')
ylabel('sqrt(cov) [m]')
xlabel('时间 [s]')
legend('x-axis', 'y-axis','z-axis')
grid on
box on


subplot(3,1,2)
plot(t,sqrt(cov(4:6,:))')
title('速度协方差')
ylabel('sqrt(cov) [m/s]')
xlabel('时间 [s]')
legend('x-axis', 'y-axis','z-axis')
grid on
box on

subplot(3,1,3)
plot(t,sqrt(cov(7:9,:))'*180/pi)
title('角度协方差')
ylabel('sqrt(cov) [deg]')
xlabel('时间 [s]')
legend('Roll', 'Pitch','Yaw')
grid on
box on




%% 零偏及标度因数

if (strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'on'))
    %    零偏+标度因数
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(10:12,:)')
    legend('x-axis','y-axis','z-axis')
    title('加速度计零偏误差')
    xlabel('时间 [s]')
    ylabel('零偏 [m/s^2]')
    grid on
    box on
    
    subplot(2,1,2)
    plot(t,x_h(13:15,:)'*180/pi)
    legend('x-axis','y-axis','z-axis')
    title('陀螺零偏误差')
    xlabel('时间 [s]')
    ylabel('零偏 [deg/s]')
    box on
    grid on
    
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(16:18,:)')
    legend('x-axis','y-axis','z-axis')
    title('加速度计标度因数误差')
    xlabel('时间 [s]')
    box on
    grid on
    
    subplot(2,1,2)
    plot(t,x_h(19:21,:)')
    legend('x-axis','y-axis','z-axis')
    title('陀螺标度因数误差')
    xlabel('时间 [s]')
    box on
    grid on
    
    
elseif strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'off')
    %    标度因数
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(10:12,:)')
    legend('x-axis','y-axis','z-axis')
    title('加速度计标度因数误差')
    xlabel('时间 [s]')
    box on
    grid on
    
    subplot(2,1,2)
    plot(t,x_h(13:15,:)'*180/pi)
    legend('x-axis','y-axis','z-axis')
    title('陀螺仪标度因数误差')
    xlabel('时间 [s]')
    box on
    grid on
    
elseif strcmp(simdata.scalefactors,'off') && strcmp(simdata.biases,'on')
    
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(10:12,:)')
    legend('x-axis','y-axis','z-axis')
    title('加速度计零偏误差')
    xlabel('时间 [s]')
    ylabel('零偏 [m/s^2]')
    grid on
    box on
    
    subplot(2,1,2)
    plot(t,x_h(13:15,:)'*180/pi)
    legend('x-axis','y-axis','z-axis')
    title('陀螺仪零偏误差')
    xlabel('时间 [s]')
    ylabel('零偏 [deg/s]')
    box on
    grid on
end








