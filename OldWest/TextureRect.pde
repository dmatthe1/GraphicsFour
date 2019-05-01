class TextureRect {
 PImage img;
 float w;
 float h;
 PVector colors;
 
   TextureRect(PImage i, float wid, float hei, PVector tintColors){
     img = i;
     w = wid;
     h = hei;
     colors = tintColors;
   }
 
   void display(){
     textureMode(NORMAL);
     beginShape(QUADS);
     tint(colors.x, colors.y, colors.z);
       texture(img);
       vertex(-w, -h, 0, 0, 0);
       vertex(w, -h, 0, 1, 0);
       vertex(w, h, 0, 1, 1);
       vertex(-w, h, 0, 0, 1);
     endShape();
     noTint();
   }
  
}
