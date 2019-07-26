% This function initialize the first population of search agents
% 初始化包括构建Distance矩阵和为所有SearchAgent随机分配初始路径
function [Positions,Distances]=initialization(SearchAgents_no,city_num,city_x,city_y,Rand_num)
    n=city_num;%城市数
    Distances=zeros(n,n);
    for i=1:n
        for j=1:n
            DIST=sqrt((city_x(j,1)-city_x(i,1))^2+(city_y(j,1)-city_y(i,1))^2);
            Distances(i,j)=DIST;
        end
    end
    Positions=zeros(SearchAgents_no,n);
    for i=1:SearchAgents_no
        for j=1:n
            Positions(i,j)=j;
        end
        for k=1:Rand_num
            r1=unidrnd(n);
            r2=unidrnd(n);
            temp=Positions(i,r1);
            Positions(i,r1)=Positions(i,r2);
            Positions(i,r2)=temp;
        end
    end
end