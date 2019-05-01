import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Sound Players
Minim minim;
AudioPlayer yeeHawPlayer;
AudioPlayer walkingPlayer;
AudioPlayer oldTownPlayer;

//Global Variables
float lowerL = -800;
float upperL = 800; 

PVector eyeVect;
PVector centerVect;
PVector upVect;

float bgX;
float bgY;
float bgZ;
float s;
boolean isDay;
float theta = 0;
float angle;
PImage groundImage;
PImage metal;

PVector look;
PVector side;

//System Variables
Bird[] flock = new Bird[50];
Tumbleweed[] weeds = new Tumbleweed[100];
ArrayList<TexturePlanet> system = new ArrayList<TexturePlanet>();

void setup() {
  size(800,800,P3D); 
  minim = new Minim(this);
  isDay = true;
  groundImage = loadImage("dirt.jpg");
  //Camera Variables
  eyeVect = new PVector(342, 264, height+30);
  centerVect = new PVector(364, 78, 0);
  upVect = new PVector(0, 1, 0);
  
  //Starting Colors
  bgX = 149;
  bgY = 202;
  bgZ = 255;

  angle = 0;
  s = 5;
  look = new PVector(0, 0, 0);
  side = new PVector(0, 0, 0);
  look.normalize();
  side.normalize();

  //Tumbleweed and Bird Inits
  for (int i = 0; i < weeds.length; i++) weeds[i] = new Tumbleweed(upperL, lowerL, createShape(SPHERE,20), loadImage("weed.jpg"));
  for (int i = 0; i < flock.length; i++) flock[i] = new Bird();
  system.add(new TexturePlanet("Sun", 500, 60, loadImage("sun.jpg"), 10, -1000));
  
  //Players
  yeeHawPlayer = minim.loadFile("yeehaw.mp3");
  walkingPlayer = minim.loadFile("walking.mp3");
  oldTownPlayer = minim.loadFile("song.mp3");
  
  metal = loadImage("metal.jpg");
  
  translate(width/2, height/2);
  pushMatrix();
}

void draw() {
  //Background music
  oldTownPlayer.play();

  //Background Settings
  background(bgX, bgY, bgZ);
  noFill();

  //Camera Settings
  camera(eyeVect.x, eyeVect.y, eyeVect.z, centerVect.x, centerVect.y, centerVect.z, upVect.x, upVect.y, upVect.z);

  translate(411, 482);
  
  //Ground
  pushMatrix();
  rotateX(degrees(141.053));
  TextureRect ground = new TextureRect(groundImage, 8000, 8000, new PVector(202, 141, 66));
  ground.display();
  popMatrix();
  
  //houses
  for(int i = 0; i < 10; i ++){

    stroke(244, 71, 79);
    fill(0, 100, 100);
    pushMatrix();
    translate(429, -114, -400 + i*388);
    box(308, 222, 276);
    translate(0, -261, -12);
    rotateX(degrees(61));
    Pyramid pyr1 = new Pyramid(150, new PVector(127, 79, 98), new PVector(214, 78, 98));
    pyr1.display();
    popMatrix();
    
    stroke(244, 71, 79);
    fill(0, 100, 100);
    pushMatrix();
    translate(-631, -114, -400 + i*388);
    box(308, 222, 276);
    translate(0, -262, -12);
    rotateX(degrees(61));
    Pyramid pyr2 = new Pyramid(150, new PVector(127, 79, 98), new PVector(214, 78, 98));
    pyr2.display();
    popMatrix();
  }
   
  //Birds
  for (Bird bird : flock) {
    bird.update();
    bird.display();
  }
  
  //Weeds
  for (Tumbleweed weed : weeds) {
    weed.update();
    weed.show();
  }
  
  for (TexturePlanet planet : system) {
     pushMatrix();
     translate(-162, -1310, 265);
     rotateY(planet.speed * theta);
     translate(0, planet.translation);
     if(isDay) planet.display();
     popMatrix();
  }
  
  //Text
  pushMatrix();
  textSize(200);
  fill(0);
  text("Welcome to the Old West", -1500, -1000, -2000);
  popMatrix();
  
  //Water Tower
  pushMatrix();
  translate(454, -235, -925);
  Cylinder cyl = new Cylinder("waterTower", 207, 642, 30, metal);
  cyl.display();
  popMatrix();
  
  fill(255);

  movement();
  playWalkingSound();
  
  
  theta += 0.01;
  
  look = (centerVect.copy()).sub(eyeVect.copy());
  side = (look.copy()).cross(upVect.copy());
  
  if(mousePressed == true){
    if(mouseButton == LEFT){
      float diffX = mouseX - pmouseX;
      if(diffX != 0){
         //angle = diffX/width;
         //rotateAroundAxis(upVect, angle);
         centerVect.x -= diffX;
      }
    }
    if(mouseButton == RIGHT){
      float diffY = mouseY - pmouseY;
      if(diffY != 0){
         //angle = diffY/width;
         //rotateAroundAxis(
         centerVect.y -= diffY;
      }
    }
  }

  
  if(int(random(0, 55)) == 1){
    //day night cycle
    //day 149, 202, 255
    //night 29, 41, 81
    if(isDay){
      //println("change of time day");
      if(bgX > 29) bgX -= 1;
      if(bgY > 41) bgY -= 1;
      if(bgZ > 81)bgZ -= 1;
      if(bgX <= 29 && bgY <= 41 && bgZ <= 81) isDay = false;
    }
    else{
      //println("change of time night");
      if(bgX < 149) bgX += 1;
      if(bgY < 202) bgY += 1;
      if(bgZ < 255)bgZ += 1;
      if(bgX >= 149 && bgY >= 202 && bgZ >= 255) isDay = true;
    }
    
  }
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  e*= 12;
  centerVect.z += e;
}

