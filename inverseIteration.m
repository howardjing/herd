function [domVal domVec counter] = inverseIteration(A, numTimes)

    epsilon = 0.001;
    counter = 0;
    rcondition = rcond(A);
    
    % call power iteration until convergence is around 1
    % then approximation is good enough to start inverse iteration
    [appxVal appxVec error] = power(A,1,numTimes);
    while (counter < numTimes) && (error > epsilon) && (rcondition > 1e-15)
        temp = appxVec;
        C = (A-appxVal*eye(size(A)))\appxVec;
        appxVec =  C/norm(C,2);
        appxVal = appxVec'*A*appxVec;
        error = norm(temp-appxVec,2);
        counter = counter+1;
        
        rcondition = rcond(A-appxVal*eye(size(A)));
    end
    domVec = appxVec;
    domVal = appxVal;
    
end

function [domVal domVec error counter] = power(A, tolerance, numTimes)
    appx = ones(length(A),1);
    counter = 0;
    epsilon = tolerance;
    error = 100;
    while (counter < numTimes) && (error > epsilon)
        temp = appx;
        appx = A*appx / norm(A*appx, 2);
        error = norm(temp-appx,2);
        counter = counter + 1;
    end
    domVec = appx;
    domVal = appx'*A*appx;
end