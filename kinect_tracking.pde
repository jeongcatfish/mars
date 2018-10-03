

class track{



// Which pixels do we care about?

int forX=0;

// What is the kinect's angle


  void track_start()
  {
    println("track_start : start");
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
  image(depthImg, 0, 0);
 
  avgX = sumX / total;
  avgY = sumY / total;
  fill(255,0,0);
  //ellipse(avgX,avgY,54,54);
  ellipse(mappingX(avgX),mappingY(avgY),skip+7,skip+7);
  }
  
float mappingX(float x)
{
  float nx = map(x,130,540,190,840);
  return nx;
}
float mappingY(float y)
{
  float ny = map(y,0,370,65,680);
  return ny;
}
}
