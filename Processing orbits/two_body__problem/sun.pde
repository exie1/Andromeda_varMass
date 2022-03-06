class sun {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float g;
  float timestep;
  float timestepcount;
  
  sun() { 
    mass = 10;
    g = 0.00000430091;
    timestep = 0.1;
    timestepcount = 0;
    position = new PVector(680,520);
    velocity = new PVector(0,-5.68);
    acceleration = new PVector(0,0);
    
  }
  void update() {
    velocity.add(acceleration.mult(timestep));//
    position.add(velocity.mult(timestep));
    velocity.div(timestep);
    acceleration.mult(0);
    //mass = mass + 0.5
    timestepcount += timestep;
    
  }
  void display() {
    stroke (0);
    fill(255);
    ellipse(position.x,position.y,5,5);
  }
  
  void gpe(float ke) {
    PVector force = PVector.sub(position,p.position);
    float d = force.mag();
    float ke2 = velocity.mag()*velocity.mag()*mass/2;
    float gp = (g*mass*p.mass)/(d);
    float total = ke + ke2 - gp;   
    //println(gp);
    //println(ke);
    //println(total); //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Print total energy
    fill(255,0,0);
    stroke(255,0,0);
    ellipse(timestepcount,height-total/80,1,1);
  }
  
  PVector attract(planet p) {
    PVector force = PVector.sub(s.position,p.position);
    float d = force.mag();
    d = d/30000;  
    force.normalize();
    float strength = (g*s.mass*p.mass)/(d*d);
    force.mult(strength);
    return force;

  }
  
  
  
  
  void applyforce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  


      
}
