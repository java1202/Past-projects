class Arrow {
  boolean show;
  int length = 60;
  float angle;
  float checkAngle;
  int arrowHeadLength=6;
  float arrowHeadAngle=.1;

  Bubble aBubble;

  Arrow() {
    this.show = true;
  }

  void drawArrow() {
    if (this.show) {
      angle=atan2(mouseY-(gRADIUS+1.5*gRADIUS*16), mouseX-(APOTHEM+2*APOTHEM*8));
      if (angle > -PI+.2 && angle < 0-.2)
        checkAngle = angle;
      stroke(131, 131, 131);
      fill(131, 131, 131);
      line((APOTHEM+2*APOTHEM*8), (gRADIUS+1.5*gRADIUS*16), (APOTHEM+2*APOTHEM*8)+length*cos(checkAngle), (gRADIUS+1.5*gRADIUS*16)+length*sin(checkAngle));
      triangle((APOTHEM+2*APOTHEM*8)+length*cos(checkAngle), (gRADIUS+1.5*gRADIUS*16)+length*sin(checkAngle),
        (APOTHEM+2*APOTHEM*8)+(length-arrowHeadLength)*cos(checkAngle+arrowHeadAngle), (gRADIUS+1.5*gRADIUS*16)+(length-arrowHeadLength)*sin(checkAngle+arrowHeadAngle),
        (APOTHEM+2*APOTHEM*8)+(length-arrowHeadLength)*cos(checkAngle-arrowHeadAngle), (gRADIUS+1.5*gRADIUS*16)+(length-arrowHeadLength)*sin(checkAngle-arrowHeadAngle));
    }
  }
}
