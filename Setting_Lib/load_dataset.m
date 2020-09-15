%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% funtion      u = load_dataset( str_path ) 
%
% brief       导入数据文件. 
%
% details     按照规定的格式导入多传感器数据，可单独一个文件导入，也可多个文件导入，按照规定的单位
%
% param[out]  u    传感器数据矩阵. 每一列代表一个采样时刻数据    
% 
% content 文件格式及单位说明
%  NJUST 版本通道数据
%  通道号    数据名称   单位           说明
%  1         Time       ms            系统时间，一个采样点一个时间戳
%  2         GX         deg/s         
%  3         GY         deg/s         
%  4         GZ         deg/s         
%  5         AX         m/s^2         
%  6         AY         m/s^2         
%  7         AZ         m/s^2         
%  8         MX         uT or DATA    
%  9         MY         uT or DATA    
%  10        MZ         uT or DATA    
%  11        PN         m             北向位置   
%  12        PE         m             东向位置
%  13        PD         m             地向位置
%  14        PFlag      0 or 1        位置定位有效标志，每个时间戳单独统计
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [u]=load_dataset(str_path)

global simdata;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%传感器接入种类设置
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 陀螺加速度计为必选项，地磁、卫星、激光、可见光为附加选项
simdata.MAG    = 'off';

simdata.GNSS   = 'off';

simdata.LASER  = 'off';

simdata.CAMERA = 'off';

% 导入传感器数据
DATA_Sensor=load(str_path);
% 判断数据长度
[Row,Col]=size(DATA_Sensor);  
for i=1:1:Row
    if i>1
    simdata.Ts(i)=(DATA_Sensor(i,1)-DATA_Sensor(i-1,1))*0.001;  %确定积分时间，
    end
end

omega_imu     = DATA_Sensor(:,2 : 4)'*pi/180;
f_imu         = DATA_Sensor(:,5 : 7)';

u=[f_imu; omega_imu];

K=8;

% 接入地磁数据
if (strcmp(simdata.MAG,'on'))
    simdata.MAGCH = K;
    mag_imu       = DATA_Sensor(:,K :K+3)';
    u = [u;mag_imu];
    K=K+3;
end

% 接入卫星数据
if (strcmp(simdata.GNSS,'on'))
    simdata.GNSSCH = K;
    gps_xyz        = DATA_Sensor(:,K:K+3)';
    gps_Flag       = DATA_Sensor(:,K+4  )';
    u = [u;gps_xyz; gps_Flag];
    K=K+4;
end

% 接入激光测距（导引头）或里程计数据
if (strcmp(simdata.LASER,'on'))
    simdata.LASERCH = K;
    laser_p         = DATA_Sensor(:,K)';
    u = [u;laser_p];
    K=K+1;
end

% 接入可见光视觉里程计数据
if (strcmp(simdata.CAMERA,'on'))
    simdata.CAMERACH = K;
    camera_p         = DATA_Sensor(:,K)';
    u = [u;camera_p];
    K=K+1;
end

end