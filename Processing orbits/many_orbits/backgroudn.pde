class rand {
  PVector position;
  float mass;
  float b;
  
  rand(float m, float x, float y) {
    mass = m;
    position = new PVector(x,y);
  }
  
  void display(float b) {
    stroke(b);
    fill(b);
    ellipse(position.x,position.y,mass,mass);
  }
}
