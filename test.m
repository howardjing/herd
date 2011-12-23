
timeMatrix = zeros(3,20);
answerMatrix = zeros(3,20);
counter = 1;
for i=100:100:2000 
    
    A = randn(i,i);
    timeStart = tic;
    disp('svd')
    temp = svd(A);
    answerMatrix(1,counter) = temp(1);
    timeMatrix(1,counter) = toc(timeStart);
   
    timeStart = tic;
    disp('power')
    answerMatrix(2,counter) = powerIteration(A);
    timeMatrix(2,counter) = toc(timeStart);
    
    timeStart = tic;
    disp('singlepass')
    answerMatrix(3,counter) = singlePass(A,i);
    timeMatrix(3,counter) = toc(timeStart);
    
    counter = counter + 1;
end

plot(1:20, timeMatrix(1,:))
hold on
plot(1:20, timeMatrix(2,:), 'r')
hold on
plot(1:20, timeMatrix(3,:), 'g')