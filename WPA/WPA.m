function [Best_score,Best_pos,Convergence_curve]=WPA(N,Max_iter,lb,ub,dim,fobj,S,w) 

alpha=4;%探狼比例因子
beta=6;%更新比例因子
T=20;%最大游走次数
h=10;%游走方向数量
stepa=(ub-lb)/S;%游走步长
stepb=2*stepa;
stepc=0.5*stepa;
Score=zeros(N,1);
% Head_pos=zeros(1,dim);
% Head_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents
Positions=initialization(N,dim,ub,lb);

Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter

% Main loop
while l<Max_iter
    R=round(rand(1)*(N/beta-N/(2*beta))+N/(2*beta));
    S_num=round(rand()*(N/alpha)+(N/(alpha+1)));%探狼    
    [ Head_score,Head_pos ] = Wolf_Walk( Positions,fobj,S_num,dim,T,h,stepa);
    M_num=N-S_num-1;
    [ Call_Position,Call_Head_pos,Call_Head_score ] = Wolf_Call( Positions,Head_score,Head_pos,M_num,dim,w,stepb,fobj,ub,lb);
    [ Siege_Position ] = Wolf_Siege( Call_Position,Call_Head_pos,stepc,fobj );
    for i=1:N
        Score(i,1)=fobj(Siege_Position(i,:));
    end
    [ Wolf_Score,Wolf_num ]=sort(Score,'descend');
    for i=1:R
        Siege_Position(Wolf_num(i),:)=rand(1,dim).*(ub-lb)+lb;
    end
    l=l+1;
    Convergence_curve(l)=Call_Head_score;
    Positions=Siege_Position;
end
Best_score=Call_Head_score;
Best_pos=Call_Head_pos;