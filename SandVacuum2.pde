class SandVacuum2 {
  PImage bg, vacCur, mp, d, d1, d2, d3;
  int disRadius = 7;
  int ellSize = 7;
  int vacRadius=25;
  int vacPower = 60;
  int maxp=1;
  int cntp=0;
  boolean play = false;          
  float[] sx = new float[1500];
  float[] sy = new float[1500];
  color[] sc = new color[1500];
  float vx=50;
  float vy=50;
  int fd=2;
  int r=25;

  int[][] cent = new int[8][2];// = {{100, 100}, {200, 100}, {100, 200}, {200, 200}, 
  //  {300, 100}, {200, 100}, {100, 200}, {200, 200}};
  int[] centR = {35, 35, 35, 35, 35, 35, 35, 35};//new int[8];
  int[] num = new int[8];//{99, 99, 99, 99, 99, 99, 99, 99};

  Pictures pictures;
  CurrentPicture curPic;
  PicLoop picLoop;


  void sandSetup() {
    println("init picLoop", millis());
    picLoop = new PicLoop();
    println("setup loopPics", millis());
    picLoop.setupLoopPics();
    println("init pictures", millis());
    pictures = new Pictures();
    println("setup pictures", millis());
    pictures.setupPictures();
    curPic = new CurrentPicture();
    curPic.setupCurrentPics();
    cent = pictures.getPositions(8);//cent.length
    bg = loadImage("seabottom.jpg");
    bg.resize(width, height);

    d1=createImage(width, height, RGB);
    d2=createImage(width, height, RGB);
    d3=createImage(width, height, RGB);
    for (int i = 0; i < width*height; i++) {
      d1.pixels[i] = color(random(220, 240), random(220, 240), random(180, 200), 10);
      d2.pixels[i] = color(random(200, 240), random(220, 240), random(180, 200), 10);
      d3.pixels[i] = color(random(150, 200), random(220, 240), random(180, 200), 10);
    }
    d1.blend(bg, 0, 0, bg.width, bg.height, 0, 0, bg.width, bg.height, LIGHTEST);
    d2.blend(bg, 0, 0, bg.width, bg.height, 0, 0, bg.width, bg.height, LIGHTEST);
    d3.blend(bg, 0, 0, bg.width, bg.height, 0, 0, bg.width, bg.height, LIGHTEST);
    image(d1, 0, 0);
    //moveVac(mouseX,mouseY,25);
  }  

  void sandUpdate(int thisX, int thisY, int vacRad) {
    cntp=0;
    for (int i = max(0, (thisY-vacRad)*width); i < min(width*height, (thisY+vacRad)*width); i++)
      if (dist(thisX, thisY, i%width, i/width)<vacRad) {
        if (d1.pixels[i]!=0 && random(100)>vacPower) d1.pixels[i]=0; 
        if (d1.pixels[i]==0 && random(100)>vacPower) d2.pixels[i]=0; 
        if (d2.pixels[i]==0 && random(100)>vacPower) d3.pixels[i]=0; 
        if (d1.pixels[i]!=0) cntp++;
      }
    moveVac(thisX, thisY, vacRad);
    if (cntp>maxp) maxp=cntp;
    //println(cntp, maxp);
    churn();

    sandUpdate();
    churn();
    for (int i = 0; i<num.length; i++) {
      if (num[i] < 100)
        curPic.setCurrent(i);
    }
    //println(num[0], num[1], num[2], num[3], num[4], num[5], num[6], num[7]);
    //curPic.printit();
  }

  void sandUpdate() {  
    background(bg);
    pictures.drawPictures();
    loadPixels();
    for (int k=0; k<cent.length; k++) num[k]=0;

    for (int i = 0; i < width*height; i++) {
      if (d1.pixels[i] != 0) {
        pixels[i]=d1.pixels[i];
        for (int k=0; k<cent.length; k++) 
          if (dist(i%width, i/width, cent[k][0], cent[k][1])<centR[k]) num[k]++;
      } else if (d2.pixels[i] != 0) pixels[i]=d2.pixels[i];
      else if (d3.pixels[i] != 0) pixels[i]=d3.pixels[i];
    }

    updatePixels();
    //pictures.drawPictures();
    if (curPic.curPic == null)
      picLoop.loopPictures();
    curPic.currentUpdate();
  }

  void churn() {
    for (int i =0; i<int(sx.length*cntp/maxp); i++) {
      stroke(sc[i]);
      //if (random(1)>(maxp-cntp)/maxp) point(sx[i], sy[i]);
      point(sx[i], sy[i]);
      //println(sp[i], d1.pixels[sp[i]], vx, vy);
      if (dist(sx[i], sy[i], vx, vy)>r) {
        sx[i]=vx+random(-r, r);
        sy[i]=vy+random(-r, r);
      } else {
        sx[i]=sx[i]+random(-fd, fd);
        sy[i]=sy[i]+random(-fd, fd);
      }
    }
  }
  void moveVac(int mx, int my, int vacRad) {
    if (dist(vx, vy, mx, my)>2) {
      vx=mx;
      vy=my;
      for (int i =0; i<sx.length; i++) {
        sx[i]=vx+random(-vacRad, vacRad);
        sy[i]=vy+random(-vacRad, vacRad);
        sc[i]=color(random(220, 240), random(220, 240), random(180, 200), 1);
      }
    }
  }
}