function [ Siege_Position ] = Wolf_Siege( Positions,Head_pos,stepc,fobj )
    Siege_Position=zeros(size(Positions,1),size(Positions,2));
    for i=1:size(Positions,1)
        r=rand()*2-1;
        Siege_walk_pos=Positions(i,:)+r*stepc*ABS_Wolf(Head_pos,Positions(i,:));
        Siege_walk_score=fobj(Siege_walk_pos);
        if Siege_walk_score < fobj(Positions(i,:))
            Siege_Position(i,:)=Siege_walk_pos;
        else
            Siege_Position(i,:)=Positions(i,:);
        end
    end
end