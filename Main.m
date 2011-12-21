% an array of 10 ants
ants = Herd(100);
for t=1:100
    ants.plot
    ants.update
    axis equal
    M(t) = getframe;
end

%movie(M,1);