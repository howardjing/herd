classdef Animal < handle
    % viscek equations?
    % an animal is a part of a herd
    properties
        x  % x position
        y  % y position
        
        % how far away an animal is able to see
        repulsionRadius  
        neutralRadius
        attractionRadius
        
        direction  % which direction the animal is facing
        velocity % what velocity the animal is currently moving at
        
        % in absense of neighbors
        biasedDirection
        biasedVelocity
        
        % the timestep
        timeStep
    end
    
    methods
        function this = Animal
            % setting up limits
            lowerBound = 0;
            upperBound = 10;
            maxVelocity = 2;
            maxDirection = 2*pi;
            
            this.x = random('unif', lowerBound, upperBound);
            this.y = random('unif', lowerBound, upperBound);
            
            this.repulsionRadius = 0;
            this.neutralRadius = 0;
            this.attractionRadius = 10;
            
            this.direction = random('unif', lowerBound, maxDirection);
            this.velocity = random('unif', lowerBound, maxVelocity);
            
            this.biasedDirection = this.direction;
            this.biasedVelocity = this.velocity;
            
            this.timeStep = 0.2;
        end
        
        
        % updates the x and y position of the animal
        % without paying attention to neighbors
        function updateRandom(this)
            this.x = this.x + this.velocity*(cos(this.direction))*this.timeStep;
            this.y = this.y + this.velocity*(sin(this.direction))*this.timeStep;
        end
        
        % updates paying attention to neighbors
        function update(this, potentialNeighbors)
            neighbors = this.findNeighbors(potentialNeighbors);
            this.findNewDirectionAndVelocity(neighbors)
            % not sure what cos and sine adds yet
            this.x = this.x + this.velocity*(cos(this.direction))*this.timeStep;
            this.y = this.y + this.velocity*(sin(this.direction))*this.timeStep;
        end
    end
    
    methods (Access = private)
        
        function neighbors = findNeighbors(this, potentialNeighbors)
            neighbors = this;
            % if the distance between the two points is near enough
            for i=1:length(potentialNeighbors)
                if this ~= potentialNeighbors(i)
                    sum = (this.x - potentialNeighbors(i).x)^2;
                    sum = sum + (this.y - potentialNeighbors(i).y)^2;
                    if sqrt(sum) <= this.attractionRadius
                        neighbors(i) = potentialNeighbors(i);
                    end
                end
            end
        end
        
        function findNewDirectionAndVelocity(this, neighbors)
            directionSum = 0;
            velocitySum = 0;
            
            % if only neighbor is itself
            if length(neighbors) == 1
                this.direction = this.biasedDirection;
                this.velocity = this.biasedVelocity;
            else
                % otherwise take average of negihbors
                for i=1:length(neighbors)
                    directionSum = directionSum + neighbors(i).direction;
                    velocitySum = velocitySum + neighbors(i).velocity;
                end
                this.direction = directionSum/length(neighbors);
                this.velocity = velocitySum/length(neighbors);
            end
            
            % add random perturbation
            this.direction = this.direction + random('unif',0,0.05);
            this.velocity = this.velocity + random('unif',0,0.2);
            
        end
    end
end