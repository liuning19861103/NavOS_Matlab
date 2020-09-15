%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% brief: 惯性组合导航通用程序
%
% File Name: main.m
%
% Project Name: NavOS
%
% Author: Liu Ning
%
% Date          Author          Notes
% 20150606      Liu Ning        1、创建对应工程 
% 20200709      Liu Ning        1、提供南京理工大学
%                               
% CopyRight: 版权归北京信息科技大学高动态导航技术北京市重点实验室所有，最终解释权归该高动态导航技术北京市重点实验室所有
%            Copyright (c) 2015 Beijing key library of High dynamic navigation technology, ISC License (open source)
% 技术问题可发送问题至：liuning1898@qq.com，刘宁，13810655202
%
% details:
% 程序运行主程序，主要包括：系统设置、数据导入、模型检测、导航估计、结果显示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 系统初始化，清除系统内存
clear all;
clc;
close all;
%% 增加系统库
addpath('Setting_Lib');         % 系统设置 目录
addpath('Modal_Lib');           % 模型数据 库目录
addpath('Nav_Lib');             % 导航数据 库目录
addpath('quaternion_lib');      % 四元数计算 库目录
addpath('Report_Lib');          % 报告生成 库目录
addpath('GNSS_Lib');            % 报告生成 库目录
%% 制定数据文件
fielname='Test6.dat';
%% 导入惯导数据
disp('1.导入测试数据')
u=settings(fielname);  %u为输出惯导数据矩阵，
%% 运行模型检测，模型检测中可增加GPS数据
disp('2.运行模型检测数据')
[zupt T]=Modal_identify(u);
%% 运行组合导航程序
disp('3.运行滤波程序')
[x_h cov]=Navigation_Alg(u,zupt);
%% 结果显示 
disp('4.显示结果')
view_data;

