class Bird {
  PVector position = new PVector(random(width), random(height), random(height));
  PVector direction = new PVector(random(-10, 10), random(-10, 10), random(-10, 10));
 
  void render() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(10);
    popMatrix();
  }
}
