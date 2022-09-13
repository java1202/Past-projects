class HexGrid {

  PShape hexagon;
  int WIDTH = round(APOTHEM*35)+1;
  int HEIGHT = round(gRADIUS+1.5*gRADIUS*18);

  float angle=30.0*PI/180.0;
  float sixty=0.0;

  void makeHex() {
    hexagon = createShape();
    hexagon.beginShape();

    for (int i = 0; i<=6; i++) {
      hexagon.vertex(gRADIUS*cos(angle+sixty), gRADIUS*sin(angle+sixty));
      sixty+=60.0*PI/180.0;
    }
    hexagon.endShape();
  }

  void drawHexGrid() {
    for (int i=0; i<15+1; i++) {
      if (i % 2 == 0) {
        for (int j=0; j<17; j++) {
          shape(hexagon, (APOTHEM+2*APOTHEM*j), (gRADIUS+1.5*gRADIUS*i));
        }
      } else {
        for (int j=0; j<17; j++) {
          shape(hexagon, 2*APOTHEM+(2*APOTHEM*j), gRADIUS+1.5*gRADIUS*i);
        }
      }
    }
  }
  void drawNumGrid() {
    textSize(10);
    textAlign(CENTER);
    fill(0);
    for (int i=0; i<15+1; i++) {
      if (i % 2 == 0) {
        for (int j=0; j<17; j++) {
          text(str(i) + " " + str(j), (APOTHEM+2*APOTHEM*j), (gRADIUS+1.5*gRADIUS*i));
        }
      } else {
        for (int j=0; j<17; j++) {
          text(str(i) + " " + str(j), 2*APOTHEM+(2*APOTHEM*j), gRADIUS+1.5*gRADIUS*i);
        }
      }
    }
  }
}
