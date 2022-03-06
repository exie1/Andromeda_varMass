
clear all
close all
f1 = figure;


figure(f1); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main plot
h2 = animatedline('Color',[0.7 0 0]);
h1 = animatedline('Color',[0 .7 .7]);
% Generate axes
axis([-0.015,0.015,-0.015,0.015])
pbaspect([1, 1, 1])


% Initial conditions
position1 = [0.01,0,0];
velocity1 = [0,0.02,0];
accel1 = [0,0,0];
mass1 = 10;
timestep = 0.001;   % ~~~~~~~~~~~~~~~~~~~~Timestep
timer = 0;

position2 = [-0.01,0,0];
velocity2 = [0,-0.02,0];
accel2 = [0,0,0];
mass2 = 10;


looper1 = 0;
g = 0.00000430091;


    
% Loop for this long
for k = 1:10/0.001
    % Calculate force 
    
    
    % Integrate for motion
    if looper1 == 0
        dist = sqrt((position1(1) - position2(1))^2 + (position1(2) - position2(2))^2);
        direction = (position2-position1)/dist;
        accel1 = g*mass2*direction/(dist^2);   
        accel2 = -g*mass1*direction/(dist^2); 
        
        velocity1 = velocity1 + accel1*timestep;
        velocity2 = velocity2 + accel2*timestep;
        position1 = position1 + velocity1*timestep;
        position2 = position2 + velocity2*timestep;
        
        position1old = position1;
        position2old = position2;
        velocity1old = velocity1;
        velocity2old = velocity2;
        
        looper1 = looper1 + 1;
    end
    if looper1 > 0
        
        velocityhalf1 = velocity1old + accel1*timestep/2;
        velocityhalf2 = velocity2old + accel2*timestep/2;
       
        position2 = position2old + velocityhalf2*timestep;
        position1 = position1old + velocityhalf1*timestep;
        
        dist = sqrt((position1(1) - position2(1))^2 + (position1(2) - position2(2))^2); 
        direction = (position2-position1)/dist;
        accel1 = g*mass2*direction/(dist^2);   
        accel2 = -g*mass1*direction/(dist^2); 
        
        velocity1 = velocityhalf1 + accel1*timestep/2;      
        velocity2 = velocityhalf2 + accel2*timestep/2;
        
        position1old = position1;
        position2old = position2;
        velocity1old = velocity1;
        velocity2old = velocity2;
    end
    
    addpoints(h2,position2(1),position2(2))
    addpoints(h1,position1(1),position1(2))
    
    
    drawnow limitrate
    
    
end

