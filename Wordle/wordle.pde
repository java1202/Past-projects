int LETTER_IN_PLACE = 0;
int LETTER_IN_WORD = 1;
int WRONG_ATTEMPT = 2;
int CLEAN = 3; 

Grid grid[][];
Table reasonable; 
Table all; 
String target; 
String guess = ""; 
String g1 = ""; 
String g2 = ""; 
String g3 = ""; 
String g4 = ""; 
String g5 = ""; 
String g6 = "";
int guesses = 1;
int guessRow = 0; 
int guessCol = 0;
int textY = 0;
boolean gameWon = false;

void setup(){
  reasonable = loadTable("words_reasonable.csv"); 
  all = loadTable("words.csv");
  target = reasonable.getString(0, int(random(2310)));
  
  size(500,600);
  background(0);
  
  makeGrid(5, 6);
  drawGrid();
  
  textAlign(LEFT,TOP);
  textSize(90);
} //setup

void draw() {
  drawGrid();
  drawText(guess, guessRow); 
  drawText(g1, guessRow - 1);
  drawText(g2, guessRow - 2); 
  drawText(g3, guessRow - 3); 
  drawText(g4, guessRow - 4); 
  drawText(g5, guessRow - 5);
  drawText(g6, guessRow - 6);
} // draw

void drawGrid() {
  for (int r = 0; r < grid.length; r++) {
    for (int i = 0; i < grid[r].length; i++) {
      grid[r][i].display();
    }}
} // drawGrid

void makeGrid(int numCols, int numRows) {
  grid = new Grid[numRows][numCols];
  int gridSize = width / numCols;
  int state;
  for (int r = 0; r < grid.length; r++) {
    for (int i = 0; i < grid[r].length; i++) {
      state = CLEAN;
      grid[r][i] = new Grid(i * gridSize, r * gridSize, gridSize, state);
    }}
} //makeGrid

void keyPressed() {
  if (key == ENTER && guess.length() == 5) {
    if (checkIfValid(guess) == false) {
      println("Not a real word");
      background(255,0,0);
    }
    else {
      changeState();
      if (ifAnswer(guess) == true) {
        gameWon = true;
        println("Won in " + guesses);
      }
      g6 = g5; g5 = g4; g4 = g3; g3 = g2; g2 = g1;
      g1 = guess;
      
      guess = "";
      guesses++;
      guessRow++;
      textY = (height / 6) * guessRow;
    }
  }
    
  if ((int(key) >= 97) & (int(key) < 123) & gameWon == false && guesses < 7) {
    if (guess.length() < 5) {
      guess = guess + key;
    }
    drawText(guess, guessRow);
  }
  
  if (int(key) == 8 && guess.length() > 0) {
    guess = guess.substring(0, guess.length() - 1);
  }
} // keyPressed

boolean checkIfValid(String guess) {
  for (int i = 0; i < all.getColumnCount(); i++) {
    if (guess.equals(all.getString(0,i))) {
      return true;
    }}
  return false;
} //checkIfValid

void changeState() {
  for (int i = 0; i < grid[0].length; i++) {
    if (ifCorrect(i) == true) {
      grid[guessRow][i].state = LETTER_IN_PLACE;
    }
    else if (ifWrong(i) == true) {
      grid[guessRow][i].state = WRONG_ATTEMPT;
    }
    else {
      grid[guessRow][i].state = LETTER_IN_WORD;
    }    }
} //changeState

boolean ifAnswer(String guess) {
  if (guess.equals(target)) {
    return true;
  }
  return false; 
} // ifAnswer

boolean ifCorrect(int i) {
  if(guess.charAt(i) == target.charAt(i)){
      return true;
    }
  return false;
} // ifCorrect

boolean ifWrong(int i) {
  for(int p = 0; p < target.length(); p++) {
    if(guess.charAt(i) == target.charAt(p)) {
      return false;
    }
  }
  return true;
} // ifWrong

void drawText(String word, int row) {  
  fill(255);
  for (int i = 0; i < word.length(); i++) {
    text(word.charAt(i), (width / 5) * i, (height / 6) * row);
  }
  guessCol = 0;
} //drawText
