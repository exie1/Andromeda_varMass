class planet {
  PVector position;
  PVector nextposition;
  PVector velocity;
  PVector velocityhalf;
  PVector nextvelocity;
  PVector acceleration;
  PVector oldacceleration;
  PVector nextaccel;
  PVector oldposition;
  float mass;
  float timestep;
  
  planet() {
    position = new PVector(900,400);
    oldposition = new PVector(position.x, position.y);
    velocity = new PVector(3,0);
    acceleration = new PVector(0,0);
    timestep = 1;
    mass = 25;
  }
  
  void update(){
    velocity = velocity.add(acceleration);
    position = position.add(velocity);

  }
  
  void applyforce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration = f;
  }
  
  void display() {
    stroke (0);
    fill(255);
    ellipse(position.x,position.y,10,10);
  }
  
  
  
  
}
