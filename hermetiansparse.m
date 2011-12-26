
timeMatrix = zeros(5,20);
answerMatrix = zeros(5,20);
counterMatrix = zeros(5,20);
numTimes = 5000;
counter = 1;

eigenValues = zeros(2,20);
for i=100:100:2000 
    disp('Working on')
    i
    
   
    % Generate a random hermitian matrix
    % A = randn(i,i);
    % A = (A + A')/2;
    
    % import matrix
    name = 'hermetiansparse';
    number = int2str(counter);
    ext = '.csv';
    filepath = ['data/' name number ext];
    A = csvread(filepath);

    % find rank
    rank(A)
    
    % find condition
    cond(A)
    
    % find the dominant, and second most dominant eigenvalue
    temp = eig(A);
    eigenValues(1,counter) = temp(length(temp));
    eigenValues(2,counter) = temp(length(temp)-1);
    
    % Matlab's eig function
    timeStart = tic;
    disp('eig')
    answerMatrix(1,counter) = max(eig(A));
    timeMatrix(1,counter) = toc(timeStart);
   
    % PowerIteration
    timeStart = tic;
    disp('power')
    [answerMatrix(2,counter) garbage counterMatrix(2,counter)] = powerIteration(A,numTimes);
    timeMatrix(2,counter) = toc(timeStart);
    
    % InverseIteration
    timeStart = tic;
    disp('inverse')
    [answerMatrix(3,counter) garbage counterMatrix(3,counter)] = inverseIteration(A,numTimes);
    timeMatrix(3,counter) = toc(timeStart);
    
    % Rayleigh
    timeStart = tic;
    disp('rayleigh')
    [answerMatrix(4,counter) garbage counterMatrix(4,counter)] = rayleigh(A,numTimes);
    timeMatrix(4,counter) = toc(timeStart);
    
    % SinglePass
    timeStart = tic;
    disp('singlepass')
    answerMatrix(5,counter) = singlePass(A,i);
    counterMatrix(5,counter) = 1;
    timeMatrix(5,counter) = toc(timeStart);
    
    counter = counter + 1;
end


% Graphing time and number of iterations
semilogy(100:100:2000, timeMatrix(1,:))
hold on
semilogy(100:100:2000, timeMatrix(2,:), 'r')
hold on
semilogy(100:100:2000, timeMatrix(3,:), 'g')
hold on
semilogy(100:100:2000, timeMatrix(4,:), 'm')
hold on
semilogy(100:100:2000, timeMatrix(5,:), 'k')
title ('semilogy Time Elapsed till Convergence')
xlabel('Matrix Size x by x')
ylabel('Time')
legend('Built-in Matlab Eigenvalue Solver','Power Iteration','Inverse Iteration','Rayleigh','Single Pass')

% Graphing time and number of iterations
figure
plot(100:100:2000, timeMatrix(1,:))
hold on
plot(100:100:2000, timeMatrix(2,:), 'r')
hold on
plot(100:100:2000, timeMatrix(3,:), 'g')
hold on
plot(100:100:2000, timeMatrix(4,:), 'm')
hold on
plot(100:100:2000, timeMatrix(5,:), 'k')
title ('Time Elapsed till Convergence')
xlabel('Matrix Size x by x')
ylabel('Time')
legend('Built-in Matlab Eigenvalue Solver','Power Iteration','Inverse Iteration','Rayleigh','Single Pass')


figure
plot(100:100:2000, eigenValues)
title('eigenvalues of the matrix')
ylabel('eigenvalue')
xlabel('Matrix Size x by x')
legend('largest eigenvalue', 'second largest eigenvalue')


