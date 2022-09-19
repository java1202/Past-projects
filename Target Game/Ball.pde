/* ===================
  This Ball class starts with what we have developed
  in class. You must add some constructors & other methods.
 =================== */
class Ball {
  int cx;
  int cy;
  int xspeed;
  int yspeed;
  int radius;
  color c;

  Ball() {
    c = color(int(random(255)), int(random(255)), int(random(255)));
    radius = int(random(10, 26));
    cx = int(random(radius, width-radius));
    cy = int(random(radius, height-radius));
    xspeed= int(random(-5, 5));
    if (xspeed == 0) { 
      xspeed = 5;
    }
    yspeed = int(random(-5, 5));
    if (yspeed == 0) { 
      yspeed = 5;
    }
  } //constructor

  Ball(color f) {
    this();
    c = f;
  }


/* ===================
  This constructor takes 3 parameters to set 
  the x and y speeds and color. All the 
  other values should be set randomly.
 =================== */
  Ball(int xv, int yv, color f) {
    this();
    xspeed=xv;
    yspeed=yv;
    c=f;
  }

/* ===================
  This constructor takes a parameter for each
  instance variable.
 =================== */
  Ball(int x, int y, int xv, int yv, int r, color f) {
    this();
    cx=x;
    cy=y;
    xspeed=xv;
    yspeed=yv;
    radius=r;
    c=f;
  }

  void display() {
    fill(c);
    circle(this.cx, this.cy, this.radius*2);
  }


  void move() {
    if (cx <= radius || cx >= (width-radius)) {
      xspeed *= -1;
    }
    if ( cy <= radius ||
      cy >= (height-radius)) {
      yspeed *= -1;
    }
    cx+= xspeed;
    cy+= yspeed;
  }
  
/* ===================
  Changes the position for the calling Ball.
  The new position shoudl eb randomly assigned, but the 
  entire ball should always be visible.
 =================== */
  void teleport() {
    if(frameCount%1800==0)
    {
    t.cx = int(random(radius, width-radius));
    t.cy = int(random(radius, height-radius));
    circle(t.cx,t.cy,t.radius); 
    }
  }

/* ===================
  Returns
    true: if the calling Ball is "touching" the paramter ball at all.
    false: in any other case.
    
    There is a built in processing function: dist(x0, y0, x1, y1).
    It returns the distance between (x0, y0) and (x1, y1) as a float.
    It will be helpful here.
 =================== */
  boolean detect(Ball other) {
   if (dist(cx,cy,other.cx,other.cy)<radius+other.radius){
     c=#FF0000;
     fill(c,0,0);
     return true;
   }
   else{
   c=255;
    return false;
   }
  }
  
}
