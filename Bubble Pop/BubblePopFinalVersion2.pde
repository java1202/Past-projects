/* The game originally had 6 bubble colors but was extremely hard to win. So the default is currently set to 3 colors.
To modify the number of bubble colors, go to Class Color and comment/uncomment the desired colList2 */

int gRADIUS=19;
float APOTHEM = sqrt(3)*gRADIUS/2;
int WIDTH = round(APOTHEM*35)+1;
int HEIGHT = round(gRADIUS+1.5*gRADIUS*18);

Grid grid = new Grid();
Arrow arrow = new Arrow();
HexGrid hexGrid = new HexGrid();

boolean mouse=false;
boolean GameOver=false;
boolean Win=false;

void mousePressed() {
  mouse=true;
}

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  hexGrid.makeHex();
  grid.populate();
}

void draw() {

  background(0);
  stroke(255);
  line(0, gRADIUS+1.5*gRADIUS*14+.75*gRADIUS, WIDTH, gRADIUS+1.5*gRADIUS*14+.75*gRADIUS);

  grid.drawGrid();
  arrow.drawArrow();
  if (mouse) {
    if (!GameOver && !Win) {
      grid.shootMain();
    }
  }

  fill(255);
  textSize(50);
  textAlign(CENTER);
  if (GameOver) {
    text("You lose!", WIDTH/2, HEIGHT/2);
  }
  if (Win) {
    text("You win!", WIDTH/2, HEIGHT/2);
  }
}
