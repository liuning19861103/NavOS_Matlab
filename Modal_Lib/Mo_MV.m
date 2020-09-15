%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion T = Mo_MV(u)
%
%> @brief 加速度计滑动方差计算 
%>
%> @param[out]  T          数据统计值输出 
%> @param[in]   u          输入传感器数据       
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=Mo_MV(u)

    global simdata;
    
    sigma2_a=simdata.sigma_a^2;
    W=simdata.Window_size;
    
    N=length(u);
    T=zeros(1,N-W+1);
    
    
    
    for k=1:N-W+1
        
        ya_m=mean(u(1:3,k:k+W-1),2);
        
        for l=k:k+W-1
            tmp=u(1:3,l)-ya_m;
            T(k)=T(k)+tmp'*tmp;    
        end    
    end
    
    T=T./(sigma2_a*W);
    end