

class track{

// Depth image
PImage depthImg;

// Which pixels do we care about?

int forX=0;

// What is the kinect's angle

float avgX=0;
float avgY=0;

  track()
  {
    PImage depthImg;
    
  depthImg = new PImage(kinect.width, kinect.height);
  }

  void track_start()
  {
    int[] rawDepth = kinect.getRawDepth();

    float sumX=0,sumY=0;
    float total=0;

  for(int x=0; x<kinect.width; x++)
  {
    for(int y=0; y<kinect.height; y++)
    {
      int offset = x+y*kinect.width;
     
      if (rawDepth[offset] >= minDepth && rawDepth[offset] <= maxDepth) //detect care pixels. 
      {
          depthImg.pixels[offset] = color(255,0,100); 
          sumX+=x;
          sumY+=y;
          total++;
      }
      else 
      {
        depthImg.pixels[offset] = color(0);
      }
    }
  }
  
  // Draw the thresholded image
  depthImg.updatePixels();
  //image(depthImg, 0, 0);
 
  avgX = sumX / total;
  avgY = sumY / total;
  fill(255,0,0);
  //ellipse(avgX,avgY,54,54);
  ellipse(mappingX(avgX),mappingY(avgY),54,54);
  }
  
float mappingX(float x)
{
  float nx = map(x,0,kinect.width,0,1920);
  return nx;
}
float mappingY(float y)
{
  float ny = map(y,0,kinect.height,0,1080);
  return ny;
}
}
