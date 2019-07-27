function [ Call_Position,New_Head_pos,New_Head_score ] = Wolf_Call( Positions,Head_score,Head_pos,M_num,dim,w,stepb,fobj,ub,lb)
    Wolf_num=randperm(size(Positions,1),M_num);
    D_near=((sum(ub-lb))*dim)/(dim*w);%这里仅考虑每一维的取值范围都相同的情况
    flag=0;
    for j=1:M_num
        if flag==1
            j=1;
            flag=0;            
        end
        i=Wolf_num(1,j);
        Distance=inf;
        while Distance > D_near
            Positions(i,:)=Positions(i,:)+stepb * (Head_pos-Positions(i,:))/ABS_Wolf(Head_pos,Positions(i,:));
            Distance=ABS_Wolf(Head_pos,Positions(i,:));
            fitness=fobj(Positions(i,:));
            if fitness < Head_score
               Head_pos=Positions(i,:);
               Head_score=fitness;
               flag=1;
               Wolf_num=randperm(size(Positions,1),M_num);
               break;
            end
        end
    end
    Call_Position=Positions;
    New_Head_score=Head_score;
    New_Head_pos=Head_pos;
end

