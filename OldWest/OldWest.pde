import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer yeeHawPlayer;
AudioPlayer walkingPlayer;

float lowerL = -800;
float upperL = 800; 
float eyeX;
float eyeY;
float eyeZ;
float centerX;
float centerY;
float bgX;
float bgY;
float bgZ;
boolean isDay;
boolean turnedAround;


Bird[] flock = new Bird[10];
Tumbleweed[] weeds = new Tumbleweed[100];

void setup() {
  size(800,800,P3D);
  
  minim = new Minim(this);
  eyeX = 342;
  eyeY = 306;
  eyeZ = height+30;
  centerX = 364;
  centerY = 78;
  bgX = 149;
  bgY = 202;
  bgZ = 255;
  isDay = true;
  turnedAround = false;
  //Tumbleweed Additions
  for (int i = 0; i < weeds.length; i++) weeds[i] = new Tumbleweed(upperL, lowerL, createShape(SPHERE,20), loadImage("weed.jpg"));
  for (int i = 0; i < flock.length; i++) flock[i] = new Bird();
  
  translate(width/2, height/2);
  pushMatrix();
  yeeHawPlayer = minim.loadFile("yeehaw.mp3");
  walkingPlayer = minim.loadFile("walking.mp3");
  //player.play();
}

void draw() {
  background(bgX, bgY, bgZ);
  camera(eyeX+1, eyeY+-42, eyeZ+1,centerX+1, centerY+1, 0, 0, 1, 0);
  fill(255, 0, 0);
  
  pushMatrix();
  ellipse(centerX+1, centerY+179, 50, 50);
  popMatrix();

  noFill();
  
  
  translate(411, 482);
  
  //ground
  stroke(202, 141, 66);
  fill(202, 141, 66);
  box(8000, 1,8000);
  
  for(int i = 0; i < 5; i ++){
    stroke(244, 71, 79);
    fill(0, 100, 100);
    pushMatrix();
    translate(429, -114, -400 + i*388);
    box(308, 222, 276);
    popMatrix();
    pushMatrix();
    translate(-631, -114, -400 + i*388);
    box(308, 222, 276);
    popMatrix();
  }
  //Star System Drawing
   
   
  for (Bird b : flock) {
    b.update();
    b.display();
  }
  
  pushMatrix();
  textSize(32);
  fill(0);
  text("Welcome to the Old West", -280, -150, -322);
  popMatrix();
  
  //TexturedCube(loadImage("woodTexture.jpg"));
  
  pushMatrix();
  //Water Tower
  translate(454, -235, -925);
  Cylinder cyl = new Cylinder("waterTower", 207, 642, 30, loadImage("metal.jpg"));
  cyl.display();
  popMatrix();
  
  for (Tumbleweed weed : weeds) {
    //weed.update();
    //weed.show();
  }
  
  fill(255);
  
  movement();
  playWalkingSound();
  
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


void movement(){
  if(key == 'w' || keyCode == UP){
     //go forward
     if(keyPressed){
       if(!turnedAround)eyeZ -= 5;
       else eyeZ += 5;
       //playWalkingSound();
     }
   }
   if(key == 's' || keyCode == DOWN){
     //go backwards
     if(keyPressed) {
       if(!turnedAround)eyeZ += 5;
       else eyeZ -= 5;
       //playWalkingSound();
     }
   }
   if(key == 'a' || keyCode == LEFT){
     //strafe left
     if(keyPressed) {
       if(!turnedAround)centerX -= 10;
       else centerX += 10;
       //eyeX += 10;
       //playWalkingSound();
     }
   }
   if(key == 'd' || keyCode == RIGHT){
     //strafe right
     if(keyPressed) {
       //eyeX -= 10;
       if(!turnedAround)centerX += 10;
       else centerX -= 10;
       //playWalkingSound();
     }
   }
   
   if(key == 'e'){
     //strafe right
     if(keyPressed){
       if(!turnedAround){
         centerX += 10;
         eyeX += 10;
       }
       else{
         centerX -= 10;
         eyeX -= 10;
       }
     }
   }
   if(key == 'q'){
     //strafe left
     if(keyPressed){
       if(!turnedAround){
         centerX -= 10;
         eyeX -= 10;
       }
       else{
         centerX += 10;
         eyeX += 10;
       }
     }
   }
   //walkingPlayer.pause();
}

void playWalkingSound(){
  if(keyPressed){
    walkingPlayer.rewind();
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
  if(key == 'r'){
    //turn around
    eyeZ = -eyeZ;
    if(turnedAround) turnedAround = false;
    else turnedAround = true;
  }
  if (key == ' ') {
    yeeHawPlayer.rewind();
    yeeHawPlayer.play();
  }
}

void stop(){
 yeeHawPlayer.close();
 walkingPlayer.close();
 minim.stop();
 super.stop();
}
