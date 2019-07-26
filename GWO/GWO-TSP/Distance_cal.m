function distance = Distance_cal(Distances,SearchAgent,n)
    distance=0;
    for i=1:n-1
        distance=distance+Distances(SearchAgent(1,i),SearchAgent(1,i+1));
    end
end