%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion [F G]=state_matrix(q,u)
%
%> @brief 状态向量计算 
%>
%> @details 计算状态转移矩阵 F，过程噪声增益矩阵 G  
%>
%> @param[out]   F     状态转移矩阵
%> @param[out]   G     过程噪声增益矩阵
%> @param[in]    u     传感器输入
%> @param[in]    q     四元数输入
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [F G]=state_matrix(q,u,k)

global simdata

% 四元数转方向余弦矩阵
Rb2t=q2dcm(q);

% 比例计算
f_t=Rb2t*u(1:3);

% 比力反对陈矩阵
St=[0 -f_t(3) f_t(2); f_t(3) 0 -f_t(1); -f_t(2) f_t(1) 0];

O=zeros(3);

I=eye(3);

% 比力和陀螺对角矩阵
Da=diag(u(1:3));
Dg=diag(u(4:6));

% 修正陀螺、加速度计零偏时间系数
B1=-1/simdata.acc_bias_instability_time_constant_filter*eye(3);
B2=-1/simdata.gyro_bias_instability_time_constant_filter*eye(3);


% 确定状态方程
if (strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'on'))
    % 零偏+标度因数
    Fc=[O I O   O     O     O         O    ;
        O O St Rb2t   O    Rb2t*Da    O    ;
        O O O   O   -Rb2t   O     -Rb2t*Dg ;
        O O O   B1    O     O         O    ;
        O O O   O     B2    O         O    ;
        O O O   O     O     O         O    ;
        O O O   O     O     O         O   ];
    
    % 噪声增益
    Gc=[O O O O; Rb2t O O O; O -Rb2t O O; O O I O; O O O I; O O O O; O O O O];
    
    
    
elseif strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'off')
    % 标度因数
    Fc=[O I O       O       O    ;
        O O St  Rb2t*Da     O    ;
        O O O       O   -Rb2t*Dg ;
        O O O       O       O    ;
        O O O       O       O];
    
    % 噪声增益
    Gc=[O O; Rb2t O ; O -Rb2t; O O; O O];
    
elseif strcmp(simdata.scalefactors,'off') && strcmp(simdata.biases,'on')
    % 零偏
    Fc=[O I O O O;
        O O St Rb2t O;
        O O O O -Rb2t;
        O O O B1 O;
        O O O O B2];
    
    % 噪声增益
    Gc=[O O O O; Rb2t O O O; O -Rb2t O O; O O I O; O O O I];
    
else
    Fc=[O I O;
        O O St;
        O O O];
    
    % 噪声增益
    Gc=[O O; Rb2t O; O -Rb2t];
    
end


% 离散化
F=eye(size(Fc))+simdata.Ts(k)*Fc;
G=simdata.Ts(k)*Gc;
end