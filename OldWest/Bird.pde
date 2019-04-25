PVector bodySize = new PVector(10, 10, 40);
PVector wingSize = new PVector(40, 1, bodySize.z);

class Bird {
  
  PVector loc, vel;  
  
  Bird(){
    loc = new PVector(random(-width / 2, width / 2), random(-height / 2, height / 2), random(-height / 2, height / 2));
    vel = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    vel.normalize();
    vel.mult(3);
  }
  
  void display(){
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    rotateY(atan2(vel.x, vel.z));
    box(bodySize.x, bodySize.y, bodySize.z);
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
    if(loc.x < -width / 2) loc.x += width;
    if(loc.y < -height / 2) loc.y += height;
    if(loc.z < -height / 2) loc.z += height;
    if(loc.x > width / 2) loc.x -= width;
    if(loc.y > height / 2) loc.y -= height;
    if(loc.z > height / 2) loc.z -= height;

  }
  
}
