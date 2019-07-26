maxn=20;%允许最大城市数
INF=1061109567;
dp=zeros(2^maxn,maxn);
dis=zeros(maxn,maxn);
path=zeros(2^maxn,maxn);
node=zeros(maxn,3);
[num,x,y]=textread('chn31.txt','%n%n%n','delimiter', ' ');
n=size(num,1);%城市数
for i=1:n
    for j=1:n
        DIST=sqrt((x(j,1)-x(i,1))^2+(y(j,1)-y(i,1))^2);
        dis(i,j)=DIST;
    end
end
for i=1:2^n
    for j=1:n
        dp(i,j)=INF;
    end
end
disans=TSP_F(n,dp,dis)