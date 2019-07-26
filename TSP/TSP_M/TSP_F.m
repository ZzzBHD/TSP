function [ mans ] = TSP_F(n,dp,dis)
    M=2^n;
    dp(2,1)=0;
    INF=1061109567;
    mans=INF;
    for i=1:M-1
        for j=1:n-1
            if bitand(1,2^n)
                continue;
            end
            if ~bitand(i,1)
                continue;
            end
            for k=0:n-1
                if i && (2^k) %#ok<BDLOG>
                    if (dp(i+1,k+1)+dis(k+1,j+1)) < dp(bitor(2^j,i)+1,j+1)
                        dp(bitor(2^j,i)+1,j+1)=dp(i+1,k+1)+dis(k+1,j+1);
                    end
                    dp(bitor(2^j,i)+1,j+1)=min(dp(bitor(2^j,i)+1,j+1),dp(i+1,k+1)+dis(k+1,j+1));
                end
            end
        end
    end
    for i=0:n-1
       if (dp(M,i+1)+dis(i+1,1))<mans
           mans=dp(M,i+1)+dis(i+1,1);
       end
    end
end

