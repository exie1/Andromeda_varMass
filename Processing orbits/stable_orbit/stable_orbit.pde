planet p;
sun s;

void setup() {
  size(1800,1200);
  p = new planet();
  s = new sun();
  frameRate(200);
}

void draw() {
  
  
  PVector force = s.attract(p);
  p.applyforce(force); 
  p.update();
  println(sqrt(10*160*25/force.mag()));
  p.display();
  s.display();
}
