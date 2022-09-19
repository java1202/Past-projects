class Maze {

    int rows;
    int cols;
    int grid[][];

    Maze(String file) {
      String[] lines = loadStrings(file);
      rows = lines.length;
      cols = lines[0].length();

      grid = new int[rows][cols];
      for (int r=0; r < grid.length; r++) {
        for (int c=0; c < grid[r].length; c++) {
          int spot = SPACE;
          if (lines[r].charAt(c) == '#') {
            spot = WALL;
          }//wall
          else if (lines[r].charAt(c) == '?') {
            spot = START;
          }//start
          else if (lines[r].charAt(c) == '$') {
            spot = FINISH;
          }
          grid[r][c] = spot;
        }//cols
      } //rows
    }//constructor

    void display() {
      int cellWidth = width / cols;
      int cellHeight = height / rows;

      for (int r=0; r < grid.length; r++) {
        for (int c=0; c < grid[r].length; c++) {
          if (grid[r][c] == WALL) {
            fill(0);
          }//wall fill
          else if (grid[r][c] == SPACE) {
            fill(255);
          }//space fill
          else if (grid[r][c] == START ) {
            fill(0, 255, 0);
          }//start fill
          else if (grid[r][c] == FINISH) {
            fill(255, 0, 0);
          }//end fill
          else if (grid[r][c] == PATH) {
            fill(0, 0, 255);
          }//path fill
          else if (grid[r][c] == VISITED) {
            fill(190);
          }//visited fill
          rect(c*cellWidth, r*cellHeight, cellWidth, cellHeight);
        }//cols
      }//rows
    }//display

    void makeMove(Move m) {
      grid[m.row][m.col] = m.type;
    }//makeMove


    void reset() {
      for (int r=0; r < grid.length; r++) {
        for (int c=0; c < grid[r].length; c++) {
          if (grid[r][c] == PATH || grid[r][c] == VISITED) {
            grid[r][c] = SPACE;
          }
        }//cols
      }//rows
    }//reset

    /*
      Generate a path to solve the maze starting at position [r][c].
      Each time a move is made, add it to ms
      Returns true if the solution has been found, false otherwise.
    */
    boolean solve(int r, int c, MoveList ms) {

      int spot = grid[r][c];
      boolean solved = false;

      //if at end, done!
    
      if (spot == FINISH) {
        return true;
      }

      //if at a wall, or an already visited or path position, this is not a cell on the path, stop
      
      if (spot == WALL | spot==VISITED) {
        return false;
      }
      //At this point, we know that [r][c] is a space, and may be part of the solution
      //Mark [r][c] on the grid as a path, add this position to the move list
     
      grid[r][c]=PATH;
      Move nextMove = new Move(r,c,4);
      ms.add(nextMove);
      grid[r][c]=VISITED;
    
      //Since we're not at the solution, we need to try and solve by moving to neighboring positions.
      //Ruinning solve on a neighboring position will check if it is part of the solution.

      //Check if the position to the right is the solutuion, update the solved variable
    
      if (solve(r,c+1,ms)) {
        solved=true;
      }
     
      //If not solved, go down, update solved
     
      else if (solve(r+1,c,ms)) {
        solved=true;
      }
    
      //If still not solved, go left, update solved
    
      else if (solve(r,c-1,ms) ) {
        solved=true;
      }
    
      //If still not solved, go up, update solved
    
      else if (solve(r-1,c,ms)) {
        solved=true;
      }
     
      //If still not solved, mark this position as visited, but not on the path.
      //Add the position as VISITED to the move list as well.
     
      else {
        grid[r][c]=VISITED;
        nextMove = new Move(r,c,5);
        ms.add(nextMove);
      }
      return solved;
    }//solve

}//Maze
