class GridPos {
  int i;
  int j;

  GridPos() {
  }

  GridPos(int i, int j) {
    this.i = i;
    this.j = j;
  }

  boolean equals(Object o) {
    GridPos aPos = (GridPos) o;
    return (aPos.i == this.i && aPos.j == this.j);
  }
}
