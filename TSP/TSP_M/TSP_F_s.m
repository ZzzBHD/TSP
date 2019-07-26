function [ ans_dis,min_route ] = TSP_F_s(maxn,n,v,route,min_dis)
%     njie=1;
%     for i=1:n-1
%         njie=njie*(n-i);
%     end
    njie=2^n*n;%迭代次数，这里有些小问题
    swap=zeros(1,maxn);
    min_route=zeros(1,maxn);
    while njie>=0
       njie=njie-1; 
       njie_c=njie;
       for i=1:n-1
           swap(1,i)=mod(njie_c,(n-i));
           njie_c=njie_c-swap(1,i);
           njie=njie_c/(n-i);
       end
       for i=1:n-1
           route(1,i)=i;
       end
       route(1,n)=route(1,1);
       for i=1:n-1
           temp=route(1,i);
           route(1,i)=route(1,i+swap(1,i));
           route(1,i+swap(1,i))=temp;
       end
       route(1,n)=route(1,1);
       
       dis=0;
       for j=1:n-1
           dis=dis+v(route(1,j),route(1,j+1));
       end
       if(dis<min_dis)
           min_dis=dis;
           ans_dis=min_dis;
           for k=1:n
               min_route(1,k)=route(1,k);
           end
       end
    end
end