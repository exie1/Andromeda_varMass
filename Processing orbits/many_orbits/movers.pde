class planet {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  planet(float m, float x, float y, float xs, float ys) {
    mass = m;
    position = new PVector(x,y);
    velocity = new PVector(xs,ys);
    acceleration = new PVector(0,0);

  }
  
  void update(){
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }
  
  void applyforce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void display() {
    stroke (0);
    fill(200);
    ellipse(position.x,position.y,mass,mass);
  }
  
  void tp() {
    if (position.x > width) {
      velocity.x = velocity.x*(-1);
    }
    if (position.x < 0) {
      velocity.x = velocity.x*(-1);
    }
    
    if (position.y < 0) {
      velocity.y = velocity.y*(-1);
    }
    if (position.y > height){
      velocity.y = velocity.y*(-1);
    }
      
  }

}
