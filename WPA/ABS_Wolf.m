function [ ABS_Distance ] = ABS_Wolf( Position1,Position2 )
    sum=0;
    for i=1:size(Position1,2)
        sum=sum+(Position1(1,i)-Position2(1,i))*(Position1(1,i)-Position2(1,i));
    end
    ABS_Distance=sqrt(sum);
end

