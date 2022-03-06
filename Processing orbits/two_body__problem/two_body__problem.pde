sun s;
planet p;
float count;
float kpc;
float kpcy;
float x;
float y;

void setup() {
  size(2000,1200);
  p = new planet();
  s = new sun();
  frameRate(200);
  
}

void draw() {
  PVector force = p.attract(s);
  s.applyforce(force);
  PVector fore = s.attract(p);
  p.applyforce(fore);
  s.update();
  p.update();
  p.display();
  s.display();
  float ke = p.kinetic(s);
  s.gpe(ke);


  //s.tp();
  //p.tp();
  
  
  
  
  
  //CREATING GRID
  
  
  
  kpc = -0.025;
  kpcy = -0.015;
  x = 80;
  while (x<width) {
    line(x, 0, x, 1120);
    x = x + 150;
    stroke(0);
    fill(0);
    textSize(20);
    text(kpc, x-17, 1150);
    kpc = kpc + 0.005;
    if (x == 80+150*5) {
      kpc = 0;
    }
  }
  
  y = 1120;
  while (y>0) {
    line(80, y, 2000, y);
    y = y - 150;
    stroke(0);
    fill(0);
    textSize(20);
    text(kpcy, 10, y);
    kpcy = kpcy + 0.005;
  }
}
