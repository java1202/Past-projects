class Paddle
{
  float x; 
  float y; 
  float w; 
  float h;
  float r; 
  float g; 
  float b; 

  Paddle()
  {
    y = 575;
    w = 100;
    h = 10;
  }

  void update()
  {
    x = mouseX;    

    stroke(#E5D8D3);
    strokeWeight(5);
    fill(#09AF8F);
    rect(x, y, w, h);
  }
}
