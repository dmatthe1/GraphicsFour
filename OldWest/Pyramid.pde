class Pyramid {
  PImage img;
  int size;
  PVector color1;
  PVector color2;
  
  Pyramid(int t, PVector col1, PVector col2){
    size = t;
    color1 = col1;
    color2 = col2;
  }
  
  void display() { 
  
    stroke(0);
  
    // this pyramid has 4 sides, each drawn as a separate triangle
    // each side has 3 vertices, making up a triangle shape
    // the parameter " t " determines the size of the pyramid
    beginShape(TRIANGLES);
  
    fill(color1.x, color1.y, color1.z); // Note that each polygon can have its own color.
    vertex(-size, -size, -size);
    vertex( size, -size, -size);
    vertex( 0, 0, size);
  
    fill(color2.x, color2.y, color2.z);
    vertex( size, -size, -size);
    vertex( size, size, -size);
    vertex( 0, 0, size);
  
    fill(color1.x, color1.y, color1.z);
    vertex( size, size, -size);
    vertex(-size, size, -size);
    vertex( 0, 0, size);
  
    fill(color2.x, color2.y, color2.z);
    vertex(-size, size, -size);
    vertex(-size, -size, -size);
    vertex( 0, 0, size);
  
    endShape();
  }
}
