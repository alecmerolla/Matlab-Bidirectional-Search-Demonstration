function [ G A p ] = equalBranch(n,b)
% returns graph plot with n vertices and branching factor b

I = b;
ind = 2;
A = zeros(n);

for k = 1:floor((n-ind)/I)
    for m = 1:I
        A(k,ind) = 1; A(ind,k) = 1;
        ind = ind + 1;
    end
    if  n-ind < I && ind ~= n+1
        for J = 1:(n-ind)+1
            A(k+1,ind) = 1; A(ind,k+1) = 1;
            ind = ind + 1;
        end
    end
end

[ G p ] = gplot(A);