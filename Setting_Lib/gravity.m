%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% funtion g=gravity(lambda,h) 
%
% brief 计算当地重力值 
%
% details 
%
% param[out]  g          本地重力场幅值 [m/s^2] 
% param[in]   lambda     纬度 [degrees] 
% param[in]   h          高度 [m]  
% contents  
%  用户可自行选择是否应用本功能

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function g=gravity(lambda,h)

lambda=pi/180*lambda;
gamma=9.780327*(1+0.0053024*sin(lambda)^2-0.0000058*sin(2*lambda)^2);
g=gamma-((3.0877e-6)-(0.004e-6)*sin(lambda)^2)*h+(0.072e-12)*h^2;
end