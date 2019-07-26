close all
clear
clc

SearchAgents_no=20; % Number of search agents

Max_iteration=500; % Maximum numbef of iterations

Rand_num=40;%初始化随机打乱次数

[num,x,y]=textread('in.txt','%n%n%n','delimiter', ' ');
n=size(num,1);%城市数
[Positions,Distances]=initialization(SearchAgents_no,n,x,y,Rand_num);

[Best_score,Best_pos,GWO_cg_curve]=GWO(SearchAgents_no,Max_iteration,Positions,Distances,n);

axis([0 Max_iteration 100 300]);
plot(GWO_cg_curve,'Color','r')