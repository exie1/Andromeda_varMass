clear all
close all
f1 = figure;
f2 = figure;
f3 = figure;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ initial conditions ~~~~~~~~~~~~~
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
mu = g*(mass1+mass2);


figure(f1); %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ main plot
subplot(1,2,1);

title('Orbit in absolute frame')
h2 = animatedline('Color',[0.7 0 0]);
h1 = animatedline('Color',[0 .7 .7]);
xlabel('x position (kpc)')
ylabel('y position (kpc)')
zlabel('z position (kpc)')
%axis([-0.15,0.15,-0.15,0.15])
te1 = text(position2(1),position2(2),'0 Gyr');
pbaspect([1,1,1]);
view(3)
grid on;

subplot(1,2,2);
title('Orbit relative to mass 1')
h4 = animatedline('Color',[0.7 0 0]);
h3 = animatedline('Color',[0 .7 .7]);
xlabel('x position (kpc)')
ylabel('y position (kpc)')
zlabel('z position (kpc)')
%axis([-0.15,0.15,-0.15,0.15])
te2 = text(position2(1),position2(2),'0 Gyr');
pbaspect([1,1,1]);
grid on;



figure(f2);

subplot(1,2,1);
title('Absolute energy over time')
xlabel('Time (Gyr)')
ylabel('Absolute Energy')
kegraph = animatedline('Color',[0 .7 .7]);
%axis([0,100,-9,9])
gpegraph = animatedline('Color',[.7 0 0]);
totalgraph = animatedline();

legend('KE','GPE','TE', 'Location', 'southeast');
pbaspect([1,1,1]);
grid on;



subplot(1,2,2);
title('%\Delta Angular momentum over time')
xlabel('Time (Gyr)')
ylabel('%\Delta Angular momentum')
momgraph = animatedline('Color',[0.9 0 0]);
pbaspect([1,1,1]);

grid on;


angular0 = norm(cross(position2-position1,velocity2-velocity1));
ke0 = (0.5*mass2*norm(velocity2-velocity1)^2);
gpe0 = -g*mass2*mass1/norm(position2-position1);
etot0 = (ke0 + gpe0);
spe0 = 0;


p = angular0^2/mu;
e = 0.415;




pericheck = 99;
apocheck = -1;


figure(f3);
subplot(1,3,1)
title('SLR over Time')
xlabel('Time (Gyr)')
ylabel('Semi-Latus Rectum (kpc)')
slrgraph = animatedline('Color',[0.5,0.5,0]);
%title('Analytical sol. - SLR over Time')
%xlabel('Time (Gyr)')
%ylabel('Semi-Latus Rectum (kpc)')
slrgrapha = animatedline('Color',[0,0,0]);
subplot(1,3,2)
title('Eccentricity over Time')
xlabel('Time (Gyr)')
ylabel('Eccentricity')
egraph = animatedline('Color',[0.5,0.5,0]);
%title('Analytical sol. - SLR over Time')
%xlabel('Time (Gyr)')
%ylabel('Semi-Latus Rectum (kpc)')
egrapha = animatedline('Color',[0,0,0]);
subplot(1,3,3)
title('Angle of E.Vector over Time')
xlabel('Time (Gyr)')
ylabel('Angle of Eccentricity Vector (radians)')
anggraph = animatedline('Color',[0,0,0]);



looper = 0;
% Loop for this long
for k = 1:1/timestep
    
    if looper == 0
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
        
        looper = looper + 1;
    end
    if looper > 0
        velocityhalf1 = velocity1old + accel1*timestep/2;
        velocityhalf2 = velocity2old + accel2*timestep/2;
       
        position2 = position2old + velocityhalf2*timestep;
        position1 = position1old + velocityhalf1*timestep;
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        mass1 = mass1*(1-0.001*timestep/0.0276);
        if mass1 <= 0
            accel1 = 0;
            accel2 = 0;
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
    
    mu = g*(mass1+mass2);
   
    addpoints(h2,position2(1),position2(2),position2(3))
    addpoints(h1,position1(1),position1(2),position1(3))
    addpoints(h4,position2(1)-position1(1),position2(2)-position1(2),position2(3)-position1(3))
    addpoints(h3,0,0,0)
    
    if dist > apocheck
        apocheck = dist;
        apocheckvec = position2-position1;
    end
    if dist < pericheck
        pericheck = dist;
        pericheckvec = position2-position1;
    end
    
    
    % Energy graphs
    %ke = ((0.5*mass2*norm(velocity2-velocity1)^2)-ke0)/ke0;
    %gpe = -((-g*mass2*mass1/dist)-gpe0)/gpe0;
    %etot = ((ke + gpe)-etot0)/etot0;
    %angular = (angmom-angular0)/angular0;
    ke = 0.5*mass2*norm(velocity2-velocity1)^2;
    gpe = -g*mass2*mass1/dist;
    etot = ke + gpe;
    angular = norm(cross(position2-position1,velocity2-velocity1));
    h = cross(position2-position1,velocity2-velocity1);
    angerror = (angular-angular0)/angular0;
    
    
    pa = angular^2/mu;
    evec = (cross(velocity2-velocity1,h)/mu)-(direction/norm(direction));
    ea = norm(evec);
    ecomp = evec(1) + j*evec(2);
    eang = angle(ecomp);
    if eang < 0
        eang = eang + 2*pi;
    end
    
    dcomp = direction(1) + j*direction(2);
    dang = angle(dcomp);
    if abs(dang) < 0.0005
        a = (pericheck + norm(direction))/2;
        cent = (pericheckvec + direction)/2;
        e = norm(cent)/a;
        p = a*(1-e*e);
    end
    
    
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    
    %addpoints(kegraph,timer,ke)
    %addpoints(gpegraph,timer,gpe)
    %addpoints(totalgraph,timer,ke+gpe)
    %addpoints(momgraph,timer,angerror)
    %addpoints(slrgrapha,timer,pa)
    %addpoints(slrgraph,timer,p)
    %addpoints(egraph,timer,e)
    %addpoints(egrapha,timer,ea)
    addpoints(anggraph,timer,eang)
    
    
    set(te1, 'Position', [position2(1), position2(2),position2(3)]);
    writing = join(['\leftarrow',num2str(round(timer,2)),'Gyr']);
    set(te1, 'String', writing);
    set(te2, 'Position', [position2(1)-position1(1), position2(2)-position1(2),position2(3)-position1(3)]);
    writing = join(['\leftarrow',num2str(round(timer,2)),'Gyr']);
    set(te2, 'String', writing);
    
    
    
    
    
    
    timer = timer + timestep;
    drawnow limitrate

end









