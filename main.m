%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% brief: ������ϵ���ͨ�ó���
%
% File Name: main.m
%
% Project Name: NavOS
%
% Author: Liu Ning
%
% Date          Author          Notes
% 20150606      Liu Ning        1��������Ӧ���� 
% 20200709      Liu Ning        1���ṩ�Ͼ�����ѧ
%                               
% CopyRight: ��Ȩ�鱱����Ϣ�Ƽ���ѧ�߶�̬���������������ص�ʵ�������У����ս���Ȩ��ø߶�̬���������������ص�ʵ��������
%            Copyright (c) 2015 Beijing key library of High dynamic navigation technology, ISC License (open source)
% ��������ɷ�����������liuning1898@qq.com��������13810655202
%
% details:
% ����������������Ҫ������ϵͳ���á����ݵ��롢ģ�ͼ�⡢�������ơ������ʾ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ϵͳ��ʼ�������ϵͳ�ڴ�
clear all;
clc;
close all;
%% ����ϵͳ��
addpath('Setting_Lib');         % ϵͳ���� Ŀ¼
addpath('Modal_Lib');           % ģ������ ��Ŀ¼
addpath('Nav_Lib');             % �������� ��Ŀ¼
addpath('quaternion_lib');      % ��Ԫ������ ��Ŀ¼
addpath('Report_Lib');          % �������� ��Ŀ¼
addpath('GNSS_Lib');            % �������� ��Ŀ¼
%% �ƶ������ļ�
fielname='Test6.dat';
%% ����ߵ�����
disp('1.�����������')
u=settings(fielname);  %uΪ����ߵ����ݾ���
%% ����ģ�ͼ�⣬ģ�ͼ���п�����GPS����
disp('2.����ģ�ͼ������')
[zupt T]=Modal_identify(u);
%% ������ϵ�������
disp('3.�����˲�����')
[x_h cov]=Navigation_Alg(u,zupt);
%% �����ʾ 
disp('4.��ʾ���')
view_data;

