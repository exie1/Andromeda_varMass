class planet {
  float x;
  float y;
  float xspeed;
  float xacc;
  float yspeed;
  float yacc;
  float balld;
  float ballx;
  float bally;
  float d;
  float ballxacc;
  float xjer;
  float bxjer;
  float count;
  
  planet(float balld, float ballx, float bally, float ballxacc, float bxjer) {
    x=ballx;
    y=bally;
    xspeed=0;
    xacc=ballxacc;
    yspeed=0;
    yacc=0;
    xjer=bxjer;
    d=balld;
  }
  
  void ascend() {
    y = y - yspeed;
    yspeed = yspeed - yacc;
    x = x - xspeed;
    xspeed = xspeed - xacc;
    xacc = xacc + xjer;
    count = count+0.1;
  }
  
  void display() {
    stroke (0);
    fill(255);
    ellipse(x,y,d,d);
  }
  
  void bot() {
    if (y > height) {
      y=0;
      yspeed=0;
    }
    if (x == width/2){
      x = width/2;
      xspeed=0;
      xacc = 0;
    }
    if (count>13.58){
      x=width/2;
      xspeed=0;
      xacc=0;
      xjer=0;
    }
  }
}
