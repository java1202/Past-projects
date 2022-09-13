color RED = color (255, 0, 0, 255);
color YEL = color (240, 230, 0, 255);
color GRE = color (0, 255, 0, 255);
color CYA = color (0, 255, 255, 255);
color BLU = color (0, 0, 255, 255);
color PUR = color (127, 0, 255, 255);
color INV = color (1, 1, 1, 0);

class Color {

  ArrayList<String> colList2 = new ArrayList<String>();
  int numColors;

  String hRED = hex(color (255, 0, 0, 255));
  String hYEL = hex(color (240, 230, 0, 255));
  String hGRE = hex(color (0, 255, 0, 255));
  String hCYA = hex(color (0, 255, 255, 255));
  String hBLU = hex(color (0, 0, 255, 255));
  String hPUR = hex(color (127, 0, 255, 255));
  String hINV = hex(color (1, 1, 1, 0));

  Color() {
    colList2.add(hRED);
    colList2.add(hYEL);
    colList2.add(hGRE);
    //colList2.add(hCYA);
    //colList2.add(hBLU);
    //colList2.add(hPUR);
    
    
    numColors=colList2.size();
  }

  color randomColor() {
    int rand = int(random(0, numColors));
    return unhex(this.colList2.get(rand));
  }

  void removeCol(String col) {
    colList2.remove(col);
    numColors=colList2.size();
  }
}
