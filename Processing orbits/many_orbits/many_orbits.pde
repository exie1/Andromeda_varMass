
planet[] p = new planet[50];
rand[] r = new rand[1000];
sun s;


void setup() {
  size(2000,1400);
  for (int i = 0; i < p.length; i++) {
    p[i] = new planet(random(3, 20), random(width/2), random(height/2), random(0,0), random(0,4)); 
    r[i] = new rand(random(0.1,3),random(width),random(height));
  }
  
  s = new sun();
}

void draw() {
  for (int i = 0; i < p.length; i++) {
    PVector force = s.attract(p[i]);
    p[i].applyforce(force);
  
    p[i].update();
    p[i].display();
    //r[i].display(random(50,200)); //drops framerates a ton
  
  }
  s.display();


}
