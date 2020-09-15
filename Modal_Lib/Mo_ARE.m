%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion T = Mo_ARE(u)
%
%> @brief 角速率运动能量检测，角速率拨动幅度 
%>
%> @param[out]  T          数据统计值输出 
%> @param[in]   u          输入传感器数据     
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=Mo_ARE(u)


global simdata;

sigma2_g=simdata.sigma_g^2;
W=simdata.Window_size;

N=length(u);
T=zeros(1,N-W+1);


for k=1:N-W+1
    for l=k:k+W-1
        T(k)=T(k)+norm(u(4:6,l))^2;    
    end    
end

T=T./(sigma2_g*W);
end

