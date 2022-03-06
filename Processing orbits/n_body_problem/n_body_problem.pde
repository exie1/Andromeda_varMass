planet[] p = new planet[500]; //100 is good

void setup() {
  size(1800,1200);
  for (int i = 0; i < p.length; i++) {
    p[i] = new planet(random(10,40),random(width),random(height),random(-0,0),random(-0,0));
  }
}

void draw() {
  background(255);
  for (int i = 0; i < p.length; i++) {
    for (int j = 0; j < p.length; j++) {
      if (i != j) {
        PVector force = p[j].attract(p[i]);
        p[j].apply(force);
      }
    }
    p[i].update();
    p[i].display();
    // IDEA spawn in an extremely heavy object.
  }
}
