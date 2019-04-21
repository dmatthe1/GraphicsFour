float speed = 6;

class Tumbleweed {
  //location
  float x;
  float y;
  float z;

  //speed
  float xS;
  float yS;
  float zS;

  float upperL;
  float lowerL;

  PShape model; 
  PImage img;
  
  //previous location
  float pz;
  
  //color
  int c;


  Tumbleweed(float upper, float lower, PShape model, PImage image) {
    upperL = upper;
    lowerL = lower;
    
    reset();

    img = image; 
    
    pz = z;
    this.model = model;
    
    model.setTexture(img);
  }

  void reset() {
    x = random(lowerL, upperL);
    y = random(lowerL, upperL);
    z = random(lowerL, upperL);
    
    xS = random(-5, 5);
    yS = random(-5, 5);
    zS = random(-5, 5);
  }

  void update() {
    //tick movement
    x += xS;
    y += yS;
    z += zS;
    
    //respawn
    if (x > upperL || x < lowerL || y > upperL || y < lowerL) {
      reset();
      
      pz = z;
    }    
  }
  
  void show() {
    pushMatrix();
    translate(x, y, z);
    shape(model);
    popMatrix(); 
  }
}
