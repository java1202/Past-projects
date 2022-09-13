import java.util.LinkedList;

class Grid {

  Cell[][] cellGrid = new Cell[15+1][17];
  Cell[] bottomCellGrid= new Cell[6];
  Cell mainCell;

  boolean stopBubbleCollisionCheck = false;

  Color aColor = new Color();

  int bottomNum;

  int populationNum = 9;

  boolean win = false;

  Grid() {
  }

  void populate() {
    for (int i=0; i<15+1; i++) {
      for (int j=0; j<17; j++) {
        if (i % 2 == 0)
          this.cellGrid[i][j] = new Cell(new Bubble((i<populationNum) ? aColor.randomColor() : INV, false), APOTHEM+2*APOTHEM*j, gRADIUS+1.5*gRADIUS*i);
        else
          this.cellGrid[i][j] = new Cell(new Bubble((i<populationNum) ? aColor.randomColor() : INV, false), 2*APOTHEM+(2*APOTHEM*j), gRADIUS+1.5*gRADIUS*i);
      }
    }

    this.bottomNum=aColor.colList2.size();

    for (int i=0; i<6; i++) {
      this.bottomCellGrid[i] = new Cell(new Bubble(INV, (i<bottomNum)), 2*APOTHEM+37*i, gRADIUS+1.5*gRADIUS*16);
    }
    this.bottomCellGrid[0].bubble.col=aColor.randomColor();
    this.mainCell = new Cell(new Bubble(aColor.randomColor(), false), APOTHEM+2*APOTHEM*8, gRADIUS+1.5*gRADIUS*16);
  }

  void drawGrid() {
    for (Cell[] cellRow : this.cellGrid) {
      for (Cell aCell : cellRow) {
        aCell.drawCell();
      }
    }
    for (Cell aCell : this.bottomCellGrid) {
      aCell.drawCell();
    }
    mainCell.drawCell();
  }

  void shootMain() {
    mainCell.bubble.shoot();
  doubleloop:
    for (int i=0; i<15+1; i++) {
      for (int j=0; j<17; j++) {
        if (stopBubbleCollisionCheck)
          break doubleloop;
        if (CGC(i, j) != INV && !stopBubbleCollisionCheck) {
          bubbleCollide(new GridPos(i, j));
        }
      }
    }
    stopBubbleCollisionCheck = false;
    if (mainCell.bubble.yPos<=APOTHEM) {
      bottomCollide();
    }
  }

  void bottomCollide() {

    GridPos g = new GridPos(0, 0);

    float closestDist=dist(cellGrid[0][0].xPos, cellGrid[0][0].yPos, mainCell.bubble.xPos, mainCell.bubble.yPos);

    for (int j=0; j<17; j++) {
      float aCellDist=dist(cellGrid[0][j].xPos, cellGrid[0][j].yPos, mainCell.bubble.xPos, mainCell.bubble.yPos);
      if (aCellDist<closestDist) {
        closestDist=aCellDist;
        g.j=j;
      }
    }

    cellGrid[0][g.j].bubble.col=mainCell.bubble.col;
    bubbleHasCollided(g);
  }

