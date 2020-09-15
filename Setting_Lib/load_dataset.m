%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% funtion      u = load_dataset( str_path ) 
%
% brief       ���������ļ�. 
%
% details     ���չ涨�ĸ�ʽ����ഫ�������ݣ��ɵ���һ���ļ����룬Ҳ�ɶ���ļ����룬���չ涨�ĵ�λ
%
% param[out]  u    ���������ݾ���. ÿһ�д���һ������ʱ������    
% 
% content �ļ���ʽ����λ˵��
%  NJUST �汾ͨ������
%  ͨ����    ��������   ��λ           ˵��
%  1         Time       ms            ϵͳʱ�䣬һ��������һ��ʱ���
%  2         GX         deg/s         
%  3         GY         deg/s         
%  4         GZ         deg/s         
%  5         AX         m/s^2         
%  6         AY         m/s^2         
%  7         AZ         m/s^2         
%  8         MX         uT or DATA    
%  9         MY         uT or DATA    
%  10        MZ         uT or DATA    
%  11        PN         m             ����λ��   
%  12        PE         m             ����λ��
%  13        PD         m             ����λ��
%  14        PFlag      0 or 1        λ�ö�λ��Ч��־��ÿ��ʱ�������ͳ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [u]=load_dataset(str_path)

global simdata;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%������������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ���ݼ��ٶȼ�Ϊ��ѡ��شš����ǡ����⡢�ɼ���Ϊ����ѡ��
simdata.MAG    = 'off';

simdata.GNSS   = 'off';

simdata.LASER  = 'off';

simdata.CAMERA = 'off';

% ���봫��������
DATA_Sensor=load(str_path);
% �ж����ݳ���
[Row,Col]=size(DATA_Sensor);  
for i=1:1:Row
    if i>1
    simdata.Ts(i)=(DATA_Sensor(i,1)-DATA_Sensor(i-1,1))*0.001;  %ȷ������ʱ�䣬
    end
end

omega_imu     = DATA_Sensor(:,2 : 4)'*pi/180;
f_imu         = DATA_Sensor(:,5 : 7)';

u=[f_imu; omega_imu];

K=8;

% ����ش�����
if (strcmp(simdata.MAG,'on'))
    simdata.MAGCH = K;
    mag_imu       = DATA_Sensor(:,K :K+3)';
    u = [u;mag_imu];
    K=K+3;
end

% ������������
if (strcmp(simdata.GNSS,'on'))
    simdata.GNSSCH = K;
    gps_xyz        = DATA_Sensor(:,K:K+3)';
    gps_Flag       = DATA_Sensor(:,K+4  )';
    u = [u;gps_xyz; gps_Flag];
    K=K+4;
end

% ���뼤���ࣨ����ͷ������̼�����
if (strcmp(simdata.LASER,'on'))
    simdata.LASERCH = K;
    laser_p         = DATA_Sensor(:,K)';
    u = [u;laser_p];
    K=K+1;
end

% ����ɼ����Ӿ���̼�����
if (strcmp(simdata.CAMERA,'on'))
    simdata.CAMERACH = K;
    camera_p         = DATA_Sensor(:,K)';
    u = [u;camera_p];
    K=K+1;
end

end