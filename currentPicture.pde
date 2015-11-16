import ddf.minim.*;

class CurrentPicture {
  Minim minim;
  AudioPlayer v1, v2, v3, v4, v5, v6, v7, v8;

  PImage p1, p2, p3, p4, p5, p6, p7, p8, 
    p1r, p2r, p3r, p4r, p5r, p6r, p7r, p8r, curPic, curPicR;
  boolean p1F, p2F, p3F, p4F, p5F, p6F, p7F, p8F; 

  void setupCurrentPics() {
    p1 = loadImage("svenskeringMtxt.jpg");
    p2 = loadImage("forgyldt_skeMtxt.jpg");
    p3 = loadImage("musling4Mtxt.jpeg");
    p4 = loadImage("skullMtxt.jpg");
    p5 = loadImage("stafishMtxt.jpg");
    p6 = loadImage("svenskmoentMtxt.jpg");
    p7 = loadImage("stenMtxt.jpeg");
    p8 = loadImage("stenplantMtxt.jpeg");
    p1r = loadImage("svenskeringMtxtR.jpg");
    p2r = loadImage("forgyldt_skeMtxtR.jpg");
    p3r = loadImage("musling4MtxtR.jpg");
    p4r = loadImage("skullMtxtR.jpg");
    p5r = loadImage("stafishMtxtR.jpg");
    p6r = loadImage("svenskmoentMtxtR.jpg");
    p7r = loadImage("stenMtxtR.jpg");
    p8r = loadImage("stenplantMtxtR.jpg");
/*
    minim = new Minim(this);
    v1 = minim.loadFile("svenskringLYD.MP3");
    v2 = minim.loadFile("forgyldtskeLYD.MP3");
    v3 = minim.loadFile("muslingLYD.MP3");
    v4 = minim.loadFile("kranieLYD.MP3");
    v5 = minim.loadFile("starfishLYD.MP3");
    v6 = minim.loadFile("medlajeLYD.MP3");
    v7 = minim.loadFile("stenLYD.MP3");
    v8 = minim.loadFile("plantstenLYD.MP3");
*/
    p1F = false;
    p2F = false; 
    p3F = false;
    p4F = false;
    p5F = false;
    p6F = false;
    p7F = false;
    p8F = false;
  }

  void currentUpdate() {
    if (curPic != null && curPicR != null) {
      curPic.resize(width/3, height/2);
      curPicR.resize(width/3, height/2);
      image(curPicR, 0, 0);
      image(curPic, 0, height/2);
    }
  }

  void setCurrent(int num) {
    switch(num) {
    case 0:
      if (!p1F) {
        //stopSounds();
        //v1.play();
        p1F = true;
        curPic = p1;
        curPicR = p1r;
        break;
      } else {
        break;
      }
    case 1:
      if (!p2F) {
          //      stopSounds();
        //v2.play();
        p2F = true;
        curPic = p2;
        curPicR = p2r;
        break;
      } else {
        break;
      }
    case 2:
      if (!p3F) {
            //    stopSounds();
        //v3.play();
        p3F = true;
        curPic = p3;
        curPicR = p3r;
        break;
      } else {
        break;
      }
    case 3:
      if (!p4F) {
          //      stopSounds();
        //v4.play();
        p4F = true;
        curPic = p4;
        curPicR = p4r;
        break;
      } else {
        break;
      }
    case 4:
      if (!p5F) {
          //      stopSounds();
        //v5.play();
        p5F = true;
        curPic = p5;
        curPicR = p5r;
        break;
      } else {
        break;
      }
    case 5:
      if (!p6F) {
          //      stopSounds();
        //v6.play();
        p6F = true;
        curPic = p6;
        curPicR = p6r;
        break;
      } else {
        break;
      }
    case 6:
      if (!p7F) {
          //      stopSounds();
        //v7.play();
        p7F = true;
        curPic = p7;
        curPicR = p7r;
        break;
      } else {
        break;
      }
    case 7:
      if (!p8F) {
          //      stopSounds();
        //v8.play();
        p8F = true;
        curPic = p8;
        curPicR = p8r;
        break;
      } else {
        break;
      }
    }
  }
 /* void stopSounds() {
    v1.pause();
    v2.pause();
    v3.pause();
    v4.pause();
    v5.pause();
    v6.pause();
    v7.pause();
    v8.pause();
  }*/
  void printit() {
    println("found", p1F, p2F, p3F, p4F, p5F, p6F, p7F, p8F, curPic);
  }
}