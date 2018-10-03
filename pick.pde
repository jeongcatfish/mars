  int state_of=0;
boolean state=false; //to pop the foot print. left or right.

class pick{
  int x_getcolor,y_getcolor;
  int preA=-1, preB=-1; // same position detect
  float foot_positionX=0,foot_positionY=0;
  int a_getcolor=0, b_getcolor=0;
  
  color target; //target color
  int loc;  //2D to 1D
  PImage right, left; //image of right and left foot image.

  boolean yes = true;
  float pre_leftX,pre_leftY;;
  float pre_rightX,pre_rightY;
  int preX=-1,preY=-1;
  
  
  ArrayList<FootPrint> footprints;  //right_foot
  ArrayList<FootPrint> footprints2; //left_foot
  
  
  pick(int r, int g, int b)
  {
    target = color(r, g, b);
    right = loadImage("right2.png");
    left = loadImage("left2.png");
    //image(right,-100,-100);
    footprints = new ArrayList<FootPrint>(); 
    footprints2 = new ArrayList<FootPrint>(); 
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
            foot_positionX=x_getcolor;
            foot_positionY=y_getcolor;
            state=false; 
          } 
          else if (state == false)//right foot.
          {
            foot_positionX=x_getcolor;
            foot_positionY=y_getcolor;
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
  
  void print_footprint_right()
  {  
    footprints.add(new FootPrint(foot_positionX,foot_positionY, state_of)); 
  }
  
  void print_footprint_left()
  {  
    footprints2.add(new FootPrint(foot_positionX,foot_positionY, state_of)); 
  }
  
  void remove_left()
  {
    int i=0;
    
    for(i=0; i< footprints2.size(); i++)
    { 
      FootPrint footprint = footprints2.get(i);
      footprint.displayLeft(i);
    
      if(footprint.finished()){
        footprints2.remove(i);
      }
    }
  }
  
  void remove_right()
  {
    int i=0;
    
    for(i=0; i< footprints.size(); i++)
    { 
      FootPrint footprint = footprints.get(i);
      footprint.displayRight(i);
    
      if(footprint.finished()){
        footprints.remove(i);
      }
    }
  }
  
}   // END OF CLASS "PICK" // // END OF CLASS "PICK" // // END OF CLASS "PICK" //

class FootPrint{

  int space=50;
  int dspace=40;
  int []temp_state_right =new int[20];
  int []temp_state_left =new int[20];
  PImage right, left;
  float x;
  float y;
  float life = 255;
  float speed = 8;
  boolean count= true;
  int state;
  
  FootPrint(float tempX, float tempY, int st) {
    //right = loadImage("right2.png");
    //left = loadImage("left2.png");
    right = loadImage("right180.png");
    left = loadImage("left180.png");
    x = tempX;
    y = tempY;
    state = st;
  }
  
  void displayRight(int ct) {
      
      if(state == 0)  left(x, y); 
      else if(state==1) right315(x, y); //NW
      else if(state==2) right(x, y);    //N
      else if(state==3) right45(x, y);  //NE
      else if(state==4) right270(x, y); //W
      else if(state==5) right90(x, y);  //E
      else if(state==6) right225(x, y); //WS
      else if(state==7) right180(x, y); //S
      else if(state==8) right135(x, y); //ES
  }
  
  void displayLeft(int ct) {
       if(state_of == 0)  left(x, y);      
       else if(state==1) left315(x, y); //NW 
       else if(state==2) left(x, y);    //N
       else if(state==3) left45(x, y);  //NE
       else if(state==4) left270(x, y); //W
       else if(state==5) left90(x, y);  //E
       else if(state==6) left225(x, y); //WS
       else if(state==7) left180(x, y); //S
       else if(state==8) left135(x, y); //ES
       //count = false;
     }
  
  boolean finished(){
    //life--;
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
    image(left, foot_positionX-space, foot_positionY, left.width, left.height);
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
      translate(foot_positionX-dspace,foot_positionY-dspace); // Have to find the 
      rotate(radians(45));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left90(float foot_positionX, float foot_positionY) // E
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY-space); // Have to find the 
      rotate(radians(90));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left135(float foot_positionX, float foot_positionY) // ES
  {
      pushMatrix();
      translate(foot_positionX+dspace,foot_positionY-dspace); // Have to find the 
      rotate(radians(135));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left180(float foot_positionX, float foot_positionY) //S
  {
      pushMatrix();
      translate(foot_positionX+space,foot_positionY); // Have to find the 
      rotate(radians(180));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  
  void left225(float foot_positionX, float foot_positionY) // WS
  {
      pushMatrix();
      translate(foot_positionX+dspace,foot_positionY+dspace); // Have to find the 
      rotate(radians(225));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left270(float foot_positionX, float foot_positionY) // W
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY+space); // Have to find the 
      rotate(radians(270));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  void left315(float foot_positionX, float foot_positionY) // NW
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(315));
      if(life > 0) life-=speed;
    tint(255,life);
      image(left, 0, 0, left.width, left.height);
      popMatrix();
  }
  
  
  void right45(float foot_positionX, float foot_positionY) // NE
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(45));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right90(float foot_positionX, float foot_positionY) // E
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(90));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right135(float foot_positionX, float foot_positionY) // ES
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
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
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(225));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right270(float foot_positionX, float foot_positionY) // W
  {
      pushMatrix();
      translate(foot_positionX,foot_positionY); // Have to find the 
      rotate(radians(270));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  void right315(float foot_positionX, float foot_positionY) // NW
  {
      pushMatrix();
      translate(foot_positionX+dspace, foot_positionY-dspace); // Have to find the 
      rotate(radians(315));
      if(life > 0) life-=speed;
    tint(255,life);
      image(right, 0, 0, right.width, right.height);
      popMatrix();
  }
  
  
}
