%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% brief: ϵͳ���в�������
% File Name: setting.m
% Project Name: NavOS
% Author: Liu Ning
% CopyRight: ��Ȩ�鱱����Ϣ�Ƽ���ѧ�߶�̬���������������ص�ʵ�������У����ս���Ȩ��ø߶�̬���������������ص�ʵ��������
%            Copyright (c) 2020 Beijing key library of High dynamic navigation technology, ISC License (open source)
% Description:
% 
% Content
% Data      Author     Notes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  funtion u=settings() 
%> @brief ����ϵͳ���ú͹ߵ����ݵ���ӿ�����   
%> @param[out]  u �ߵ����ݣ�����x��y��z�����Ǻͽ��ٶȡ��ش���Ϣ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u=settings(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ����ȫ�ֱ�����ȫ���ڵ�ϵͳ�����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global simdata;
% ���㵱��������ֵ
% ���ظ߶� [m]
simdata.altitude=116.3;
% ����γ�� [degrees]
simdata.latitude=58;
% ���ؼ��ٶ�ʸ��ֵ [m/s^2]
simdata.g=gravity(simdata.latitude,simdata.altitude);
% ϵͳ����ʱ�� [s]
simdata.Ts(1)=1/100;
% ������Բ�����Ԫ����
u=load_dataset(filename);
% ��ʼ����� [rad]
simdata.init_yaw    = 0*pi/180;
simdata.init_pitch  = 0*pi/180;
simdata.init_theta  = 0*pi/180;

% ��ʼλ�� (x,y,z)-axis [m] ����������
simdata.init_pos=[0 0 0]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ����ģ�ͼ���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ͨ�������ַ��ɸı䲻ͬ�����ټ��ģʽ 
% GLRT - �����Ȼ����
% MV   - ���ٶȲ���������
% MAG  - ���ٶȲ�����ֵ���
% ARE  - ���ٶȲ���������� 
simdata.detector_type='GLRT';
% ���ٶȼƱ�׼�� [m/s^2]. 
% ���ڽ�������ģ�ͱ�ʶ�����״̬����ʶ���ü��ٶȼ�ͳ����Ϣ��
simdata.sigma_a=5.5; 
% �����Ǳ�׼�� [rad/s]. 
% ���ڽ�������ģ�ͱ�ʶ�����״̬����ʶ���ü��ٶȼ�ͳ����Ϣ��
simdata.sigma_g=0.6*pi/180;     
% ����ģ�ͱ�ʶ����Ļ������ݳ��� [samples] 
simdata.Window_size=10;
% ģ�ͱ�ʶ��ֵ
simdata.gamma=0.1e5; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%�˲��������� 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �˲����ɲ���9ά״̬��12ά��18ά��24ά(λ�á��ٶȡ���̬)״̬�ռ�ģ�͡�״̬�ռ�ģ����Ҳ�ɰ���������ƫ��ͱ������ƫ�

% ״̬������ƫ���ݿ��أ�on�Ǵ򿪣�off�ǹرգ�����δ�ر�ָ�������մ��ַ�ʽ��
simdata.biases='off';

% ״̬��������������ݿ���
simdata.scalefactors='off';

% ���ڹ������������������ͳ�ʼ״̬Э�������Q��R��P�����ã����������������ǶԽǾ������е����ö�����Ϊ��׼�
% �������������ٶȼ����� (x,y,z��������ϵ)[m/s^2].
simdata.sigma_acc =0.051*[1 1 1]';

% �������������������� (x,y,z��������ϵ)[m/s^2][rad/s].
simdata.sigma_gyro =0.08*[1 1 1]'*pi/180; % [rad/s]

% �������������ٶȼ���λ�ȶ������� (x,y,z��������ϵ)[m/s^2].
simdata.acc_bias_driving_noise=0.01*ones(3,1); 

% �������������ٶȼ���λ�ȶ������� (x,y,z��������ϵ)[m/s^2].
simdata.gyro_bias_driving_noise=0.01*pi/180*ones(3,1); 


% �����������ٶȲ���������λ�ò�����������̬��������
simdata.sigma_vel=[0.001 0.001 0.001];      %[m/s] 
simdata.sigma_pos=[0.001 0.001 0.001];      %[m]
simdata.sigma_att=[0.1   0.1   0.1  ];      %[rad]

% �ԽǾ���״̬Э���������� (P).    
simdata.sigma_initial_pos=0.0001*ones(3,1);                % λ�� (x,y,z ��������ϵ) [m]
simdata.sigma_initial_vel=0.0001*ones(3,1);                % �ٶ� (x,y,z ��������ϵ) [m/s]
simdata.sigma_initial_att=(pi/180*[0.01 0.01 0.01]');      % ��̬ (roll,pitch,heading ��������ϵ) [rad]
simdata.sigma_initial_acc_bias=0.3*ones(3,1);              % ���ٶȼ���ƫ (x,y,z ��������ϵ)[m/s^2]
simdata.sigma_initial_gyro_bias=0.5*pi/180*ones(3,1);      % ��������ƫ (x,y,z ��������ϵ) [rad/s]                               
simdata.sigma_initial_acc_scale=0.0001*ones(3,1);          % ���ٶȼƱ������ (x,y,z ��������ϵ)   
simdata.sigma_initial_gyro_scale=0.00001*ones(3,1);        % �����Ǳ������ (x,y,z ��������ϵ)    

% ��ƫ���ȶ���ʱ�䳣�� [seconds]. 
simdata.acc_bias_instability_time_constant_filter=inf;
simdata.gyro_bias_instability_time_constant_filter=inf;



end
