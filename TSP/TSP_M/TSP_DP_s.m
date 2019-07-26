maxn=31;%允许最大城市数
INF=1061109567;
route=zeros(1,maxn);
v=zeros(maxn,maxn);
flag=zeros(maxn,maxn);
[num,x,y]=textread('chn31.txt','%n%n%n','delimiter', ' ');
n=size(num,1);%城市数
s=0;
for i=1:n
    for j=1:n
        DIST=sqrt((x(j,1)-x(i,1))^2+(y(j,1)-y(i,1))^2);
        v(i,j)=DIST;
        s=s+v(i,j);
        flag(i,j)=1;
    end
end
for i=1:n
    for j=1:n
        if flag(i,j)~=1
            v(i,j)=s;
        end
    end
end
min_dis=s*n;
[ ans_dis,min_route ] = TSP_F_s(maxn,n,v,route,min_dis);
