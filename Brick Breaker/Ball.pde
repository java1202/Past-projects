class Ball
{
  float cx; 
  float cy;
  float vx; 
  float vy;
  float D;

  Ball()
  {
    cx = 300;
    cy = 375;
    vx = 0; 
    vy = 4; 
    D = 20;
  }

  void update()
  {
  float a;
  float b; 
  float c;
    a = random(0, 255);
    b = random(0, 255);
    c = random(0, 255);
    noStroke();
    fill(a,b,c);
    circle(cx, cy, D);

    cy += vy; 
    cx += vx; 
  }

  void Left()
  {
    vx = -3; 
  }

  void Right()
  {
    vx = 3;
  }

  void negateY()
  {
    vy *= -1; 
  }

  void reset()
  {
    cx = 300;
    cy = 375;
    vx = 0;
    vy = 4;
  }
}
