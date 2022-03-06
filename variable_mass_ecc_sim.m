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
timestep = 0.00001;   % ~~~~~~~~~~~~~~~~~~~~Timestep
timer = 0;

position2 = [0.1,0,0];
velocity2 = [0,10,0];
accel2 = [0,0,0];
mass2 = 100;

g = 0.00000430091;
looper1 = 0;
distchecksmall = -1;
distcheckbig = 9999999999;

alpha = 100;
rho = 0.1;
eps = 0.1;
cs = 30;
v = 0;
mu = g*(mass1+mass2);
sigma = 6.9868*10^(-39);
%sigma = 6.524*10^(-29);


dist0 = norm(position2 - position1);

angular0 = norm(cross(position2-position1,velocity2-velocity1));
spe0 = ((norm(velocity2-velocity1)^2)/2) - (mu/dist0);

p0 = norm(angular0)^2/mu;
%e0 = sqrt(1+2*((spe0*norm(angular0)^2)/(mu^2)));

i10 = norm(angular0*mass2);
i20 = -i10 + (g*mass1*mass2)*sqrt(mass2/(2*abs(spe0)));
e0 = sqrt(1-(i20/(i10+i20))^2);


p = p0
e = 0.4309




figure(f1); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main plot
subplot(1,2,1);
view(3);
title('Orbit in absolute frame')
h2 = animatedline('Color',[0.7 0 0]);
h1 = animatedline('Color',[0 .7 .7]);
an = animatedline('Color',[0 .7 .7]);
%pbaspect([1,1,1]);
grid on;

subplot(1,2,2);
title('Orbit relative to central body')
h3 = animatedline('Color',[0.7 0 0]);
h4 = animatedline('Color',[0 .7 .7]);
%axis([-3,10,-5,8,])
pbaspect([1,1,1]);
grid on;





figure(f2); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ graphs

title('Eccentricity direction')
edir = animatedline('Color',[0 0 0.9]);
xlabel('Time (Gyr)')

% Loop for this long
for k = 1:10/timestep
    
    
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
       
        
        macc = alpha*4*pi*(g^2)*(mass1^2)*rho/((cs^2)^(3/2));
        
        medd = (4*pi*g*mass1*mass2)/(0.1*299792*sigma);
        
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       % mass1 = mass1 + macc*(1-eps)*timestep;%*timestep????
       % mass1 = mass1*(1-0.002*timestep/0.0276);
        if mass1 <= 0
            mass1 = 0
        end
        
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
    %ke = ((0.5*mass2*norm(velocity2-velocity1)^2)-ke0)/ke0;
    %gpe = -((-g*mass2*mass1/dist)-gpe0)/gpe0;
    %etot = ((ke + gpe)-etot0)/etot0;
    ke = 0.5*mass2*norm(velocity2-velocity1)^2;
    gpe = -g*mass2*mass1/dist;
    etot = ke + gpe;
    
    
    ek2lol = etot/(mass1^2); %gradient -4*10^(-18)*
    
    mu = g*(mass1+mass2);
    
    % Eccentricity and semilatus rectum~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    r = direction;
    velovec = velocity2 - velocity1;
    h = cross(r,velovec);
    angmom = norm(cross(r,velovec));
    evec = (cross(velovec,h)/mu)-(r/norm(r));
    ecomp = evec(1)+j*evec(2);
    eangle = angle(ecomp);
    if eangle < 0
        eangle = eangle + 2*pi;
    end
    
    ree = norm(evec);
    angular = (angmom-angular0)/angular0;
   
    %addpoints(energyerror,timer,angular)
    addpoints(edir,timer,eangle)
    
    
  
   
    
    timer = timer + timestep;
    drawnow limitrate

end
