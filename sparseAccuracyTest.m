function [answer eigenvalue] = sparseAccuracyTest

    A = csvread('data/hermetiansparse20.csv');
    Omega = rand(length(A), length(A));

    % test on 2000x2000 sparse matrix
    eigenvalue = max(eig(A))
    timeMatrix = zeros(1,40);
    answer = zeros(1,40);
    counter = 1;
    for i = 50:50:2000
        i
        timestart = tic;
        answer(counter) = modifiedSinglePass(A,Omega(:,1:i));
        timeMatrix(counter) = toc(timestart);
        counter = counter + 1;
    end

    plot(50:50:2000, answer)
    hold on
    plot(50:50:2000, ones(1,length(answer))*eigenvalue, 'k')
    hold off
    
    figure
    plot(50:50:2000, timeMatrix)
end

% takes a random matrix Omega as input
function domVal = modifiedSinglePass(A, Omega)
    Y = A*Omega;
    [Q garbage] = qr(Y);
    B = (Q'*Y)/(Q'*Omega);
    domVal = powerIteration(B, 10000);
end