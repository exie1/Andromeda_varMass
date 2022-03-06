class sun {
  PVector position;
  float mass;
  float g;
  
  sun() {
    position = new PVector(900,600);
    mass = 160;
    g = 10;
  }
  
  PVector attract(planet p) {
    //mass = mass + 0.5;
    PVector force = PVector.sub(position,p.position);
    float d = force.mag();
    force.normalize();
    float strength = (g*mass*p.mass)/(d*d);
    force.mult(strength);
    return force;
    
    
  }
  
  
  
  void display() {
    stroke (0);
    fill(255);
    ellipse(position.x,position.y,10,10);
  }
}
