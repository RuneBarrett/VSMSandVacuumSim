class Pictures {

  PImage ske, musling, skull, starfish, sten, stenplant, ring, medalje;
  PImage[] images; 

  int[] positionsX;
  int[] positionsY;
  int numPositions = 8;
  int picSize=70;

  void setupPictures() {
    //imageMode(CENTER);
    images = new PImage[8];
    //int tempPos;
    positionsY = new int[8];
    positionsX = new int[8];
    //int count = 0;

     int tempW = ((int)(2*width/3));
     println(width, tempW);
    int w=tempW/picSize;
    int h=height/picSize;
    println(w,h);
    int[] vals=new int[8];
    for (int i=0; i<8; i++) {
      int k=int(random(w*h));
      while (member(k, vals)) k=int(random(w*h));
      vals[i]=k;
      positionsX[i]=picSize*(k%w)+1*width/3;
      positionsY[i]=picSize*(k/w);
    }
    println(positionsX[0], positionsX[1], positionsX[2], positionsX[3], positionsX[4], positionsX[5], positionsX[6], positionsX[7]);
    println(positionsY[0], positionsY[1], positionsY[2], positionsY[3], positionsY[4], positionsY[5], positionsY[6], positionsY[7]);
    
    images[0] = loadImage("ring.png");
    images[1] = loadImage("ske.png");
    images[2] = loadImage("musling.png");
    images[3] = loadImage("skull.png");
    images[4] = loadImage("starfish.png");
    images[5] = loadImage("medalje.png");
    images[6] = loadImage("sten.png");
    images[7] = loadImage("stenplant.png");
  }

  void drawPictures() {
    PImage temp;
    for (int i = 0; i<images.length; i++) {
      temp=images[i];
      temp.resize(picSize, picSize);
      image(temp, positionsX[i], positionsY[i]);
    }
  }

  int[][] getPositions(int length) {
    int[][] a = new int[length][2];
    for (int i = 0; i<a.length; i++) {
      a[i][0] = positionsX[i]+35;
      a[i][1] = positionsY[i]+35;
    }
    return a;
  }

  boolean member(int m, int[] l) {
    boolean b=false;
    for (int i=0; i<l.length; i++) if (m==l[i]) b=true;
    return b;
  }
}