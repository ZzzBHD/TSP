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
       %ȥ��
       Swap_Three=unique(Swap_Three,'rows');
       [p,s]=unique(Swap_Three(:,1),'first');
       %ȥì�ܣ�ÿһ�����н�����һ��SO
       Swap_Unique=zeros(size(s,1),2);
       for k=1:size(s,1)
          Swap_Unique(k,1)=Swap_Three(s(k,1),1);
          Swap_Unique(k,2)=Swap_Three(s(k,1),2);
       end
       
       %ȥ�ظ���ѡ��Ψһ������ʽ
%        ua1=unique(Swap_Three(:,1));   %�ҳ���һ�е�Ωһֵ
%        [h,s]=hist(Swap_Three(:,1),ua1); %�����Ωһֵ��ֱ��ͼ,h��������s����Ӧȡֵ
%        sh1=s(h~=2);           %�ҳ�s�в���1�ģ�����A(:,1)���ظ���
%        ind=ismember(Swap_Three(:,1),sh1); %A(:,1)�а���sh1��λ��
%        Swap_Three(ind,:)=[];       %���λ�õ���һ��ɾ����
       
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



