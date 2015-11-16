import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import ddf.minim.*;

//MÅL 
//108 fra gulv til øverst på kinect
//44 fra kant af kinect til startbord

Minim minim;
AudioPlayer voice;
AudioPlayer music;

//PicLoop picLoop;
SandVacuum2 sv2;

boolean voiceStarted = false;

//Kinect
Kinect kinect;
float deg;
PImage kinectDepthImage;
int kinectW = 640;
int kinectH = 480;

//Depth
color[][] depthMapSnapshot;
final float threshold = 2;
final int maxDepth = 170;//Close
final int minDepth = 150;//Far

//Interest box size and position
final int yMargin = 160;
final int yHeight = 50;
final int yPos = 265;

//Mouse variables
ArrayList<Integer> activeXVals = new ArrayList<Integer>();
float currentDepthX;
float vacuumMouseX = 0;
float currentWidthY = 0;
//Lerp mouse variables
float lastXValue = 0;
float lastYValue;
boolean started = false;

//draw sand?
boolean sand = true;
boolean reset = false;
float resetTimer = 0;

void setup() {
  fill(0);
  rect(0, 0, 50, 50);
  println("starting", millis());
  //size(640, 480);
  fullScreen();
  //background(0);

  println("init minim", millis());
  minim = new Minim(this);

  //println("init picLoop",millis());
  //picLoop = new PicLoop();
  //println("setup loopPics",millis());
  //picLoop.setupLoopPics();
  println("load soundfiles", millis());
  voice = minim.loadFile("nasalStemme.MP3");
  music = minim.loadFile("ScubaSound.mp3");


  println("init sand", millis());
  sv2 = new SandVacuum2();
  sv2.sandSetup();

  //Initialize Kinect
  println("Init Kinect", millis());
  kinect = new Kinect(this);
  println("Init Depth", millis());
  kinect.initDepth();
  println("Init Video", millis());
  kinect.initVideo();
  println("Init Tilt", millis());
  deg = kinect.getTilt(); 

  //Get the first picture from the Kinect to be used with the "startColors" array.
  kinectDepthImage = kinect.getDepthImage();
  image(kinectDepthImage, 0, 0);

  //Fill the "depthMapSnapshot" array with colors from each pixel in the area of interest
  loadPixels();
  depthMapSnapshot = new color[kinectW][kinectH];
  for (int x = 0; x < kinectW; x++) {
    for (int y = 0; y < kinectH; y++) {
      depthMapSnapshot[x][y] = get(x, y);
    }
  }

  resetTimer = millis();
  music.setVolume(60);
  println(music.getVolume());
  music.loop();
  println("Done", millis());
}

void draw() {
  background(0);
  kinectDepthImage = kinect.getDepthImage();
  image(kinectDepthImage, 0, 0);
  activeXVals.clear();

  float depth = 0;
  //loop through the two dimensional array
  for (int x = yMargin; x < kinectW-yMargin; x++) {
    for (int y = yPos; y < yPos+yHeight; y++) {
      //if the change in depth is above the threshold
      if (red(get(x, y)) > red(depthMapSnapshot[x][y])+threshold/2 
        || red(get(x, y)) < red(depthMapSnapshot[x][y])-threshold/2 && red(get(x, y)) != 0)
      {
        //change the value of the mouseY to a mapping of the new depth values 
        currentWidthY = map(red(get(x, y)), minDepth, maxDepth, width, width/3);
        depth = red(get(x, y));
        set(x, y, color(0, 255, 0, 50));
        //and add x to the activeXVals list
        activeXVals.add(x);
      }
    }
  }
  currentDepthX = 0;

  //If the activeXVals array contains active pixels, continue with the x axis
  //println("vals:",activeXVals.size());
  if (activeXVals.size() > 5) {
    resetTimer = 0;
    for (int i = 0; i < activeXVals.size(); i++) {
      //add up all values to get the mean
      currentDepthX += activeXVals.get(0);
    }
    if (currentDepthX != 0) {
      //get mean of active x values
      currentDepthX = currentDepthX/activeXVals.size()+30;
    } else {
      //avoid meanXValue becoming 0
      currentDepthX = -10;
    }
    //float tester = currentDepthX; 
    currentDepthX = map(currentDepthX, 190, 500, 0, height);

    // Draw sand if true, then draw an ellipse at the current position
    float ellSize = map(activeXVals.size(), 0, 2000, 2, yHeight);//map the size to the amount of active pixels
    //map the size of the ellipse according to the depth, since it is determined by amount of active pixels
    ellSize *= map(depth, minDepth, maxDepth, 1.8, .7);

    if (sand)
      sv2.sandUpdate((int)currentWidthY, (int)currentDepthX, (int)(ellSize*1.8));
    fill(color(0, 255, 200, 30));
    noStroke();
    ellipse(currentWidthY, currentDepthX, ellSize, ellSize);
    //println("Depth:", depth, "Height", tester, "XVals:", activeXVals.size(), "MeanX:", currentDepthX, "mouseY:", currentWidthY);

    if (!voiceStarted && !voice.isPlaying() && sand) {
      voiceStarted = true;
      voice.play(1);
      //music.play();
    }
    resetTimer=millis();
    //if (!started) started = true;
  } else {
    if (sand)
      sv2.sandUpdate();
    //resetTimer+=millis();
    if (millis()-resetTimer > 25000 && voiceStarted) {
      println("resetting");
          fill(0, 200, 200, 120);
    rect(0, 0, width, height);
      reset();
      //print (millis()-resetTimer);
    }
  }
  //println (millis()-resetTimer);

  //if(sand)
  //picLoop.loopPictures();
  if (reset) {
    fill(0, 200, 200, 120);
    rect(0, 0, width, height);
    reset();
  }
}

void keyPressed() {
  if (key == 'r') {
    restart();
  } else if (key == 'x') {
    reset = true;
  } else if (key == 's') {
    sand = !sand;
  } else if (key == CODED) {
    if (keyCode == UP) {
      deg++;
    } else if (keyCode == DOWN) {
      deg--;
    }
    deg = constrain(deg, 0, 30);
    kinect.setTilt(deg);
  }
}

void restart() {
  println("restarting");
  image(kinect.getDepthImage(), 0, 0);

  depthMapSnapshot = new color[kinectW][kinectH];
  for (int x = 0; x < kinectW; x++) {
    for (int y = 0; y < kinectH; y++) {
      depthMapSnapshot[x][y] = get(x, y);
    }
  }
}

void reset() {

  voice.pause();
  voiceStarted = false;

  println("setupSand");
  sv2.sandSetup();
  reset = false;
  resetTimer = millis();
}