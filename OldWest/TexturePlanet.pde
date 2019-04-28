class TexturePlanet {  
  //color
  TextureSphere sph;
  String name; 
  
  //positioning 
  float speed;
  float translation;
  
  //No rings or moons
  TexturePlanet(String name, float radius, int numSegments, PImage img, float speed, float translation) {
     this.sph = new TextureSphere(radius, numSegments, img);
     this.speed = speed;
     this.translation = translation;
     this.name = name;
  }
  
  void display() {
     sph.display(); 
  }
}
