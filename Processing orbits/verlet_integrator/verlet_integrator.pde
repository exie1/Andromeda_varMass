planet p;
sun s;
float x;
float y;
float kpc;
float kpcy;
float count;

void setup(){
  size(2000,1200);
  p = new planet();
  s = new sun();
  frameRate(100);
}

void draw(){
  PVector force = s.attract(p);
  p.apply(force);
  
  p.update();
  // PRINT TOTAL ENERGY
  //float ke = p.kinetic(s);
  //s.gpe(ke);





  // CREATE AXES
  line(80,0,80,1120);
  line(80,1120,2000,1120);
  p.display();
  s.display();
  
  //STOPPING TIME COUNT FROM BUGGING
  stroke(204);
  fill(204);
  rect(1650,50,190,100);
  stroke(204);
  fill(204);
  rect(1800,50,190,100);
  
  //TIME COUNT
  fill(255);
  stroke(0);
  textAlign(LEFT);
  textSize(30);  
  text(count*0.0000000000001 + " ",width-300,100);
  text("Gyr", width-120,100);
  

  //CREATING GRID
  count=count+0.0000000001;
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
