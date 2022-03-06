class planet {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float g;
  
  planet(float m, float x, float y, float xs, float ys) {
    mass = m;
    g = 1; //the lower the better (for clumping)
    position = new PVector(x,y);
    velocity = new PVector(xs,ys);
    acceleration = new PVector(0,0); 
  }
  
  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(255);
    fill(0);
    ellipse(position.x,position.y,10,10);
  }
  
  
  PVector attract(planet p) {
    PVector force = PVector.sub(p.position,position);
    float d = force.mag();
    if (d <= 10) {
      force.mult(0);
    }
    
    force.normalize();
    float strength = (g*mass*p.mass)/(d*d);
    
    force.mult(strength);
    return force;
    
    
  }
  
  void apply(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
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
  
  
