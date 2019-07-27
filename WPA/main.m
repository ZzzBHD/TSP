close all
clear
clc

Function_name='F14'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

N=30; % Number of search agents，人工狼数量
k=500; % Maximum numbef of iterations，最大迭代次数
w=500;%距离判定因子
S=1000;%步长因子

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% 
[Best_score,Best_pos,Convergence_curve]=WPA(N,k,lb,ub,dim,fobj,S,w);



