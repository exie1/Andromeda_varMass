class planet {
  PVector position;
  PVector positionold;
  PVector acceleration;
  PVector velocity;
  float mass;
  float timestep;
  float counter;
  float time;
  float cou;
  float mag;

  planet() {
    position = new PVector(980,120);
    velocity = new PVector(sqrt(5)-1,0);
    positionold = new PVector(980,120); //(997.765,250)
    acceleration = new PVector(0,0);
    mass = 20;
    timestep = 1;
    time = 0;
    count = 0;
    counter = 0;
    cou = 0;
  }
  
  void update() {
    if (cou == 0) {
      // Modified Euler
      velocity.add(acceleration.mult(timestep));
      position.add(velocity.mult(timestep));
      velocity.div(timestep);
      acceleration.mult(0);
      cou = cou + 0;
      
    }
    PVector r = PVector.sub(s.position,position);
    PVector p = velocity.mult(mass);
    PVector cross = r.cross(p);
    mag = cross.mag();
    velocity.div(mass);
    if (cou > 0) {
      // Stormer Verlet
      PVector positiontemp = new PVector(position.x,position.y);
      position = (position.mult(2).sub(positionold)).add(acceleration.mult(timestep*timestep));  
      positionold.set(positiontemp);  
      // Leapfrog
      //velocity = PVector.sub(position, positionold);
      //position = position.add(velocity).add(acceleration.mult(timestep*timestep));
    }
    fill(255,0,0);
    stroke(255,0,0);
    //ellipse(count, height - (velocity.mag()*velocity.mag()*mass*0.5)/2, 2,2);
    ellipse(count, height - (mag*10000/2-98885100/2), 2,2);
    println(mag*10000/2-98885000/2);
    if (count > width) {
      count = 0;
      fill(204);
      stroke(204);
      rect(0,800,2000,400);
    }
    count = count + 1;
    
    
  }

  
  void apply(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration = f;
  }
  
  float kinetic(sun s) {
    float ke = velocity.mag()*velocity.mag()*mass/2;
    return ke;
  }
  
  void display() {
    stroke(0);
    fill(255);
    
    
    // TRYING THE MAKE THE ORBIT SWITCH COLOURS
    if (counter == 0) {
      if (position.x > 980) {
        counter = counter + 1;
      }
    }
    if (counter == 1) {
      if (position.x < 980) {
        counter = counter + 1;
      }
    }
    if (counter == 2) {
      if (position.x > 980) {
        counter = counter + 1;
      }
    }
    if (counter == 3) {
      stroke(255);
      if (position.x < 980) {
        counter = counter + 1;
      }
    }
    if (counter == 4) {
      if (position.x > 980) {
        counter = 0;
      }
      stroke(255);
    }
    
    
    
    if (mousePressed) {
      stroke(255);
    }
    ellipse(position.x,position.y,2,2);
    
    
    
  }
}
    
  
  
