function [domLam eigenVec] = rayleigh (A, approx)

iteration = 10000;
criterion = 0.0001;
counter = 0;
error = 100;

while (counter < iteration) && (error > criterion)
    temp = approx;
    rq = (temp'*A*temp)/(temp'*temp);
    
    approx = inv((A-rq*eye(size(A))))*approx...
        /norm(inv((A-rq*eye(size(A))))*approx);
    
    error = norm(temp - approx);
    counter = counter + 1;
end

eigenVec = approx;
domLam = approx'*A*approx; 
end

    
    