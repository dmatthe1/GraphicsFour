import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;

float lowerL = -800;
float upperL = 800; 

Tumbleweed[] weeds = new Tumbleweed[100];

void setup() {
  size(800,800,P3D);
  minim = new Minim(this);
  
  //Tumbleweed Additions
  for (int i = 0; i < weeds.length; i++) weeds[i] = new Tumbleweed(upperL, lowerL, createShape(SPHERE,20), loadImage("weed.jpg"));
  translate(width/2, height/2);
  pushMatrix();
  
  //player = minim.loadFile("derezzed.mp3");
  //player.play();
}

void draw() {
  background(255);
  noFill();
  
   //Star System Drawing
  for (Tumbleweed weed : weeds) {
    weed.update();
    weed.show();
  }
  
}

void exit() {
  
}
