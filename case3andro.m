clear all
close all
f1 = figure;
f2 = figure;

figure(f1); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main plot
subplot(1,2,1);
view(3);
h2 = animatedline('Color',[0.7 0 0]);
h1 = animatedline('Color',[0 .7 .7]);
% Generate axes
%axis([-0.025,0.025,-0.025,0.025,-0.025,0.025])
pbaspect([1, 1, 1])
grid on
subplot(1,2,2);
h3 = animatedline('Color',[0.7 0 0]);
h4 = animatedline('Color',[0 .7 .7]);
pbaspect([1,1,1]);
grid on;

% Initial conditions
g = 0.00000430091;
distchecksmall = -1;
distcheckbig = 9999999999;
looper1 = 0;

v = sqrt(g*10*10/(0.02*20));

position1 = [0.01,0,0];
velocity1 = [0,v,0];
accel1 = [0,0,0];
mass1 = 10;
timestep = 0.001;   % ~~~~~~~~~~~~~~~~~~~~Timestep
timer = 0;

position2 = [-0.01,0,0];
velocity2 = [0,-v,0];
accel2 = [0,0,0];
mass2 = 10;

figure(f2); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ graphs
subplot(2,2,1)
yyaxis left
axis([0,10,-0.1,0.1])
kegraph = animatedline('Color',[0 .7 .7]);
yyaxis right
axis([0,10,-0.1,0.1])
gpegraph = animatedline('Color',[.7 0 0]);
totalgraph = animatedline();
subplot(2,2,2)
angular = animatedline('Color',[0 0.7 0]);

subplot(2,2,3) %~~~~~total energy relative error
energyerror = animatedline('Color',[0.9 0 0]);
subplot(2,2,4)
angerrorg = animatedline('Color',[0.9 0 0]);







% Loop for this long
for k = 1:100/0.001
    % Calculate force 
    
    % Integrate for motion
    
    
    
    
    
    if looper1 == 0
        direction = (position2-position1);
        dist = norm(direction);
        accel1 = g*mass2*direction/(dist^3);   
        accel2 = -g*mass1*direction/(dist^3); 
        
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
        
        direction = (position2-position1);
        dist = norm(direction);
        accel1 = g*mass2*direction/(dist^3);   
        accel2 = -g*mass1*direction/(dist^3); 
        
        velocity1 = velocityhalf1 + accel1*timestep/2;      
        velocity2 = velocityhalf2 + accel2*timestep/2;
        
        position1old = position1;
        position2old = position2;
        velocity1old = velocity1;
        velocity2old = velocity2;
    end
    
    
    
    
    
    
    
    
    
    
    % Energy graphs
    ke = 0.5*mass1*norm(velocity1)^2 + 0.5*mass2*norm(velocity2)^2;
    gpe = -g*mass1*mass2/dist;
    engerror = abs(-0.01750455-(ke+gpe))/(0.01750455);
    % Angular momentum
    r = direction;
    angmom = norm(cross(r,velocity2 - velocity1));
    angerror = norm(abs(0.0008-angmom)/0.0008);
    
    % Sketch in the points
    timer = timer + timestep;

    
    addpoints(h2,position2(1),position2(2),position2(3))
    addpoints(h1,position1(1),position1(2),position1(3))
    addpoints(h4,position2(1)-position1(1),position2(2)-position1(2),position2(3)-position1(3))
    addpoints(h3,0,0,0)
    %       Relative to body 1
 %   addpoints(h2,position2(1)-position1(1),position2(2)-position1(2),position2(3))
 %   addpoints(h1,0,0,position1(3))
    
    addpoints(kegraph,timer,ke)
    addpoints(gpegraph,timer,gpe)
    addpoints(totalgraph,timer,ke+gpe)
    addpoints(energyerror,timer,engerror)
    
    addpoints(angular,timer,angmom)
    addpoints(angerrorg,timer,angerror)

    drawnow limitrate
    
    
    % Find semi-major axis
    if dist > distchecksmall
        distchecksmall = dist;
        positioncheck1 = position2 - position1;
    end
    if dist < distcheckbig
        distcheckbig = dist;
        positioncheck2 = position2 - position1;
    end
    
    
   
    if mass2 > 0
        mass1 = mass1 + 0.001
        mass2 = mass2 -0.001
    end
    if mass2 <= 0
        mass2 = 0;
    end
end

a = (distchecksmall + distcheckbig)/2;
cent = (positioncheck1 + positioncheck2)/2;
e = norm(cent/a);
Eccentricity = e
Semilatusrectum = a*(1-e*e)
Semimajoraxis = a
Semiminoraxis = a*sqrt(1-e*e)
Relorbitalperiod = 2*pi*sqrt((a^3)/(g*(mass1+mass2)))



