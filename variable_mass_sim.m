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
subplot(2,4,1)
title('Absolute Energy over time')
xlabel('Time (Gyr)')
ylabel('Energy')
%axis([0,100,-0.1,0.1])
kegraph = animatedline('Color',[0 .7 .7]);
%axis([0,100,-9,9])
gpegraph = animatedline('Color',[.7 0 0]);
totalgraph = animatedline();
subplot(2,4,2)
title('Absolute Semi-Latus Rectum')
xlabel('Time (Gyr)')
ek2 = animatedline('Color',[0 0.7 0]);
subplot(2,4,3)
title('Analytic solution - SLR')
xlabel('Time (Gyr)')
pplot = animatedline();
subplot(2,4,4)
title('Eccentricity direction')
edir = animatedline('Color',[0 0 0.9]);
xlabel('Time (Gyr)')
subplot(2,4,5) %~~~~~total energy relative error
title('%\Delta Specific Angular Momentum over Time')
xlabel('Time (Gyr)')
ylabel('%\Delta Angular Momentum')
energyerror = animatedline('Color',[0.9 0 0]);
subplot(2,4,6)
title('Eccentricity Magnitude')
xlabel('Time (Gyr)')
angerrorg = animatedline('Color',[0.9 0 0]);
subplot(2,4,7)
title('Analytic solution - Eccentricity')
xlabel('Time (Gyr)')
eplot = animatedline();

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
        mass1 = mass1*(1+0.1*timestep/0.0276);
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
    
    if dist > distchecksmall
        distchecksmall = dist;
        positioncheck1 = position2-position1;
    end
    if dist < distcheckbig
        distcheckbig = dist;
        positioncheck2 = position2-position1;
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
    addpoints(edir,timer,eangle)
    ree = norm(evec);
    angular = (angmom-angular0)/angular0;
    specificenergy = ((norm(velocity2-velocity1)^2)/2) - (mu/dist);
    rcomp = r(1) + j*r(2);
    rang = angle(rcomp);
    if abs(rang) <= 0.0005
        a = (distcheckbig + norm(r))/2;
        cent = (positioncheck2 + r)/2;
        e = norm(cent)/a;
        p = a*(1-e*e);
    end
    panal = norm(h)^2/mu;
    eanal = sqrt(1+2*((specificenergy*norm(h)^2)/(mu^2)));
    %pd = (p-p0)/p0;
    %ed = (e-e0)/e0;
    
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    %       Relative to body 1
 %   addpoints(h2,position2(1)-position1(1),position2(2)-position1(2),position2(3))
 %   addpoints(h1,0,0,position1(3))
    
    addpoints(kegraph,timer,ke)
    addpoints(gpegraph,timer,gpe)
    addpoints(totalgraph,timer,ke+gpe)
    addpoints(energyerror,timer,angmom)
    
    
    
    %Plot eccentricity and semilatus rectum
    %addpoints(ek2,timer,p)
    addpoints(angerrorg,timer,e)
    addpoints(ek2,timer,p)
    %addpoints(pplot, timer, panal)
    %addpoints(eplot,timer,eanal)
   
    
    
    i1 = norm(angmom*mass2);
    i2 = -i1 + (g*mass1*mass2)*sqrt(mass2/(2*abs(specificenergy)));
    eanalytic = sqrt(1-(i2/(i1+i2))^2);
    panalytic = (i1)^2/(mass2*g*mass1*mass2);
    addpoints(pplot, timer, panalytic)
    addpoints(eplot,timer,eanalytic)
    
    
    timer = timer + timestep;
    drawnow limitrate

end

a = (distchecksmall + distcheckbig)/2;
Relorbitalperiod = 2*pi*sqrt((a^3)/(g*(mass1+mass2)))
