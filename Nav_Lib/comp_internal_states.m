%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% function [x_out q_out]=comp_internal_states(x_in,dx,q_in)
%
% brief 根据卡尔曼估计结果进行误差修正
%
% details 函数用卡尔曼滤波估计的系统摄动(误差)来校正估计的导航状态。
% 也就是说，导航平台的当前位置和速度估计是通过在这些状态中加入估计的系统摄动来修正的。
% 为了校正方向状态(欧拉角和四元数向量)，首先将四元数向量转换为旋转矩阵，然后利用估计
% 的方向扰动对旋转矩阵进行校正。将校正后的旋转矩阵转化为四元数向量和欧拉角的等效向量。        
%
% param[out]   x_out     修正后的导航状态输出.
% param[out]   q_out     修正后的四元数.
% param[in]    x_in      导航估计输入.
% param[in]    q_in      四元数向量.
% param[in]    dx        系统扰动向量
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x_out q_out]=comp_internal_states(x_in,dx,q_in)

% 四元数到旋转矩阵
R=q2dcm(q_in);

% 状态修正
x_out=x_in+dx;

% 旋转矩阵修正
epsilon=dx(7:9);
OMEGA=[0 -epsilon(3) epsilon(2); epsilon(3) 0 -epsilon(1); -epsilon(2) epsilon(1) 0];
R=(eye(3)-OMEGA)*R;


% 角度修正
x_out(7)=atan2(R(3,2),R(3,3));
x_out(8)=-atan(R(3,1)/sqrt(1-R(3,1)^2));
x_out(9)=atan2(R(2,1),R(1,1));

% 计算修正四元数
q_out=dcm2q(R);



end