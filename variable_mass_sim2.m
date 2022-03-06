clear all
close all
f1 = figure;
f2 = figure;
% Invariants should be :
% E/K^2 = const.
% Ka = const.
% (K/av)^2
% Generate axes


% Initial conditions

position1 = [0,0,0];
velocity1 = [0,0,0];
accel1 = [0,0,0];
mass1 = 4.1*10^6;
timestep = 0.0001;   % ~~~~~~~~~~~~~~~~~~~~Timestep
timer = 0;

position2 = [0,0,1];
velocity2 = [0,1,0];
accel2 = [0,0,0];
mass2 = 1;

g = 0.00000430091;
looper1 = 0;
distchecksmall = -1;
distcheckbig = 9999999999;

alpha = 100;
rho = 0.1;
eps = 0.1;
cs = 30;
v = 0;
mu = 2;

sigma = 6.9868*10^(-39);
%sigma = 6.524*10^(-29);




figure(f2); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ graphs
subplot(2,2,1)
yyaxis left
%axis([0,100,-0.1,0.1])
kegraph = animatedline('Color',[0 .7 .7]);
yyaxis right
%axis([0,100,-9,9])
gpegraph = animatedline('Color',[.7 0 0]);
totalgraph = animatedline();
subplot(2,2,2)
ek2 = animatedline('Color',[0 0.7 0]);

subplot(2,2,3) %~~~~~total energy relative error
energyerror = animatedline('Color',[0.9 0 0]);
subplot(2,2,4)
angerrorg = animatedline('Color',[0.9 0 0]);




figure(f1); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main plot
subplot(1,2,1);
view(3);
h2 = animatedline('Color',[0.7 0 0]);
h1 = animatedline('Color',[0 .7 .7]);
an = animatedline('Color',[0 .7 .7]);
%pbaspect([1,1,1]);
grid on;

subplot(1,2,2);
h3 = animatedline('Color',[0.7 0 0]);
h4 = animatedline('Color',[0 .7 .7]);
%axis([-3,10,-5,8,])
pbaspect([1,1,1]);
grid on;







% Loop for this long
for k = 1:200000
    
    
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
       
        
       % macc = alpha*4*pi*(g^2)*(mass1^2)*rho/((cs^2)^(3/2));
        
       % medd = (4*pi*g*mass1*mass2)/(0.1*299792*sigma);
        
        
       % mass1 = mass1 + macc*(1-eps)*timestep;%*timestep????
        mass1 = mass1+0.1*timestep*mass1/0.5523;
        
        
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
    

    addpoints(h2,position2(1),position2(2),position2(3))
    addpoints(h1,position1(1),position1(2),position1(3))
    
    addpoints(h4,position2(1)-position1(1),position2(2)-position1(2),position2(3)-position1(3))
    addpoints(h3,0,0,0)
    
    
    % Energy graphs
    ke = 0.5*mass1*norm(velocity1)^2 + 0.5*mass2*norm(velocity2)^2;
    gpe = -g*mass1*mass2/dist;   
    etot = ke + gpe;
    ek2lol = etot/(mass1^2); %gradient -4*10^(-18)*
    
    
    % Angular momentum
    r = direction;
    velovec = velocity2 - velocity1;
    h = cross(r,velovec);
    angmom = norm(cross(r,velovec));
    evec = (cross(velovec,h)/mu)-(r/norm(r));
    norm(evec);
    lpl = cross((mass2*velovec),(mass2*h))-mass2*g*r/norm(r);
    norm(lpl);
    
    the = acos(dot(r,velocity2-velocity1)/(norm(r)*norm(velocity2-velocity1)));%asin(norm(cross(r,velocity2-velocity1))/(norm(r)*norm(velocity2-velocity1)))
    
    
    
    %       Relative to body 1
 %   addpoints(h2,position2(1)-position1(1),position2(2)-position1(2),position2(3))
 %   addpoints(h1,0,0,position1(3))
    
    addpoints(kegraph,timer,ke)
    addpoints(gpegraph,timer,gpe)
    addpoints(totalgraph,timer,ke+gpe)
    addpoints(energyerror,timer,0)
    
    addpoints(ek2,timer,ek2lol)
    addpoints(angerrorg,timer,the)

  
    drawnow limitrate
   
    if dist > distchecksmall
        distchecksmall = dist;
        positioncheck1 = position2-position1;
    end
    if dist < distcheckbig
        distcheckbig = dist;
        positioncheck2 = position2-position1;
    end

    
    timer = timer + timestep;
    
end

a = (distchecksmall + distcheckbig)/2;
Relorbitalperiod = 2*pi*sqrt((a^3)/(g*(mass1+mass2)))
