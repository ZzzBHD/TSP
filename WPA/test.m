A=[1 2 3;1 2 3;4 5 6;5 7 9;4 6 1;0 0 0;1 5 6;0 0 0;8 9 4];
% q=[1 2 3;4 6 1;0 0 0;0 0 0;];
A
[a,b]=unique(A(:,1),'first')
% A(all(A==0,2),:)=[];
% A
% b=randperm(7,2)
% c=A(b,:)
% c=cat(1,A,q,c)
% A=[1 2 3;2 2 6;3 1 9;2 8 3]
% ua1=unique(A(:,1))   %找出第一列的惟一值
% [h s]=hist(A(:,1),ua1) %以这个惟一值做直方图,h是数量，s是相应取值
% sh1=s(h~=1)           %找出s中不是1的，就是A(:,1)中重复的
% ind=ismember(A(:,1),sh1) %A(:,1)中包含sh1的位置
% A(ind,:)=[]       %这个位置的这一行删除掉