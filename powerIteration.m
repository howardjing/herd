function [domVal domVec counter] = powerIteration(A, numTimes)
    appx = ones(length(A),1);
    counter = 0;
    epsilon = 0.001;
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