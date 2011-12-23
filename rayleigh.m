function [domLam eigenVec] = rayleigh (A)
    approx = ones(length(A),1);
    counter = 0;
    epsilon = 0.0001;
    error = 100;

    while (counter < 10000) && (error > epsilon)
        temp = approx;
        rq = (temp'*A*temp)/(temp'*temp);

        approx = inv((A-rq*eye(size(A))))*approx...
            /norm(inv((A-rq*eye(size(A))))*approx);

        error = norm(temp - approx,2);
        counter = counter + 1;
    end

    eigenVec = approx;
    domLam = approx'*A*approx; 

end

    
    