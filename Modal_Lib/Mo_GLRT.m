%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  funtion T = Mo_GLRT(u)
%
%> @brief 陀螺加速度计运动检测的最大似然估计方法
%>
%> @param[out]  T          数据统计值输出 
%> @param[in]   u          输入传感器数据       
%>
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=Mo_GLRT(u)

    global simdata;
    
    g=simdata.g;
    sigma2_a=simdata.sigma_a^2;
    sigma2_g=simdata.sigma_g^2;
    W=simdata.Window_size;
    
    
    N=length(u);
    T=zeros(1,N-W+1);
    
    for k=1:N-W+1
       
        ya_m=mean(u(1:3,k:k+W-1),2);
        
        for l=k:k+W-1
            tmp=u(1:3,l)-g*ya_m/norm(ya_m);
            T(k)=T(k)+u(4:6,l)'*u(4:6,l)/sigma2_g+tmp'*tmp/sigma2_a;    
        end    
    end
    
    T=T./W;
    
    end