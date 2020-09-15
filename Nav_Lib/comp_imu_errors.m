%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% function u_out=comp_imu_errors(u_in,x_h)
%
% brief 传感器误差补偿函数  
%
% details 根据修正量进行误差补偿 
%     
% param[out]   u_out     补偿后误差输出
% param[in]    u_in      传感器数据输入
% param[in]    x_h       导航修正量输入
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u_out=comp_imu_errors(u_in,x_h)

global simdata;

% 确定误差修正方式

if (strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'on'))
    
    % 零偏、标度因数均修正
    temp=1./(ones(6,1)-x_h(16:end));
    u_out=diag(temp)*u_in+x_h(10:15);
    
    
elseif strcmp(simdata.scalefactors,'on') && strcmp(simdata.biases,'off')
    
    % 标度因数补偿
    temp=1./(ones(6,1)-x_h(10:end));
    u_out=diag(temp)*u_in;
    
elseif strcmp(simdata.scalefactors,'off') && strcmp(simdata.biases,'on')
    
    % 零偏补偿
    u_out=u_in+x_h(10:end);
    
else
    
    % 不进行误差修正
    u_out=u_in;
end

end