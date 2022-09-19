/* ===================
 The goal of this program is to create a game with 2 balls.
 One ball will be the "target" and the other will be the player
 controlled ball.
 
 The target ball should 
   have no speed, 
   be randomly placed within the screen, 
   have a random size in the range [10, 25],
   be green.
   
 The player contolled ball should 
   start with no speed, 
   be placed in the middle of the screen
   have a radius of 20
   start white
 
 During the game, the user should be able to change the
 speed of the player ball with the WASD keys. Note this 
 should not change the position of the ball directly, 
 just the velocities.
 
 If the any part of the player ball comes in contact 
 with the target ball, the player ball should turn red.
 If the player ball is not touching the target ball, the
 player ball should be white.
 
 Read through the comments for each function, some things have already been done for you.
 =================== */

/* ===================
 Global variables:
 b: The player ball controlled by keyboard commands
 target: The target ball 
 =================== */
Ball b1;
Ball t;


/* ===================
 setup:
 1. Call size() (done)
 2. Set framerate to 60 (done)
 2. Create the target ball using the most 
 appropriate constructor, following the 
 guidelines listed above. (done)
 3. Create the player ball using the most 
 appropriate constructor, following the 
 guidelines listed above. (done)
 =================== */
void setup() {
  size(600, 600);
  frameRate(60);
  t=new Ball(0,0,#00FF00);
  b1=new Ball(width/2,height/2,0,0,20,#FFFFFF);
  
}

/* ===================
 draw:
 1. Set the background (done)
 2. Call display() on the plyaer ball and target. (done)
 3. Call move() on the player ball. (done) 
 4. Use the detect method to change the player ball's color
    accordingly.
 5. Every 30 seconds, the target should call teleport().
     framCount is a built in processing variable that 
     stores the current frame number, it would be useful here.
 =================== */
void draw() {
  background(0);
  b1.display();
  t.display();
  b1.move();
  b1.detect(t);
  b1.teleport();

}


/* ===================
 keyPressed:
 Change the speeds of the player ball with keystrokes as follows
   'w' : y speed - 1
   'a' : x speed - 1
   's' : y speed + 1
   'd' : x speed + 1
 =================== */
 void keyPressed() {
 if (key=='w'){
   b1.yspeed=b1.yspeed-1;
 }
 if (key=='a'){
  b1.xspeed=b1.xspeed-1;
 }
 if (key=='s'){
   b1.yspeed=b1.yspeed+1;
 }
 if (key=='d'){
   b1.xspeed=b1.xspeed+1;
 }
}
