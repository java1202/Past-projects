int rows = 6; 
int columns = 6; 
int total = rows * columns; 
int score = 0; 
int gameScore = 0; 
int lives = 3; 

Paddle paddle = new Paddle(); 
Ball ball = new Ball(); 
Brick[] brick = new Brick[total]; 

void setup()
{
  size(600, 600);
  background(0);

  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      brick[i*rows + j] = new Brick((i+1) *width/(rows + 2), (j) * 50); //places all the bricks into the array, properly labelled.
    }
  }
}

void draw()
{
  background(0);

  for (int i = 0; i<total; i++)
  {
    brick[i].update();
  }

  paddle.update();
  ball.update();

  if (ball.cy == paddle.y && ball.cx > paddle.x && ball.cx <= paddle.x + (paddle.w / 2) )
  {
    ball.Left();
    ball.negateY();
  }

  if (ball.cy == paddle.y && ball.cx > paddle.x + (paddle.w/2) && ball.cx <= paddle.x + paddle.w )
  {
    ball.Right();
    ball.negateY();
  }
 
  if (ball.cx + ball.D / 2 >= width)
  {
    ball.Left();
  }

  if (ball.cx - ball.D / 2 <= 0)
  {
    ball.Right();
  }

  if (ball.cy - ball.D / 2 <= 0)
  {
    ball.negateY();
  }

  for (int i = 0; i < total; i ++)
  {
    if (ball.cy - ball. D / 2 <= brick[i].y + brick[i].h &&  ball.cy - ball.D/2 >= brick[i].y && ball.cx >= brick[i].x && ball.cx <= brick[i].x + brick[i].w  && brick[i].hit == false )
    {
      ball.negateY();
      brick[i].Hit();
      score += 1;
      gameScore += 10;
    } 

    if (ball.cy + ball.D / 2 >= brick[i].y && ball.cy - ball.D /2 <= brick[i].y + brick[i].h/2 && ball.cx >= brick[i].x && ball.cx <= brick[i].x + brick[i].w && brick[i].hit == false ) 
    {
      ball.negateY();
      brick[i].Hit();
      score += 1;
      gameScore += 10;
    }

    if (ball.cx + ball.D / 2 >= brick[i].x && ball.cx + ball.D / 2 <= brick[i].x + brick[i].w / 2 && ball.cy >= brick[i].y && ball.cy <= brick[i].y + brick[i].h  && brick[i].hit == false)
    {
      ball.Left();
      brick[i].Hit();
      score += 1;
      gameScore += 10;
    }

    if (ball.cx - ball.D/2 <= brick[i].x + brick[i].w && ball.cx +ball.D / 2 >= brick[i].x + brick[i].w / 2 && ball.cy >= brick[i].y && ball.cy <= brick[i].y + brick[i].h  && brick[i].hit == false)
    {
      ball.Right();
      brick[i].Hit();
      score += 1;
      gameScore += 10;
    }
  }

  if (ball.cy > height)
  {
    ball.reset();
    lives -= 1;
  }

  textSize(35);
  fill(#E5D8D3);
  text("Score: ", 400,400);
  text(gameScore, 500, 400);

  textSize(35);
  text("Lives: ", 100, 400);
  text(lives, 200, 400); 

  if (score == total)
  {
    Win();
  }

  if (lives <= 0)
  {
    Lose();
  }
}

void Lose()
{
  background(0);
  fill(#FF0000);
  textSize(50);
  text("Defeat", 215, 200);
  text("Score: ", 200, 300);
  text(gameScore, 350, 300);
  
  ball.cx = -10;
  ball.cy = -10;
  ball.vx = 0;
  ball.vy = 0;

}

void Win()
{ 
  background(0);
  fill(#00FF00);
  textSize(50);
  text("Victory!", 215, 200);
  text("Score: ", 200, 300);
  text(gameScore, 355, 300);
   
  ball.cx = -10;
  ball.cy = -10;
  ball.vx = 0;
  ball.vy = 0;

}
