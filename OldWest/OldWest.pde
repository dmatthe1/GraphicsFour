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


Tumbleweed[] weeds = new Tumbleweed[100];

void setup() {
  size(800,800,P3D);
  
  minim = new Minim(this);
  eyeX = 342;
  eyeY = 306;
  eyeZ = height+30;
  centerX = 364;
  centerY = 163;
  bgX = 149;
  bgY = 202;
  bgZ = 255;
  isDay = true;
  //Tumbleweed Additions
  for (int i = 0; i < weeds.length; i++) weeds[i] = new Tumbleweed(upperL, lowerL, createShape(SPHERE,20), loadImage("weed.jpg"));
  translate(width/2, height/2);
  pushMatrix();
  yeeHawPlayer = minim.loadFile("yeehaw.mp3");
  walkingPlayer = minim.loadFile("walking.mp3");
  //player.play();
}

void draw() {
  background(bgX, bgY, bgZ);
  camera(eyeX+1, eyeY+104, eyeZ+1,centerX+1, centerY+-22, 0, 0, 1, 0);
  noFill();
  translate(411, 482);
  //texture(loadImage("dirt.jpg"));
  stroke(202, 141, 66);
  fill(202, 141, 66);
  box(1095, 1, 2325);
   //Star System Drawing
  for (Tumbleweed weed : weeds) {
    weed.update();
    weed.show();
  }
  movement();
  
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
       eyeZ -= 5;
       playWalkingSound();
     }
   }
   if(key == 's' || keyCode == DOWN){
     //go backwards
     if(keyPressed) {
       eyeZ += 5;
       playWalkingSound();
     }
   }
   if(key == 'a' || keyCode == LEFT){
     //strafe left
     if(keyPressed) {
       centerX -= 10;
       playWalkingSound();
       //eyeX -= 5;
     }
   }
   if(key == 'd' || keyCode == RIGHT){
     //strafe right
     if(keyPressed) {
       //eyeX += 5;
       centerX += 10;
       playWalkingSound();
     }
   }
   walkingPlayer.pause();
}

void playWalkingSound(){
  walkingPlayer.rewind();
  walkingPlayer.play();
  if(!walkingPlayer.isPlaying()) {
    walkingPlayer.rewind(); 
    walkingPlayer.play();
  } 
}

void keyPressed(){  
  if(key == 'r'){
    //turn around
    eyeZ = -eyeZ;
  }
  if (key == ' ') {
    yeeHawPlayer.rewind();
    yeeHawPlayer.play();
  }
}

void exit() {
  
}

void stop(){
 yeeHawPlayer.close();
 walkingPlayer.close();
 minim.stop();
 super.stop();
}
