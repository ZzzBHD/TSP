function [ Head_score,Head_pos ] = Wolf_Walk( Positions,fobj,S_num,dim,T,h,stepa)
    Search_pos=zeros(S_num,dim);
    Search_score=zeros(1,S_num); %change this to -inf for maximization problems
    Search_score(find(Search_score==0))=inf; %#ok<FNDSB>
    S_k=1;
    Search_walk_pos=zeros(1,dim);
    Search_walk_dir=0;
    Head_score=inf;
    for i=1:size(Positions,1) %选取头狼和探狼，
        % Calculate objective function for each search agent
        fitness=fobj(Positions(i,:));
        % Update Head
        if fitness<Head_score 
            Head_score=fitness; % Update alpha
            Head_pos=Positions(i,:);
        end
        if fitness>Head_score && fitness<max(Search_score)
            if S_k~=S_num+1
                Search_pos(S_k,:)=Positions(i,:);
                S_k=S_k+1;
                Search_score(1,S_k)=fitness;
            else
                [max_n,max_p]=max(Search_score); %#ok<ASGLU>
                Search_score(1,max_p)=fitness;
                Search_pos(max_p,:)=Positions(i,:);                
            end
        end
    end
    lead_re1=0;
    lead_re2=0;
    for i=1:T
        if lead_re1==1
            break;
        end
        for j=1:S_num
            Search_walk_score=inf;
            if lead_re2==1
                lead_re1=1;
                lead_re2=0;
                break;
            end
            for k=1:h
                Search_walk_pos(1,:)=Search_pos(j,:)+sin(2*pi*k/h)*stepa;
                fitness_walk=fobj(Search_walk_pos(1,:));
                if fitness_walk<Head_score
                    Head_score=fitness_walk;
                    Head_pos=Search_walk_pos(1,:);
                    lead_re2=1;
                    break;
                end
                if fitness_walk<Search_walk_score
                    Search_walk_score=fitness_walk;
                    Search_walk_dir=k;
                end
            end
            %更新探狼游走后的位置
            Search_pos(j,:)=Search_pos(j,:)+sin(2*pi*Search_walk_dir/h)*stepa;
        end
    end
end

