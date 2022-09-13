class Grid {

  int x; 
  int y;
  int size;
  int state;

  Grid(int x0, int y0, int size0, int state0) {
    x = x0; 
    y = y0;
    size = size0;
    state = state0;
  }

  void display() {
    stroke(255);
    if (state == LETTER_IN_PLACE) {
      fill(#526b48);
    }
    else if (state == LETTER_IN_WORD) {
      fill(#F6BE00);
    }
    else if (state == WRONG_ATTEMPT) {
      fill(#8b0000);
    }
    else if (state == CLEAN) {
      fill(0);
    }
   
    square(x, y, size);
  }
  
  void changeState(int nextState){
    state = nextState;
  }
 
}
