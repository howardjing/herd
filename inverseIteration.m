function [domVal domVec] = inverseIteration(A)

    counter = 0;
    epsilon = 0.001;
    numTimes = 10000;
    % call power iteration until convergence is around 0.1
    [appxVal appxVec error] = power(A,0.1);
    while (counter < numTimes) && (error > epsilon)
        temp = appxVec;
        C = (A-appxVal*eye(size(A)))\appxVec;
        appxVec =  C/norm(C,2);
        appxVal = appxVec'*A*appxVec;
        error = norm(temp-appxVec,2);
        counter = counter+1;
    end
    domVec = appxVec;
    domVal = appxVal;
    
end

function [domVal domVec error] = power(A, tolerance)
    appx = ones(length(A),1);
    counter = 0;
    numTimes = 10000;
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