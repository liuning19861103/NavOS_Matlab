%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion T = Mo_MAG(u)
%
%> @brief 加速度计幅值计算
%>
%> @param[out]  T          数据统计值输出 
%> @param[in]   u          输入传感器数据        
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=Mo_MAG(u)

    global simdata;
    g=simdata.g;
    sigma2_a=simdata.sigma_a^2;
    W=simdata.Window_size;
    
    N=length(u);
    T=zeros(1,N-W+1);
    
    
    for k=1:N-W+1
        for l=k:k+W-1
            T(k)=T(k)+(norm(u(1:3,l))-g)^2;    
        end    
    end
    
    T=T./(sigma2_a*W);
    end