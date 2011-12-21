classdef Herd < handle
    % a herd of animals (extends handle so everything is pass by reference I think)
    properties
        maxPop % how many animals in the herd
        animal % a vector of animals
        
        averageDirection
        averageVelocity
    end
    
    % public methods
    methods 
        % constructor
        function this = Herd(maxPop)
            this.maxPop = maxPop;
            this.animal = Animal;
            for i=1:maxPop
                this.animal(i) = Animal;
            end
            
            this.findAverageDirection;
            this.findAverageVelocity;
        end
        
        % plot the herds location
        function plot(this)
            x = zeros(1, this.maxPop);
            y = zeros(1, this.maxPop);
            for i=1:this.maxPop
                x(i) = this.animal(i).x;
                y(i) = this.animal(i).y;
            end
            scatter(x,y);
        end
        
        function update(this)
            for i=1:this.maxPop
                this.animal(i).update
            end
        end
        
    end
    
    % private helper methods
    methods (Access = private)
        
        function findAverageDirection(this)
            % loop through all the animals, calculate the average
            sum = 0;
            for i=1:this.maxPop
                sum = sum + this.animal(i).direction;
            end
            this.averageDirection = sum/this.maxPop;
        end
        
        function findAverageVelocity(this)
            sum = 0;
            for i=1:this.maxPop
                sum = sum + this.animal(i).velocity;
            end
            this.averageVelocity = sum/this.maxPop;
        end
    end
end