%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion  [ModalFlag T] = Modal_detector(u) 
%
%>
%> @brief   用于模型约束检测算法.
%> 
%>
%> @details 运行模型检测算法，算法可通过文件 \a setting.m.设置。 
%>
%> @param[out]  ModalFlag       模型检测输出有效标志位 [ true = 模型约束启动, false = 模型约束无效]    
%> @param[out]  T               模型检测结果输出 
%> @param[in]   u               传感器数据     
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ModalFlag T]=Modal_identify(u)


% 导入全局变量
global simdata;

% 声明内存空间
ModalFlag=zeros(1,length(u));

% 运行模型约束数据 
switch simdata.detector_type
    
    case 'GLRT'
        T=Mo_GLRT(u);    
    
    case 'MV'
        T=Mo_MV(u);
        
    case 'MAG'
        T=Mo_MAG(u);
        
    case 'ARE'
        T=Mo_ARE(u);

    case 'GPS'
        T=Mo_GPS(u);

    case 'LAS'
        T=Mo_LASER(u);
        
    case 'CAMERA'
        T=Mo_CAMERA(u);

    otherwise
        T=Mo_GLRT(u);
end

% 检测模型计算数据，根据计算缓冲大小要求确定输出约束变量
W=simdata.Window_size;
for k=1:length(T)
    if T(k)<simdata.gamma
        ModalFlag(k:k+W-1)=ones(1,W); 
    end    
end

% 模型统计值输出，可用户自定义
T=[max(T)*ones(1,floor(W/2)) T max(T)*ones(1,floor(W/2))];
end
