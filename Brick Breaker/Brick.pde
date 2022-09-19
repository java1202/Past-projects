class Brick
{
  float x; 
  float y; 
  float w; 
  float h; 
  float r;
  float g; 
  float b; 

  boolean hit; 
    Brick(float x0, float y0)
  {
    x = x0;
    y = y0;

    r = random(170,250);
    g = random(25,105);
    b = random(0,80);
    w = 75; 
    h = 50; 

    hit = false;
  }

  //Draws the brick
  void update()
  {

    fill(r, g, b);
    rect(x, y, w, h);
  }

  void Hit()
  {
    hit = true;

    r = 0;
    g = 0;
    b = 0;
    rect(x, y, w, h);
  }
}
