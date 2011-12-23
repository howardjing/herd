function [domVal domVec] = powerIteration(A, appx)

    counter = 0;
    epsilon = 0.001;
    error = 100;
    while (counter < 10000) && (error > epsilon)
        temp = appx;
        appx = A*appx / norm(A*appx, 2);
        error = norm(temp-appx,2);
        counter = counter + 1;
    end
    domVec = appx;
    domVal = appx'*A*appx;
    counter
    error
end