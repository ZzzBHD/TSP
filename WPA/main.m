close all
clear
clc

Function_name='F14'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

N=30; % Number of search agents���˹�������
k=500; % Maximum numbef of iterations������������
w=500;%�����ж�����
S=1000;%��������

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% 
[Best_score,Best_pos,Convergence_curve]=WPA(N,k,lb,ub,dim,fobj,S,w);



