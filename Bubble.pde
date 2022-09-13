class Bubble {

  int radius=17;
  float apothem = sqrt(3)*radius/2; 

  color col;
  boolean outline;
  float angle;
  boolean updated = false;
  boolean shot = false;
  boolean inCell = true;
  boolean hide = false;
  float xPos;
  float yPos;
  float dx;
  float dy;
  int vel = 11;

  Bubble(color col, boolean outline) {
    this.col = col;
    this.outline = outline;
  }

  void move() {
    if (shot && !inCell) {

      this.xPos+=this.dx;
      this.yPos+=this.dy;

      if (this.xPos <= 0+radius || this.xPos >= WIDTH-radius)
        this.dx=-this.dx;
    }
  }

  void drawBubble() {
    if (outline){
      stroke(255);
      strokeWeight(3);
    }
    else
      noStroke();
    fill(this.col);
    if (!hide)
      circle(this.xPos, this.yPos, 2*apothem);
  }

  void shoot() {

    if (!this.updated) {
      this.inCell=false;
      this.angle = arrow.checkAngle;
      this.dx = this.vel*cos(this.angle);
      this.dy = this.vel*sin(this.angle);
      arrow.show=false;
      this.shot = true;
      this.updated=true;
    }
    this.move();
  }
  void resetBubble() {
    this.updated=false;
    arrow.show=true;
    this.shot=false;
    this.inCell=true;
  }
}
