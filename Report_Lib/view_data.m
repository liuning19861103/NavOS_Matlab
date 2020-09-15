%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% file view_data.m  
%
% brief �������
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global simdata;


close all

N=length(cov);
t=0:simdata.Ts:(N-1)*simdata.Ts;


%% ����������
figure
clf
subplot(2,1,1)
plot(t,u(1:3,:)')
xlabel('ʱ�� [s]')
ylabel('���ٶ� [m/s^2]')
title('���ٶȲ���')
legend('x-axis','y-axis','z-axis')
box on
grid on

subplot(2,1,2)
plot(t,u(4:6,:)'*180/pi)
xlabel('ʱ�� [s]')
ylabel('������  [deg/s]')
title('�����ʲ���')
legend('x-axis','y-axis','z-axis')
box on
grid on


%% ���ƹ켣
figure
clf
[Row,Line]=size(x_h);
plot(x_h(2,:),x_h(1,:))
hold
plot(x_h(2,1),x_h(1,1),'rs')
plot(x_h(2,Line),x_h(1,Line),'gs')
title('�˶��켣��ʾ')
text=legend('ʵ���˶��켣','��ʼ�˶���','��ֹ�˶���');
set(text,'Location','NorthWest')
set(text,'Interpreter','none')
xlabel('x [m]')
ylabel('y [m]')
axis equal
grid on
box on


%% ��̬���

figure
clf
plot(t,(x_h(7:9,:)')*180/pi)
title('��̬')
xlabel('ʱ�� [s]')
ylabel('�Ƕ� [deg]')
legend('Roll','Pitch','Yaw')
grid on
box on


figure
clf

subplot(3,1,1)
plot(t,sqrt(cov(1:3,:))')
title('λ��Э����')
ylabel('sqrt(cov) [m]')
xlabel('ʱ�� [s]')
legend('x-axis', 'y-axis','z-axis')
grid on
box on


subplot(3,1,2)
plot(t,sqrt(cov(4:6,:))')
title('�ٶ�Э����')
ylabel('sqrt(cov) [m/s]')
xlabel('ʱ�� [s]')
legend('x-axis', 'y-axis','z-axis')
grid on
box on

subplot(3,1,3)
plot(t,sqrt(cov(7:9,:))'*180/pi)
title('�Ƕ�Э����')
ylabel('sqrt(cov) [deg]')
xlabel('ʱ�� [s]')
legend('Roll', 'Pitch','Yaw')
grid on
box on




%% ��ƫ���������

if (strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'on'))
    %    ��ƫ+�������
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(10:12,:)')
    legend('x-axis','y-axis','z-axis')
    title('���ٶȼ���ƫ���')
    xlabel('ʱ�� [s]')
    ylabel('��ƫ [m/s^2]')
    grid on
    box on
    
    subplot(2,1,2)
    plot(t,x_h(13:15,:)'*180/pi)
    legend('x-axis','y-axis','z-axis')
    title('������ƫ���')
    xlabel('ʱ�� [s]')
    ylabel('��ƫ [deg/s]')
    box on
    grid on
    
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(16:18,:)')
    legend('x-axis','y-axis','z-axis')
    title('���ٶȼƱ���������')
    xlabel('ʱ�� [s]')
    box on
    grid on
    
    subplot(2,1,2)
    plot(t,x_h(19:21,:)')
    legend('x-axis','y-axis','z-axis')
    title('���ݱ���������')
    xlabel('ʱ�� [s]')
    box on
    grid on
    
    
elseif strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'off')
    %    �������
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(10:12,:)')
    legend('x-axis','y-axis','z-axis')
    title('���ٶȼƱ���������')
    xlabel('ʱ�� [s]')
    box on
    grid on
    
    subplot(2,1,2)
    plot(t,x_h(13:15,:)'*180/pi)
    legend('x-axis','y-axis','z-axis')
    title('�����Ǳ���������')
    xlabel('ʱ�� [s]')
    box on
    grid on
    
elseif strcmp(simdata.scalefactors,'off') && strcmp(simdata.biases,'on')
    
    figure
    clf
    subplot(2,1,1)
    plot(t,x_h(10:12,:)')
    legend('x-axis','y-axis','z-axis')
    title('���ٶȼ���ƫ���')
    xlabel('ʱ�� [s]')
    ylabel('��ƫ [m/s^2]')
    grid on
    box on
    
    subplot(2,1,2)
    plot(t,x_h(13:15,:)'*180/pi)
    legend('x-axis','y-axis','z-axis')
    title('��������ƫ���')
    xlabel('ʱ�� [s]')
    ylabel('��ƫ [deg/s]')
    box on
    grid on
end








