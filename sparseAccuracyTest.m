function [answer smallAnswer eigenvalue] = sparseAccuracyTest

    % Uncomment for sparse hermetian
    A = csvread('data/hermetiansparse20.csv');
    
    % Uncomment for sparse
    %A = csvread('data/sparse20.csv');
    
    % Uncomment for rank 50 2000x2000 hermetian randn matrix
%     A = makeSingularMatrix(2000,25);
%     A = (A + A')/2;
%     rank(A)
%     
    
    % Uncomment for full rank 2000x2000 randn matrix
%     A = randn(2000,2000);
%     A = (A + A') / 2;
%     rank(A)
%     
    
    Omega = rand(length(A), length(A));

    % test on 2000x2000 sparse matrix
    
    % find largest and second largest eigenvalues
    temp = eig(A);
    [garbage index1] = max(abs(temp));
    eigenvalue = temp(index1);
    temp(index1) = 0;
    [garbage index2] = max(abs(temp));
    secondEigenvalue = temp(index2);
    
    timeMatrix = zeros(1,40);
    answer = zeros(1,40);
    errors = zeros(1,40);
    counter = 1; 
    for i = 50:50:2000
        i
        timestart = tic;
        answer(counter) = modifiedSinglePass(A,Omega(:,1:i));
        timeMatrix(counter) = toc(timestart);
        errors(counter) = findError(answer(counter), eigenvalue);
        counter = counter + 1;
    end

    smallAnswer = zeros(1,50);
    smallTimeMatrix = zeros(1,50);
    smallErrors = zeros(1,50);
    for i=1:50
        i
        timestart = tic;
        smallAnswer(i) = modifiedSinglePass(A,Omega(:,1:i));
        smallTimeMatrix(i) = toc(timestart);
        smallErrors(i) = findError(smallAnswer(i), eigenvalue);
    end
    
    % plot estimation 50 : 2000 samples
    figure
    scatter(50:50:2000, answer)
    hold on
    plot(50:50:2000, ones(1,length(answer))*eigenvalue, 'k')
    %plot(50:50:2000, ones(1,length(answer))*secondEigenvalue, 'g--')
    hold off
    title ('Estimation of dominant eigenvalue (50 to 2000 samples)')
    xlabel('number of samples')
    ylabel('estimated eigenvalue')
    %legend('estimated answer','actual answer', 'second largest eigenvalue')
    legend('estimated answer','actual answer')
    
    % plot estimation 1 : 50 samples
    figure
    scatter(1:50, smallAnswer)
    hold on
    plot(1:50, ones(1,length(smallAnswer))*eigenvalue, 'k')
    %plot(1:50, ones(1,length(smallAnswer))*secondEigenvalue, 'g--')
    hold off
    title ('Estimation of dominant eigenvalue (1 to 50 samples)')
    xlabel('number of samples')
    ylabel('estimated eigenvalue')
    %legend('estimated answer','actual answer', 'second largest eigenvalue')
    legend('estimated answer','actual answer')
    
    % plot error 50 : 2000 samples
    figure
    plot(50:50:2000, errors)
    title ('error of estimated dominant eigenvalue (50 to 2000 samples)')
    xlabel('number of samples')
    ylabel('percent error')
    
    % plot error 1 : 50 samples
    figure
    plot(1:50, smallErrors)
    title ('error of estimated dominant eigenvalue (1 to 50 samples)')
    xlabel('number of samples')
    ylabel('percent error')

    figure
    plot(50:50:2000, timeMatrix)
    title ('Time elapsed as a function of sample size (50 to 2000 samples')
    xlabel('number of samples')
    ylabel('time')
    
    figure
    plot(1:50, smallTimeMatrix)
    title('Time elapsed as a function of sample size (1 to 50 samples)')
    xlabel('number of samples')
    ylabel('time')
end

% takes a random matrix Omega as input
function domVal = modifiedSinglePass(A, Omega)
    Y = A*Omega;
    [Q garbage] = qr(Y);
    B = (Q'*Y)/(Q'*Omega);
    temp = eig(B);
    [absDomVal index] = max(abs(temp));
    domVal = temp(index);
end

function error = findError(approx, actual)
    error = (approx - actual) / actual;
end