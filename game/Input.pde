
float speed = 2;

PVector upForce = new PVector(0, -speed);
PVector downForce = new PVector(0, speed);
PVector leftForce = new PVector(-speed, 0);
PVector rightForce = new PVector(speed, 0);
boolean up, down, left, right;
void keyPressed() {

  if(key == ENTER){
    if(gameState == ONE_INTRO)gameState=LEVEL_ONE;
  }
  if(key == ENTER){
    if(gameState == TWO_INTRO)gameState=LEVEL_TWO;
  }
  if(key == ENTER){
    if(gameState == THREE_INTRO)gameState=LEVEL_THREE;
  }  

  if(gameState==LEVEL_ONE)
    if(key == ' ')avt.fire();
  if(gameState==LEVEL_TWO)
    if(key ==' ')avt.firetwo();
  if(gameState==LEVEL_THREE)
    if(key == ' ')avt.upfire();
  if (key == CODED) {
    if (keyCode == UP) up = true;
    else if (keyCode == DOWN) down = true;
    else if (keyCode == LEFT) left = true;
    else if (keyCode == RIGHT) right = true;
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) up = false;
    else if (keyCode == DOWN) down = false;
    else if (keyCode == LEFT) left = false;
    else if (keyCode == RIGHT) right = false;
  }
}
/////////////////////////////////////////////////

void drawHealthBar() {
  int healthBarWidth = 200;
  pushMatrix();
  fill(0, 64);
  translate(20, 20);
  rect(0, 0, healthBarWidth, 20); //container for health
  fill(255, 0, 0, 255);
  rect(0, 0, healthBarWidth * avt.healthPercentage, 20); //health bar
  fill(255);
  textSize(25);
  text("Score: "+ score, 55, 50);
  popMatrix();
}

void bossHealthBar() {
  int healthBarWidth = 200;
  pushMatrix();
  fill(0, 64);
  translate(20, 20);
  rect(850, 0, healthBarWidth, 20); //container for health
  fill(0, 0, 255, 255);
  rect(850, 0, healthBarWidth * boss.healthPercentage, 20); //health bar
  fill(255);
  popMatrix();
} 

void textScreen(String str) {
  background(backdrop);
  PFont font = loadFont("Copperplate-48.vlw");
  fill(255, 0, 0);
  textFont(font, 60);
  text(str, width/2-55, height/2);
  text("Final Score:" +score, width/2-55, height/2-50);
}