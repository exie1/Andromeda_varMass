class sun {
  PVector position;
  float mass;
  float g;
  float o;
  float confirm;
  
  sun() {
    position = new PVector(width/2,height/2);
    mass = 160;
    g = 25; 
    o = 0;
  }
  
  PVector attract(planet p) {
    PVector force = PVector.sub(position,p.position);
    float d = force.mag();
    force.normalize();
    if (d < 20) {
      p.velocity.mult(0);
      if (confirm < 1) {      
        mass = mass + p.mass;
        confirm = confirm + 1;
      }
    }
    float strength = (g*mass*p.mass)/(d*d);
    force.mult(strength);
    return force;
    
    
  }
  
  
  
  void display() {
    stroke (80);
    fill(0);
    ellipse(position.x,position.y,60,60);
  }
}
