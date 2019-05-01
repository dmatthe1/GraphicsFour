float lowerX = -2500;
float upperX = 2500;
float lowerY = -500;
float upperY = -1500;
PVector bodySize = new PVector(10, 10, 40);
PVector wingSize = new PVector(40, 1, bodySize.z);

class Bird {
  PVector loc;
  PVector vel;  
  
  Bird(){
    loc = new PVector(random(lowerX, upperX), random(lowerY, upperY), 0);
    vel = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    vel.normalize();
    vel.mult(4);
  }
  
  void display(){
    fill(255, 0, 0);
    pushMatrix();
    
    //Body
    fill(112,72,60);
    translate(loc.x, loc.y, loc.z);
    rotateY(atan2(vel.x, vel.z));
    box(bodySize.x, bodySize.y, bodySize.z);
    
    //Wings
    fill(157,136,105);
    float hingeAng = map(sin(frameCount * 0.2), -1, 1, -PI / 4, PI / 4);
    pushMatrix();
    rotateZ(hingeAng);
    translate(wingSize.x / 2, 0, 0);
    box(wingSize.x, wingSize.y, wingSize.z);
    popMatrix();
    pushMatrix();
    rotateZ(-hingeAng);
    translate(-wingSize.x / 2, 0, 0);
    box(wingSize.x, wingSize.y, wingSize.z);
    popMatrix();
    
    popMatrix();
  }
  
  void update(){
    loc.add(vel);
    if(loc.x > upperX || loc.x < lowerX || loc.y > lowerY || loc.y < upperY) vel.mult(-1);
  }
}
