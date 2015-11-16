class PicLoop {
  PImage p1, p2, p3, p4, p5, p6, p1r, p2r, p3r, p4r, p5r, p6r;
  int timer;
  int t = 7000;

  void setupLoopPics() {
    println("reading pictures");
    p1 = loadImage("p1.jpg");
    p2 = loadImage("p2.jpg");
    p3 = loadImage("p3.jpg");
    p4 = loadImage("p4.jpg");
    p5 = loadImage("p5.jpg");
    p6 = loadImage("p6.jpg");
    p1r = loadImage("p1r.jpg");
    p2r = loadImage("p2r.jpg");
    p3r = loadImage("p3r.jpg");
    p4r = loadImage("p4r.jpg");
    p5r = loadImage("p5r.jpg");
    p6r = loadImage("p6r.jpg");
  }

  void loopPictures() {
    if (millis() - timer > 0)
    {
      p1r.resize(width/3, height/2);
      image(p1r, 0, 0);
      p1.resize(width/3, height/2);
      image(p1, 0, height/2);
    }

    if (millis() - timer > t*4)
    {   
      p2r.resize(width/3, height/2);
      image(p2r, 0, 0);
      p2.resize(width/3, height/2);
      image(p2, 0, height/2);
    }
    if (millis() - timer > t*6)
    { 
      p3r.resize(width/3, height/2);
      image(p3r, 0, 0);  
      p3.resize(width/3, height/2);
      image(p3, 0, height/2);
    } 
    if (millis() - timer > t*8)
    {  
      p4r.resize(width/3, height/2);
      image(p4r, 0, 0);
      p4.resize(width/3, height/2);
      image(p4, 0, height/2);
    }

    if (millis() - timer > t*10)
    {

      p5r.resize(width/3, height/2);
      image(p5r, 0, 0);
      p5.resize(width/3, height/2);
      image(p5, 0, height/2);
    }

    if (millis() - timer > t*12)
    {
      timer = millis();
      p6r.resize(width/3, height/2);
      image(p6r, 0, 0);
      p6.resize(width/3, height/2);
      image(p6, 0, height/2);
    }
    fill(0,0,100,180);
    rect(0,height/2-10,width/3,20);

  }
}