void movement(){
  if(key == 'w' || keyCode == UP){
     //go forward
     if(keyPressed){
       /*
       eyeVect.z -= 5;
       centerVect.z -= 5;
       */
       look.normalize();
       eyeVect = (eyeVect.copy()).add(look.copy().mult(s));
       centerVect = (centerVect.copy()).add(look.copy().mult(s));
     }
   }
   if(key == 's' || keyCode == DOWN){
     //go backwards
     if(keyPressed) {
       /*
       eyeVect.z += 5;
       centerVect.z += 5;
       */
       look.normalize();
       eyeVect = (eyeVect.copy()).sub(look.copy().mult(s));
       centerVect = (centerVect.copy()).sub(look.copy().mult(s));
     }
   }
   if(key == 'a' || keyCode == LEFT){
     //strafe left
     if(keyPressed) {
       /*
       centerVect.x -= 10;
       eyeVect.x -= 10;
       */
       side.normalize();
       eyeVect = (eyeVect.copy()).sub(side.copy().mult(s));
       centerVect = (centerVect.copy()).sub(side.copy().mult(s));
     }
   }
   if(key == 'd' || keyCode == RIGHT){
     //strafe right
     if(keyPressed) {
       /*
       centerVect.x += 10;
       eyeVect.x += 10;
       */
       side.normalize();
       eyeVect = (eyeVect.copy()).add(side.copy().mult(s));
       centerVect = (centerVect.copy()).add(side.copy().mult(s));
     }
   }
   
   if(key == 'e'){
     //turn right
     if(keyPressed){
       centerVect.x += 10;
     }
   }
   if(key == 'q'){
     //turn left
     if(keyPressed){
       centerVect.x -= 10;
     }
   }
   //walkingPlayer.pause();
}

void playWalkingSound(){
  if(keyPressed){
    walkingPlayer.play();
    if(!(walkingPlayer.isPlaying())) {
      walkingPlayer.rewind(); 
      walkingPlayer.play();
    }
  }
  else{
   walkingPlayer.pause(); 
  }
}

void keyPressed(){  
  if (key == ' ') {
    yeeHawPlayer.rewind();
    yeeHawPlayer.skip(2450);
    yeeHawPlayer.play();
  }
}

void rotateAroundAxis(PVector axis, float th){
    PVector w = axis.copy();
    w.normalize();
    PVector t = w.copy();
    if (abs(w.x) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
      t.x = 1;
    } else if (abs(w.y) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
      t.y = 1;
    } else if (abs(w.z) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
      t.z = 1;
    }
    PVector u = w.cross(t);
    u.normalize();
    PVector v = w.cross(u);
    applyMatrix(u.x, v.x, w.x, 0, 
                u.y, v.y, w.y, 0, 
                u.z, v.z, w.z, 0, 
                0.0, 0.0, 0.0, 1);
    rotateZ(th);
    applyMatrix(u.x, u.y, u.z, 0, 
                v.x, v.y, v.z, 0, 
                w.x, w.y, w.z, 0, 
                0.0, 0.0, 0.0, 1);
}

void stop(){
 yeeHawPlayer.close();
 walkingPlayer.close();
 minim.stop();
 super.stop();
}
