function [domLam eigenVec counter] = rayleigh(A, numTimes)

    epsilon = 0.001;
    counter = 0;
    rcondition = rcond(A);
    
    % call power iteration until convergence is around 1 
    % then the approximation is good enough to start rayleigh iteration
    
    [domLam approx error] = power(A,1,numTimes);
    while (counter < numTimes) && (error > epsilon) && (rcondition > 1e-15)
        temp = approx;
        rq = (temp'*A*temp)/(temp'*temp);
        C = (A-rq*eye(size(A)))\approx;
        approx = C/norm(C,2);
        error = norm(temp - approx,2);
        counter = counter + 1;
        
        rcondition = rcond(A-rq*eye(size(A)));
    end

    eigenVec = approx;
    domLam = approx'*A*approx; 

end

function [domLam eigenVec error counter] = power(A,tolerance, numTimes)
    appx = ones(length(A),1);
    counter = 0;
    epsilon = tolerance;
    error = 100;
    while (counter < numTimes) && (error > epsilon)
        temp = appx;
        appx = A*appx/ norm(A*appx,2);
        error = norm(temp-appx,2);
        counter = counter + 1;
    end
    eigenVec = appx;
    domLam = appx'*A*appx;
end

    

    
    