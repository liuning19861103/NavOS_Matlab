%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% funtion [x_h cov]=Navigation_Alg(u,zupt)
%
% brief 导航算法主程序框架 
% 
% details 算法包含整体的组合导航函数和相关功能，相关设置见：setting.m. 
%
% param[out]  x_h     导航状态估计矩阵，每一行输出一种状态变量       
% param[out]  cov     协方差阵（对角矩阵）
% param[in]   u       传感器输入数据     
% param[in]   ModalFlag    模型约束数据
%
% authors: Liu Ning
% 
% CopyRight: 版权归北京信息科技大学高动态导航技术北京市重点实验室所有，最终解释权归该高动态导航技术北京市重点实验室所有
%            Copyright (c) 2015 Beijing key library of High dynamic navigation technology, ISC License (open source)
% 技术问题可发送问题至：liuning1898@qq.com，刘宁，13810655202
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x_h cov]=Navigation_Alg(u,ModalFlag)


% 获取传感器数据长度
N=length(u);

% 初始化滤波状态协方差 P, 过程噪声协方差 Q, 量测噪声协方差 R, 观测矩阵 H.
[P Q R H]=init_filter;          

% 声明内存空间
[x_h cov Id]=init_vec(N,P);    

% 初始化PVA向量 x_h, 初始化四元数
[x_h(1:9,1) quat]=init_Nav_eq(u);  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%               执行滤波算法                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=2:N
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %            时间更新            %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % 传感器误差补偿 
    u_h=comp_imu_errors(u(:,k),x_h(:,k-1)); 

    
    % 导航方程更新   
    [x_h(:,k) quat]=Navigation_equations(x_h(:,k-1),u_h,quat,k); 

    
    % 状态转移矩阵更新
    [F G]=state_matrix(quat,u_h,k); 

    
    % 更新状态协方差矩阵 P.
    P=F*P*F'+G*Q*G';
    
    % 对称状态协方差. 
    P=(P+P')/2;
    
    % 存储协方差矩阵 P.
    cov(:,k)=diag(P);
   
     
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %             量测更新           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % 检测模型辨识结果，true则进入量测
    if ModalFlag(k)==true;
        
        % 计算卡尔曼滤波增益
        K=(P*H')/(H*P*H'+R);
        
        % 计算预测误差，目前为加入了静止检测的车体零速修正，检测量为速度    
        z=-x_h(4:6,k);   
        
        % 扰动计算
        dx=K*z;
        
        % 导航参数修正
        [x_h(:,k) quat]=comp_internal_states(x_h(:,k),dx,quat);    
    
        
        % 更新滤波状态协方差阵 P.
        P=(Id-K*H)*P;
        
        % 对称状态协方差. 
        P=(P+P')/2;
    
        % 存储协方差 P.
        cov(:,k)=diag(P);
    end
        
end

end

