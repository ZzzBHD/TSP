function Swap_update = Wolf_update(H_Wolf,O_Wolf,n)
    SearchAgent_new=O_Wolf;
    Swap=zeros(n-1,2);
    for i=1:n-1
        if SearchAgent_new == H_Wolf
            break;
        end
        for j=1:n
            if H_Wolf(1,j)==SearchAgent_new(1,i)
                temp=SearchAgent_new(1,j);
                SearchAgent_new(1,j)=SearchAgent_new(1,i);
                SearchAgent_new(1,i)=temp;
                Swap(i,1)=i;
                Swap(i,2)=j;
                break;
            end
        end
    end
    Swap(all(Swap==0,2),:)=[];
    c=ceil(rand()*(size(Swap,1)-1));
    %Ëæ»ú½»»»Ë³Ðò
%     c_rand=randperm(size(Swap,1),c);
    Swap_update=Swap(1:c,:);
end