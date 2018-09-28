import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.video.*;
import ddf.minim.*;
PImage img;
PImage mask;
float transparency = 255;
//PImage depthImg;
//int skip=120;
int skip=80;
float angle;
int minDepth =  60;
int maxDepth = 650;
/*
PImage kinect2_img;
Kinect2 kinect2;
kinect2_img = createImage(kinect2.depthWidth,kinect2.depthHeight,RGB);
*/
Kinect kinect;
pick[] pick = new pick[5];
//track tracking = new track();

void setup()
{
  size(1024, 768); //1024x768
  background(255);
  pick[0] = new pick(255,0,0); //red
  pick[1] = new pick(255,255,255); //white
  pick[2] = new pick(255,255,0);  //yellow
  pick[3] = new pick(0,0,255);    //blue
  pick[4] = new pick(0,255,255);  //sky
/*  //red, white, yellow, blue, sky
  kinect2= new Kinect2(this);
  kinect2.initDevice();
  kinect2.initDepth();
  */
  
  img = loadImage("mars10241024.png");
  mask = loadImage("mask.png");
  //background(0);
  //image(img, 360, 0, 1200, 1200); 
  //draw_rect();
    kinect = new Kinect(this);
    kinect.initDepth();
    angle = kinect.getTilt();
    // Blank image
}

void draw()
{
  background(0);
  //image(img, 360, 0, 1200, height);  // img --> mars2.jpg or png not sure..
  //noTint();
  human(); // It will be kinect depthdata 
  //tracking.track_start();
  for(int i=0;i<5;i++)
  {
    pick[i].getcolor(); //get pixel color of every single point.
  }
  tint(255,255);
  image(img, (width-img.width)/2, 0, 800, height);  // img --> mars2.jpg or png not sure..
  for(int i=0;i<5;i++)
  {
    pick[i].print_footprint(); // print foot when the pixel is changed.
    //pick[i].pre_footprint_left();
  }
  draw_rect();
  //check_detect_area();
  fill(0);
  rect(0,0,130,160);
  noTint();
  image(mask,0,0);
}

void human()
{
  //red, white, yellow, blue, sky
  noStroke();
  fill(255,0,0);
  ellipse(mouseX, mouseY, skip, skip);
  /*
  fill(255,255,255);
  ellipse(mouseX+300, mouseY, 100, 100);
  fill(0,255,255);
  ellipse(mouseX+300, mouseY+200, 100, 100);
  fill(0,0,255);
  ellipse(mouseX+600, mouseY+500, 100, 100);
  */
}

void draw_rect()
{
  for (int y=0; y<height; y=y+skip)
  {
    for (int x=((width-img.width)/2); x<width-(width-img.width)/2; x=x+skip)
    {
      stroke(0);
      fill(255, 255, 255,1);
      rect(x, y, skip, skip);
    }
  }
}

void check_detect_area()
{
  for (int x =((width-img.width)/2)-(skip/2); x<1560; x+=skip)
  {
    for (int y=skip/2; y<height; y+=skip)
    {
      fill(255, 0, 255,10);
      noTint();
      ellipse(x, y, 15, 15);
    }
  }
}
/*f
void depthimage()
{
  int[] depth = kinect2.getRawDepth();
  
  kinect_img.loadPixels();
  
  for(int x =0; x<kinect2.depthWidth; x++)
  {
    for(int y=0; y<kinect2.depthHeight; y++)
    {
      int offset = x+y*kinect2.depthWidth;
      int d = depth[offset];
      
      if(d > 300 && d <1500)
      {
        kinect2_img.pixels[offset] = color(255,0,255);
      }
      else  kinect2.img.pixels[offset] = color(0);
    }
  }
  
  kinect2_img.updatePixels();
  //image(kinect_img,0,0);
}
*/
