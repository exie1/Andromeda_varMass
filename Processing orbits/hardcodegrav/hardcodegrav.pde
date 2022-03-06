planet p1;
planet p2;

void setup() {
  size(500,500);
  p1 = new planet(70,50,250,0,0.0005);
  p2 = new planet(70,450,250,-0,-0.0005);
}

float x;
float y;

void draw() {
  background(21,54,85);
  p1.ascend();
  p1.display();
  p2.ascend();
  p2.display();
  p1.bot();
  p2.bot();
  
}