  void bubbleCollide(GridPos g) {

    GridPos newG = new GridPos();

    float actDist=dist(cellGrid[g.i][g.j].xPos, cellGrid[g.i][g.j].yPos, mainCell.bubble.xPos, mainCell.bubble.yPos);
    float collDist=2*mainCell.bubble.apothem-3;

    if (actDist<=collDist) {

      float ang=-atan2(mainCell.bubble.yPos-cellGrid[g.i][g.j].yPos, mainCell.bubble.xPos-cellGrid[g.i][g.j].xPos);

      stopBubbleCollisionCheck=true;

      if (ang <= PI/6 && ang > -PI/6) {
        newG = setBubbleColorAsMainColor(g.i, g.j+1);
      } else if (ang <= 3*PI/6 && ang > PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i-1, g.j);
        } else {
          newG = setBubbleColorAsMainColor(g.i-1, g.j+1);
        }
      } else if (ang <= 5*PI/6 && ang > 3*PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i-1, g.j-1);
        } else {
          newG = setBubbleColorAsMainColor(g.i-1, g.j);
        }
      } else if (ang <= -PI/6 && ang > -3*PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i+1, g.j);
        } else {
          newG = setBubbleColorAsMainColor(g.i+1, g.j+1);
        }
      } else if (ang <= -3*PI/6 && ang > -5*PI/6) {
        if (g.i%2==0) {
          newG = setBubbleColorAsMainColor(g.i+1, g.j-1);
        } else {
          newG = setBubbleColorAsMainColor(g.i+1, g.j);
        }
      } else {
        newG = setBubbleColorAsMainColor(g.i, g.j-1);
      }

      bubbleHasCollided(newG);
    }
  }

  void bubbleHasCollided(GridPos newG) {

    mouse=false;

    checkColorConnections(newG);

    LinkedList<GridPos> topConnectList = checkTopConnectList();

    deleteIfNotConnected(topConnectList);

    checkColorsPresent();

    mainCell.bubble.resetBubble();
    mainCell.bubble.col=bottomCellGrid[0].bubble.col;
    bottomCellGrid[0].bubble.col=aColor.randomColor();

    checkWinLose();
  }

  void checkWinLose() {
    for (int j = 0; j<17; j++) {
      if (CGC(15, j)!=INV) {
        GameOver=true;
        gameOver();
        break;
      }
    }
    if (!GameOver) {
      win=true;
    outerloop:
      for (int i=0; i<15+1; i++) {
        for (int j=0; j<17; j++) {
          if (CGC(i, j)!=INV) {
            win = false;
            break outerloop;
          }
        }
      }
      if (win) {
        Win=true;
        gameOver();
      }
    }
  }

  void checkColorConnections(GridPos g) {
    LinkedList<GridPos> checkPoppingList = new LinkedList<GridPos>();

    checkPopping(g.i, g.j, checkPoppingList);

    if (checkPoppingList.size()<3) {
      bottomNum--;
      changeDrawOutline();
    } else {
      for (GridPos popG : checkPoppingList) {
        cellGrid[popG.i][popG.j].bubble.col = INV;
      }
    }
  }

  void checkPopping(int i, int j, LinkedList<GridPos> checkPoppingList) {
    if (i<=15  && i>=0 && j<=17 && j>=0) {
      if (CGC(i, j)==CGC(i, j+1) && !checkPoppingList.contains(new GridPos(i, j+1))) {
        checkPoppingList.add(new GridPos(i, j+1));
        checkPopping(i, j+1, checkPoppingList);
      }
      if (CGC(i, j)==CGC(i, j-1) && !checkPoppingList.contains(new GridPos(i, j-1))) {
        checkPoppingList.add(new GridPos(i, j-1));
        checkPopping(i, j-1, checkPoppingList);
      }
      if (CGC(i, j)==CGC(i+1, j) && !checkPoppingList.contains(new GridPos(i+1, j))) {
        checkPoppingList.add(new GridPos(i+1, j));
        checkPopping(i+1, j, checkPoppingList);
      }
      if (CGC(i, j)==CGC(i-1, j) && !checkPoppingList.contains(new GridPos(i-1, j))) {
        checkPoppingList.add(new GridPos(i-1, j));
        checkPopping(i-1, j, checkPoppingList);
      }

      if (i%2==0) {
        if (CGC(i, j)==CGC(i+1, j-1) && !checkPoppingList.contains(new GridPos(i+1, j-1))) {
          checkPoppingList.add(new GridPos(i+1, j-1));
          checkPopping(i+1, j-1, checkPoppingList);
        }
        if (CGC(i, j)==CGC(i-1, j-1) && !checkPoppingList.contains(new GridPos(i-1, j-1))) {
          checkPoppingList.add(new GridPos(i-1, j-1));
          checkPopping(i-1, j-1, checkPoppingList);
        }
      } else {
        if (CGC(i, j)==CGC(i+1, j+1) && !checkPoppingList.contains(new GridPos(i+1, j+1))) {
          checkPoppingList.add(new GridPos(i+1, j+1));
          checkPopping(i+1, j+1, checkPoppingList);
        }
        if (CGC(i, j)==CGC(i-1, j+1) && !checkPoppingList.contains(new GridPos(i-1, j+1))) {
          checkPoppingList.add(new GridPos(i-1, j+1));
          checkPopping(i-1, j+1, checkPoppingList);
        }
      }
    }
  }

  LinkedList checkTopConnectList() {

    LinkedList<GridPos> topConnectList = new LinkedList<GridPos>();

    for (int j=0; j<17; j++) {
      if (this.cellGrid[0][j].bubble.col != INV) {
        if (!topConnectList.contains(new GridPos(0, j))) {
          topConnectList.add(new GridPos(0, j));
        }
        checkTopConnect(0, j, topConnectList);
      }
    }

    return topConnectList;
  }

  void checkTopConnect(int i, int j, LinkedList<GridPos> topConnectList) {
    if (CGC(i, j+1)!=INV && j<16 && !topConnectList.contains(new GridPos(i, j+1))) {
      topConnectList.add(new GridPos(i, j+1));
      checkTopConnect(i, j+1, topConnectList);
    }
    if (CGC(i, j-1)!=INV && j>0 && !topConnectList.contains(new GridPos(i, j-1))) {
      topConnectList.add(new GridPos(i, j-1));
      checkTopConnect(i, j-1, topConnectList);
    }
    if (CGC(i+1, j)!=INV && i<15 && !topConnectList.contains(new GridPos(i+1, j))) {
      topConnectList.add(new GridPos(i+1, j));
      checkTopConnect(i+1, j, topConnectList);
    }
    if (CGC(i-1, j)!=INV && i>0 && !topConnectList.contains(new GridPos(i-1, j))) {
      topConnectList.add(new GridPos(i-1, j));
      checkTopConnect(i-1, j, topConnectList);
    }
    if (i%2==0) {
      if (CGC(i+1, j-1)!=INV && i<15 && j>0 && !topConnectList.contains(new GridPos(i+1, j-1))) {
        topConnectList.add(new GridPos(i+1, j-1));
        checkTopConnect(i+1, j-1, topConnectList);
      }
      if (CGC(i-1, j-1)!=INV && i>0 && j>0 && !topConnectList.contains(new GridPos(i-1, j-1))) {
        topConnectList.add(new GridPos(i-1, j-1));
        checkTopConnect(i-1, j-1, topConnectList);
      }
    } else {
      if (CGC(i+1, j+1)!=INV && i<15 && j<16 && !topConnectList.contains(new GridPos(i+1, j+1))) {
        topConnectList.add(new GridPos(i+1, j+1));
        checkTopConnect(i+1, j+1, topConnectList);
      }
      if (CGC(i-1, j+1)!=INV && i>0 && j<16 && !topConnectList.contains(new GridPos(i-1, j+1))) {
        topConnectList.add(new GridPos(i-1, j+1));
        checkTopConnect(i-1, j+1, topConnectList);
      }
    }
  }

  void deleteIfNotConnected(LinkedList<GridPos> topConnectList) {
    LinkedList<GridPos> notConnectedList = new LinkedList<GridPos>();
    for (int i=0; i<15+1; i++) {
      for (int j=0; j<17; j++) {
        if (this.CGC(i, j) != INV && !topConnectList.contains(new GridPos(i, j))) {
          notConnectedList.add(new GridPos(i, j));
        }
      }
    }

    for (GridPos g : notConnectedList) {
      cellGrid[g.i][g.j].bubble.col=INV;
    }
  }

  void changeDrawOutline() {
    if (bottomNum == 0) {
      bottomNum = (int)random(1, aColor.numColors);
      addLines();
    }
    for (Cell aCell : this.bottomCellGrid) {
      aCell.bubble.outline=false;
    }
    for (int i = 0; i<bottomNum; i++) {
      this.bottomCellGrid[i].bubble.outline = true;
    }
  }

  void addLines() {
    int lines = 7 - aColor.numColors;

    for (int i=15+1; i>=0; i--) {
      for (int j=0; j<17; j++) {
        try {
          cellGrid[i+lines][j].bubble.col = CGC(i, j);
        }
        catch (ArrayIndexOutOfBoundsException e) {
        }
      }
    }

    for (int i = 0; i < lines; i++) {
      for (int j=0; j<17; j++) {
        cellGrid[i][j].bubble.col = aColor.randomColor();
      }
    }
  }

  void checkColorsPresent() {
    LinkedList<String> colsToBeRemoved = new LinkedList<String>();

    for (String aCol : aColor.colList2) {
      boolean colorPresent = false;

    doubleLoop:
      for (int i=0; i<15+1; i++) {
        for (int j=0; j<17; j++) {
          if (unhex(aCol) == CGC(i, j) ||
            unhex(aCol) == bottomCellGrid[0].bubble.col ||
            unhex(aCol) == mainCell.bubble.col) {
            colorPresent=true;
            break doubleLoop;
          }
        }
      }
      if (!colorPresent) {
        colsToBeRemoved.add(aCol);
      }
    }
    for (String aCol : colsToBeRemoved) {
      aColor.removeCol(aCol);
    }
  }

  GridPos setBubbleColorAsMainColor(int i, int j) {
    try {
      cellGrid[i][j].bubble.col=mainCell.bubble.col;
    }
    catch (ArrayIndexOutOfBoundsException e) {
    }

    return new GridPos(i, j);
  }

  color CGC(int i, int j) {
    try {
      return this.cellGrid[i][j].bubble.col;
    }
    catch (ArrayIndexOutOfBoundsException e) {

      return color (1, 1, 1, 1);
    }
  }

  String colorName(String hex) {
    if (hex.equals("FFFF0000"))
      return "red";
    else if (hex.equals("FFF0E600"))
      return "yellow";
    else if (hex.equals("FF00FF00"))
      return "green";
    else if (hex.equals("FF00FFFF"))
      return "cyan";
    else if (hex.equals("FF0000FF"))
      return "blue";
    else if (hex.equals("FF7F00FF"))
      return "purple";
    else if (hex.equals("00010101"))
      return "invisible";
    else
      return "";
  }

  void gameOver() {
    arrow.show=false;
    mainCell.bubble.hide=true;
    bottomCellGrid[0].bubble.hide=true;
    mouse=true;
  }
}
