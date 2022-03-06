class sun {
  PVector position;
  float mass;
  float g;
  
  sun() {
    position = new PVector(980,520);
    mass = 200;
    g = 10;
  }
  
  PVector attract(planet p) {
    PVector force = PVector.sub(position,p.position);
    float d = force.mag();
    force.normalize();
    float strength = (g*mass*p.mass)/(d*d);
    //println(strength*d);
    
    force.mult(strength);
    return force;
  }
  
  void gpe(float ke) {
    PVector force = PVector.sub(position,p.position);
    float d = force.mag();
    float gp = (g*mass*p.mass)/(d);
    float total = ke - gp;    
    //println(gp);
    //println(ke);
    println(total);
  }
    
  
  void display() {
    stroke(0);
    fill(255);
    ellipse(position.x,position.y,30,30);
  }
}
