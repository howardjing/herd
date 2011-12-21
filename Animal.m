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
            maxDirection = 1;
            
            this.x = random('unif', lowerBound, upperBound);
            this.y = random('unif', lowerBound, upperBound);
            
            this.repulsionRadius = 0;
            this.neutralRadius = 0;
            this.attractionRadius = 0;
            
            this.direction = random('unif', lowerBound, maxDirection);
            this.velocity = random('unif', lowerBound, maxVelocity);
            
            this.biasedDirection = this.direction;
            this.biasedVelocity = this.velocity;
            
            this.timeStep = 0.1;
        end
        
        % updates the x and y position of the animal
        function update(this)
            this.x = this.x + this.velocity*(cos(this.direction))*this.timeStep;
            this.y = this.y + this.velocity*(sin(this.direction))*this.timeStep;
            
            % this.x = this.x + this.velocity*this.timeStep;
            % this.y = this.y + this.velocity*this.timeStep;
        end
    end
end