% an array of 10 ants
ants = Herd(30);
for t=1:1000
    ants.plot
    ants.update
    axis equal
    M(t) = getframe;
end

%movie(M,1);