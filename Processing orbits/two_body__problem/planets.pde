class planet {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float g;
  float timestep;
  float timestepcount;
  PVector angvector;
  float angmag;
  float count;
  float angmag2;
  
  planet() {
    mass = 10;
    count = 0;
    g = 0.00000430091; //0.00000430091 for irl value in kpc*km^2/Msun*s^2
    timestep = 0.1; // T in units = 3.086*10^16 s
    timestepcount = 0;
    position = new PVector(1280,520); //distance between = 600 pixels, sun at (980,520)
    velocity = new PVector(0,5.68); // 1 km/s = 400/(3.08567758*10^16) maybe just input -1?
    acceleration = new PVector(0,0); 
  }
  
  float kinetic(sun s) {
    float ke = velocity.mag()*velocity.mag()*mass/2;
    return ke;
  }
  void update(){
    velocity.add(acceleration.mult(timestep)); 
    position.add(velocity.mult(timestep));
    velocity.div(timestep);
    acceleration.mult(0);
    
    //Calculating and printing angular momentum
    PVector r = PVector.sub(s.position,position);
    PVector p = velocity.mult(mass);
    PVector cross = r.cross(p);
    angmag = cross.mag();
    velocity.div(mass);
    PVector r2 = PVector.sub(position,s.position);
    PVector p2 = s.velocity.mult(s.mass);
    PVector cross2 = r2.cross(p2);
    angmag2 = cross2.mag();
    s.velocity.div(mass);
    PVector angular = cross.add(cross2);
    
    if (timestepcount > width) {
      count = 0;
      fill(204);
      stroke(204);
      rect(0,900,2000,500);
    }
    
    fill(0,255,0);
    stroke(40,200,0);
    ellipse(timestepcount, height - angular.mag()/360,1,1);
    //println(angular.mag());//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Print total angular momentum
    fill(10,0,255);
    stroke(10,0,255);
    ellipse(timestepcount, height - (angular.mag()/60000)*100,1,1);// Display total error 
    //println(angular.mag()/60000 -1);//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Print total error
    
    //STOPPING TIME COUNT FROM BUGGING
    stroke(204);
    fill(204);
    rect(1670,50,180,100);
    //TIME COUNT
    fill(255);
    stroke(0);
    textAlign(LEFT);
    textSize(30);  
    text(timestepcount + " ",width-300,100); //~~~~~~~~~~~~~~~~~~~~~~ Displays time

    stroke(204);
    fill(204);
    rect(1800,50,160,100);
  
    fill(255);
    stroke(0);
    textAlign(LEFT);
    textSize(30);  
    text("Gyr", width-120,100);

  
    
    count = count + 5;
    timestepcount = timestepcount + timestep;
    if (timestepcount > 10) {
      // 10 years yet?
    }

  }
  
  void display() {
    stroke (0);
    fill(255);
    ellipse(position.x,position.y,5,5);
  }
  
  
  
  PVector attract(sun s) {
    PVector force = PVector.sub(p.position,s.position);
    float d = force.mag();
    d = d/30000;
    force.normalize();
    float strength = (g*p.mass*s.mass)/(d*d);
    force.mult(strength);
    return force;
  }
    
  
  
  void applyforce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }

}
