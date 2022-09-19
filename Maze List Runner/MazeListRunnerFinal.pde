int SPACE = 0;
int WALL = 1;
int START = 2;
int FINISH = 3;
int PATH = 4;
int VISITED = 5;

Maze m;
MoveList moves;

void setup() {
  size(600, 600);
  frameRate(10);
  m = new Maze("maze.txt");
  moves = new MoveList();
  m.solve(1, 1, moves);
  m.reset();
  m.display();
}//setup

void draw() {
  m.display();
  if (moves.length() > 0) {
    Move latest = moves.remove();
    m.makeMove(latest);
  }//moves to run
}//draw
