% Grey Wolf Optimizer
function [Alpha_score,Alpha_pos,Convergence_curve]=GWO(SearchAgents_no,Max_iteration,Positions,Distances,n)

% initialize alpha, beta, and delta_pos
Alpha_pos=zeros(1,n);
Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,n);
Beta_score=inf; %change this to -inf for maximization problems

Delta_pos=zeros(1,n);
Delta_score=inf; %change this to -inf for maximization problems

Convergence_curve=zeros(1,Max_iteration);

l=0;% Loop counter

% Main loop
while l<Max_iteration
    for i=1:SearchAgents_no  
        
        % Calculate objective function for each search agent
        fitness=Distance_cal(Distances,Positions(i,:),n);
        
        % Update Alpha, Beta, and Delta
        if fitness<Alpha_score 
            Alpha_score=fitness; % Update alpha
            Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; % Update beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; % Update delta
            Delta_pos=Positions(i,:);
        end
    end
    for i=1:SearchAgents_no
       Swap_Delta=Wolf_update(Delta_pos,Positions(i,:),n);
       Swap_Beta=Wolf_update(Beta_pos,Positions(i,:),n);
       Swap_Alpha=Wolf_update(Alpha_pos,Positions(i,:),n);
       Swap_Three=cat(1,Swap_Delta,Swap_Beta,Swap_Alpha);
       %去重
       Swap_Three=unique(Swap_Three,'rows');
       [p,s]=unique(Swap_Three(:,1),'first');
       %去矛盾，每一个城市仅保留一种SO
       Swap_Unique=zeros(size(s,1),2);
       for k=1:size(s,1)
          Swap_Unique(k,1)=Swap_Three(s(k,1),1);
          Swap_Unique(k,2)=Swap_Three(s(k,1),2);
       end
       
       %去重复后选择唯一交换方式
%        ua1=unique(Swap_Three(:,1));   %找出第一列的惟一值
%        [h,s]=hist(Swap_Three(:,1),ua1); %以这个惟一值做直方图,h是数量，s是相应取值
%        sh1=s(h~=2);           %找出s中不是1的，就是A(:,1)中重复的
%        ind=ismember(Swap_Three(:,1),sh1); %A(:,1)中包含sh1的位置
%        Swap_Three(ind,:)=[];       %这个位置的这一行删除掉
       
       Cache_Wolf=Positions(i,:);
       for k=1:size(Swap_Three,1)
           temp=Cache_Wolf(1,Swap_Three(k,1));
           Cache_Wolf(1,Swap_Three(k,1))=Cache_Wolf(1,Swap_Three(k,2));
           Cache_Wolf(1,Swap_Three(k,2))=temp;
       end
       Positions(i,:)=Cache_Wolf;
    end
     l=l+1;    
     Convergence_curve(l)=Alpha_score;
end



