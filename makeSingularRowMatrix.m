function [A] = makeSingularRowMatrix(dimension, rank) 
    A = zeros(dimension,dimension);
    for i=1:rank
        A(:,i) = randn(1,dimension);
    end
    for i=(rank+1):dimension
        vec1 = A(:,randi([1 rank],1,1));
        vec2 = A(:,randi([1 rank],1,1));
        A(:,i) = randn(1,1)*vec1 + randn(1,1)*vec2;
    end
end
