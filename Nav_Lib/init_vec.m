%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% funtion [x_h cov Id]=init_vec(N,P)
%
%
% brief 初始化协方差
%
% param[out]  x_h     初始化导航状态
% param[out]  cov     协方差对角矩阵
% param[out]  Id      单位矩阵
% param[in]   N       数据长度
% param[in]   P       初始化状态矩阵
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x_h cov Id]=init_vec(N,P)

global simdata


% 确定状态模型
if (strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'on'))
    % 零偏+标度因数
    cov=zeros(9+6+6,N);
    x_h=zeros(9+6+6,N);
    
elseif strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'off')
    % 标度因数
    cov=zeros(9+6,N);
    x_h=zeros(9+6,N);
    
elseif strcmp(simdata.scalefactors,'off') && strcmp(simdata.biases,'on')
    % 零偏
    cov=zeros(9+6,N);
    x_h=zeros(9+6,N);
else

    cov=zeros(9,N);
    x_h=zeros(9,N);
end


Id=eye(size(P));
cov(:,1)=diag(P);
end