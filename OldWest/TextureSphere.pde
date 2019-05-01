class TextureSphere {
  int n;
  float r;
  PImage img;
  
  TextureSphere(float radius, int numSegments, PImage texture){
    n = numSegments;
    r = radius;
    img = texture;
  }
  
  void display(){
    noStroke();
      beginShape(QUADS);
      textureMode(NORMAL);
      texture(img);
      float uStep = TWO_PI / n;
      float vStep = PI/n;
      for(float u = 0; u <TWO_PI-uStep; u+= uStep){
        for(float v = -PI/2; v <= PI/2-vStep; v += vStep){
          vertex(xpos(u, v), ypos(u, v), zpos(v), umap(u), vmap(v));
          vertex(xpos(u, v+vStep), ypos(u, v+vStep), zpos(v + vStep), umap(u), vmap(v+ vStep));
          vertex(xpos(u+uStep, v+vStep), ypos(u+uStep, v+vStep), zpos(v + vStep), umap(u+uStep), vmap(v+vStep));
          vertex(xpos(u+uStep, v), ypos(u+uStep, v), zpos(v), umap(u+uStep), vmap(v));
        }
      }
      endShape();
  }
  
  float xpos(float u, float v){
    return r * sin(u) * cos(v); 
  }
  
  float ypos(float u, float v){
    return r * cos(u) * cos(v);
  }
  
  float zpos(float v){
   return r * sin(v);
  }
  
  float umap(float u){
    return map(u, 0, TWO_PI, 0, 1); 
  }
  float vmap(float v){
    return map(v, -PI/2, PI/2, 0, 1);
  }
}
