int state_of=0;
boolean state=false; //to pop the foot print. left or right.

class pick{
  int x_getcolor,y_getcolor;
  int preA=-1, preB=-1;
  int preX=-1,preY=-1;
  float foot_positionX=0,foot_positionY=0;
  int a_getcolor=0, b_getcolor=0;
  
  color target;
  int loc;
  PImage right, left;
  
  int onceL=0;
  int onecR=0;
  int apL=255;
  int apR=255;
  //int pre_apL=255;
  //int pre_apR=255;
  boolean yes = true;
  float pre_leftX,pre_leftY;;
  float pre_rightX,pre_rightY;
  float pre_footX,pre_footY;
  int speed=5;
  int life = 255;
  
  ArrayList<FootPrint> footprints;
  
  pick(int r, int g, int b)
  {
    target = color(r, g, b);
    right = loadImage("right2.png");
    left = loadImage("left2.png");
    //image(right,-100,-100);
    footprints = new ArrayList<FootPrint>(); 
    print("intit _ pick");
  }
  
  void getcolor()
  {
    a_getcolor=0;
    b_getcolor=0;
    
    loadPixels();
    for (int x_getcolor =((width-img.width)/2)-(skip/2); x_getcolor<900; x_getcolor+=skip)
    {
      a_getcolor++;
      b_getcolor=0;
      for (int y_getcolor=skip/2; y_getcolor<height; y_getcolor+=skip)
      {
        b_getcolor++;
        loc = x_getcolor + y_getcolor *width;
        if (a_getcolor == preA && b_getcolor == preB) 
        {
          //println("stop updating it's same position");
          continue; 
        }
        if (pixels[loc] == target) //target color = (255,255,255)
        {
          println("detected position : "+a_getcolor+" ," +b_getcolor+ "    x,y value : "+x_getcolor+" , "+y_getcolor );
          println("FOOT _ PRINT x,y value : "+foot_positionX+" , "+foot_positionY);
          if (state ==true) //left foot.
          {
            apR=255;
            //image(right, x_getcolor, y_getcolor, right.width, right.height);
            foot_positionX=x_getcolor;
            foot_positionY=y_getcolor;
            pre_leftX=foot_positionX;
            pre_leftY=foot_positionY;
            println("current X : "+foot_positionX+ " current Y : " +foot_positionY);
            println("preR X : "+pre_rightX+ " preR Y : " +pre_rightY);
            state=false; 
          } 
          else if (state == false)//right foot.
          {
            apL=255;
            //image(left, x_getcolor, y_getcolor, left.width, left.height);
            foot_positionX=x_getcolor;
            foot_positionY=y_getcolor;
            pre_rightX=foot_positionX;
            pre_rightY=foot_positionY;
            println("current X : "+foot_positionX+ " current Y : " +foot_positionY);
            println("preL X : "+pre_leftX+ " preL Y : " +pre_leftY);
            state=true;
          }
          println("in the state : "+state);
          preA=a_getcolor;
          preB=b_getcolor;
    
          //direction//  
          if(preX > a_getcolor && preY > b_getcolor) state_of =1; //NW 315
          else if(preY > b_getcolor && preX == a_getcolor) state_of =2;                //N default
          else if(preX < a_getcolor && preY > b_getcolor) state_of=3; // NE 45
          else if(preX > a_getcolor && preY == b_getcolor) state_of=4;                      // W 270
          else if(preX < a_getcolor && preY == b_getcolor) state_of=5;                      // E 90
          else if(preX > a_getcolor && preY < b_getcolor) state_of=6; // WS 225
          else if(preY < b_getcolor && preX == a_getcolor) state_of=7;                      // S 180
          else if(preX < a_getcolor && preY < b_getcolor) state_of=8; // ES 135
          else state_of=0;
          preX=a_getcolor;
          preY=b_getcolor;
        }
      }
    }
    //updatePixels();
  }
  
void print_footprint()
{
  int count=0;
  
  if(state == true)
  {
     footprints.add(new FootPrint(foot_positionX,foot_positionY));
  }
  else if(state ==false)
  {
    footprints.add(new FootPrint(foot_positionX,foot_positionY));
  }
  
  
  
  for(int i=0; i< footprints.size(); i++)
  {
    FootPrint footprint = footprints.get(i);
    footprint.display();
    
    if(footprint.finished()){
      footprints.remove(i);
    }
  }
}
 

}

class FootPrint{
  
  PImage right, left;
  float x;
  float y;
  float life = 255;
  float speed = 25;
  
  FootPrint(float tempX, float tempY) {
    right = loadImage("right2.png");
    left = loadImage("left2.png");
    x = tempX;
    y = tempY;
  }
  
  void display() {
    
    boolean count= true;
    
      //left(x,y);
     if(count == true)
     {
       if(state_of == 0)  left(x, y); 
       else if(state_of==1) left315(x, y);
       else if(state_of==2) left(x, y);
       else if(state_of==3) left45(x, y);
       else if(state_of==4) left270(x, y);
       else if(state_of==5) left90(x, y);
       else if(state_of==6) left225(x, y);
       else if(state_of==7) left180(x, y);
       else if(state_of==8) left135(x, y);
       count = false;
     }
    
    else if(count == false)
    {
      if(state_of == 0)  left(x, y); 
      else if(state_of==1) right315(x, y);
      else if(state_of==2) right(x, y);
      else if(state_of==3) right45(x, y);
      else if(state_of==4) right270(x, y);
      else if(state_of==5) right90(x, y);
      else if(state_of==6) right225(x, y);
      else if(state_of==7) right180(x, y);
      else if(state_of==8) right135(x, y);
      count = true;
    }
    
  }
  
  boolean finished(){
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void left(float foot_positionX, float foot_positionY)
  {
    if(life > 0) life-=speed;
    tint(255,life);
    image(left, foot_positionX, foot_positionY, left.width, left.height);
  }
  
  void right(float foot_positionX, float foot_positionY)
  {
    if(life > 0) life-=speed;
    tint(255,life);
    image(right, foot_positionX, foot_positionY, right.width, right.height);
  }
  
  void left45(float foot_positionX, float foot_positionY) // NE
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(45));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left90(float foot_positionX, float foot_positionY) // E
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY-15); // Have to find the 
      rotate(radians(90));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left135(float foot_positionX, float foot_positionY) // ES
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(135));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left180(float foot_positionX, float foot_positionY) //S
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(180));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  
  void left225(float foot_positionX, float foot_positionY) // WS
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(225));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left270(float foot_positionX, float foot_positionY) // W
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY-15); // Have to find the 
      rotate(radians(270));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left315(float foot_positionX, float foot_positionY) // NW
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(315));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  
  
  void right45(float foot_positionX, float foot_positionY) // NE
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(45));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right90(float foot_positionX, float foot_positionY) // E
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY+15); // Have to find the 
      rotate(radians(90));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right135(float foot_positionX, float foot_positionY) // ES
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(135));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right180(float foot_positionX, float foot_positionY) //S
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(180));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  
  void right225(float foot_positionX, float foot_positionY) // WS
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(225));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right270(float foot_positionX, float foot_positionY) // W
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(270));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right315(float foot_positionX, float foot_positionY) // NW
  {
      pushMatrix();
      translate(foot_positionX-35,foot_positionY); // Have to find the 
      rotate(radians(315));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  
  
}
