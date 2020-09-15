%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% funtion [y,q]=Navigation_equations(x,u,q)
%
% brief 导航系统机械编排
%
% details 导航基本方程  
%
% param[out]   y     导航状态输出
% param[out]   q     输出四元数
% param[in]    x     导航状态输入
% param[in]    u     传感器数据输入
% param[in]    q     四元数输入
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,q]=Navigation_equations(x,u,q,k)

global simdata;

% 声明内存
y=zeros(size(x));

% 获取采样时间
Ts=simdata.Ts(k);

%*************************************************************************%
% 更新四元数
%*************************************************************************%

w_tb=u(4:6);

P=w_tb(1)*Ts;
Q=w_tb(2)*Ts;
R=w_tb(3)*Ts;

OMEGA=zeros(4);
OMEGA(1,1:4)=0.5*[0 R -Q P];
OMEGA(2,1:4)=0.5*[-R 0 P Q];
OMEGA(3,1:4)=0.5*[Q -P 0 R];
OMEGA(4,1:4)=0.5*[-P -Q -R 0];

v=norm(w_tb)*Ts;

if v~=0
    q=(cos(v/2)*eye(4)+2/v*sin(v/2)*OMEGA )*q;
    q=q./norm(q);
end

%*************************************************************************%
% 姿态跟新
%*************************************************************************%

Rb2t=q2dcm(q);
% 滚转
y(7)=atan2(Rb2t(3,2),Rb2t(3,3));

% 俯仰
y(8)=-atan(Rb2t(3,1)/sqrt(1-Rb2t(3,1)^2));

% 偏航
y(9)=atan2(Rb2t(2,1),Rb2t(1,1));


%*************************************************************************%
% 速度位置更新
%*************************************************************************%

% 获取重力信息
g_t=[0 0 simdata.g]';

% 比力计算
f_t=q2dcm(q)*u(1:3);

% 重力补偿
acc_t=f_t+g_t;

% 离散化
A=eye(6);
A(1,4)=Ts;
A(2,5)=Ts;
A(3,6)=Ts;

B=[(Ts^2)/2*eye(3);Ts*eye(3)];

% 位置速度更新
y(1:6)=A*x(1:6)+B*acc_t;
end