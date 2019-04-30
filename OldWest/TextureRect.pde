class TextureRect {
 PImage img;
 float w;
 float h;
 
   TextureRect(PImage i, float wid, float hei){
     img = i;
     w = wid;
     h = hei;
   }
 
   void display(){
     textureMode(NORMAL);
     beginShape(QUADS);
       texture(img);
       vertex(-w, -h, 0, 0, 0);
       vertex(w, -h, 0, 1, 0);
       vertex(w, h, 0, 1, 1);
       vertex(-w, h, 0, 0, 1);
     endShape();
   }
  
}
