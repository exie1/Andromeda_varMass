clear all
close all
f1 = figure;
f2 = figure;

figure(f1); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main plot
subplot(1,2,1);
view(3);
plot(0,0,".")
h2 = animatedline('Color',[0.7 0 0]);
h1 = animatedline('Color',[0 .7 .7]);
% Generate axes
axis([-1.2,1.2,-1.2,1.2,-1.2,1.2])
pbaspect([1, 1, 1])
grid on 


% Initial conditions

position1 = [1,0,0];
velocity1 = [0,1,0];
accel1 = [0,0,0];
mass1 = 10;
timestep = 0.001;   % ~~~~~~~~~~~~~~~~~~~~Timestep
timer = 0;

position2 = [0,0,0];
velocity2 = [0,0,0];
accel2 = [0,0,0];
mass2 = 10^6;

g = 0.00000430091;
distchecksmall = -1;
distcheckbig = 9999999999;
looper1 = 0;

figure(f2); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ graphs
subplot(2,2,1)
yyaxis left
kegraph = animatedline('Color',[0 .7 .7]);
yyaxis right
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
    
    
    
    
    
    
    
    
    % Verlet; x = 2x - x_old + 2at
    
    
    % Energy graphs
    ke = 0.5*mass1*norm(velocity1)^2 + 0.5*mass2*norm(velocity2)^2;
    gpe = -g*mass1*mass2/dist;
    engerror = abs(-38.0091-(ke+gpe))/(38.0091);
    % Angular momentum
    r = direction;
    p = velocity1*mass1;
    angmom = norm(cross(r,velocity2-velocity1));
    angerror = abs(1-angmom)/1;
    
    % Sketch in the points
    timer = timer + timestep;
    
    
    %addpoints(h2,position2(1),position2(2),position2(3))
    %addpoints(h1,position1(1),position1(2),position1(3))
    
    addpoints(h2,position2(1)-position1(1),position2(2)-position1(2),position2(3)-position1(3))
    addpoints(h1,0,0,0)
    
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
        positioncheck1 = position1;
    end
    if dist < distcheckbig
        distcheckbig = dist;
        positioncheck2 = position1;
    end
    
    
   mass1 = mass1+100;
    
    
end

a = (distchecksmall + distcheckbig)/2;
cent = (positioncheck1 + positioncheck2)/2;
e = norm(cent/a);
Eccentricity = e
Semilatusrectum = a*(1-e*e)
Semimajoraxis = a
Semiminoraxis = a*sqrt(1-e*e)
Relorbitalperiod = 2*pi*sqrt((a^3)/(g*(mass1+mass2)))

figure(f1);
subplot(1,2,2); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Analytic solution
b = Semiminoraxis; % vertical radius
x0=cent(1); % x0,y0 ellipse centre coordinates
y0=cent(2);
t=-pi:0.01:pi;
x=x0+a*cos(t);
y=y0+b*sin(t);

plot(x,y)
axis([-1.2,1.2,-1.2,1.2])
pbaspect([1, 1, 1])
