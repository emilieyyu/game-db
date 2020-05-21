//Use spacebar to shoot, and arrow keys to move character.
//Level One: enemy killed in 2 shots; Powerup by score magnifying glass
//Level Two: enemy killed in 3 shots; Powerup by score magnifying glass, life by potion
//Each level ends by killing all enemies
//Level Three: kill the boss, and avoid getting hit by the boss's weapon
//Note: You cannot hit them but they can hit you. Defeat the boss to win the game

import ddf.minim.*;
Minim minim;
AudioPlayer song;
AudioPlayer shoot;
AudioPlayer kill;
AudioPlayer powerup;
AudioPlayer hurt;

import controlP5.*;
ControlP5 controlP5;
Button how;
Button play;

int score = 0;
int timer;
int life = 10;
int countMons = 3;
int countm = 5;
int countGlass = 5;
PImage monImg;
PImage monTwo;
PImage glasses;
PImage potionImg;
PImage flying[] = new PImage[4];
PImage montwo[] = new PImage[10];
PImage guide;
PImage backdrop;
ArrayList<Monster> monsters = new ArrayList<Monster>();
ArrayList<MonsterTwo> monsterTwo = new ArrayList<MonsterTwo>();
ArrayList<Glasses> glass = new ArrayList<Glasses>();
ArrayList<Potion> potion = new ArrayList<Potion>();
ArrayList<Projectile> bossProjectile = new ArrayList<Projectile>();
GameWorld gw;
Avatar avt;
Boss boss;

final int LEVEL_ONE = 0;
final int LEVEL_TWO = 1;
final int LEVEL_THREE =2;
final int ONE_INTRO = 3;
final int TWO_INTRO = 4;
final int THREE_INTRO =5;
final int WON = 6;
final int LOST = 7;
final int INTRO = 8;

int gameState = INTRO;

void setup(){
  minim = new Minim(this);
  hurt = minim.loadFile("hurt.mp3"); 
  kill = minim.loadFile("kill.mp3");  
  song = minim.loadFile("music.mp3");
  shoot = minim.loadFile("shoot.mp3");
  song.loop();
  
  //create the gameworld first
  gw = new GameWorld();
  gameIntro();
  
  //Create a PFont object
  PFont pfont = createFont("Arial",16,true); 
  play.getCaptionLabel().setFont(pfont);
  how.getCaptionLabel().setFont(pfont);
  size(1100, 700);
  
  //print guide on how to play to screen
  guide = loadImage("char.png");
  guide.resize(guide.width/3, guide.height/3);
  
  //backdrop
  backdrop = loadImage("backdrop.jpg");
  backdrop.resize(1100, 700);
  
  //load the avatar image
  PImage avtImg = loadImage("shoot.png");
  avtImg.resize(avtImg.width/3, avtImg.height/3);
  
  //instantiate the avatar
  avt = new Avatar(avtImg, new PVector(0, height));
  
  //load boss image
  PImage bossImg = loadImage("boss1.png");
  bossImg.resize(bossImg.width/2, bossImg.height/2);
  
  //instantiate the avatar
  boss = new Boss(bossImg, new PVector(width, height/2));
  
  //load the monster image and add the monsters
  for (int i=0; i<flying.length;i++){
     flying[i] = loadImage("enemy"+i+".png");
  }
  for (int i =0; i < countMons; i++){
    spawnMon();
  }
  
  //load the monstertwo image and add the monsters
  for (int i=0; i<montwo.length;i++){
     montwo[i] = loadImage("mon"+i+".png");
  }
  for (int i =0; i < countm; i++){
    spawnMonTwo();
  } 
  
  //load magnifying glass image
  glasses = loadImage("glasses.png");
  glasses.resize(glasses.width/36, glasses.height/36);
  for (int i = 0; i<countGlass; i++){
    spawnGlasses();
  }
    
  //load potion health image
  potionImg = loadImage("potion.png");
  potionImg.resize(potionImg.width/8, potionImg.height/8);
  for (int i = 0; i<1; i++){
    spawnPotion();
  }
}

void draw(){
  //change to display win and lose on screen
  switch (gameState){
  case WON:
    textScreen("You Win!");
    break;    
  case LOST:
    textScreen("You Lose!");
    break;
  case INTRO:
    check();
    break;
  //info screen on level one  
  case ONE_INTRO:
    howOne();
    break;
  case LEVEL_ONE:
    gameOne();
    break;
  //info screen on level two  
  case TWO_INTRO:
    howTwo();
    break;
  case LEVEL_TWO:  
    gameTwo();
    break;
  //info screen on level three
  case THREE_INTRO:
    howThree();
    break;
  case LEVEL_THREE:
    gameThree();
    break;
  }
}

  void mousePressed(){
  while(gameState==INTRO && controlP5.isMouseOver(play)){
    gameState=ONE_INTRO;    
    }
  }
  
//how to play level one
void howOne(){
  background(0);
  controlP5.getController("Start Game").hide();
  controlP5.getController("How to Play").hide(); 
 PFont font = loadFont("Chalkduster-48.vlw");
  textFont(font, 20);
  textAlign(CENTER);
  text("Level One - Enemies need to be hit 2 times before dying.\nMagnifying Glass increase score.\nPress enter to begin.", 550, height/6+150);
}

//how to play level two
void howTwo(){
  background(0);
  controlP5.getController("Start Game").hide();
  controlP5.getController("How to Play").hide(); 
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(20);
  text("Level Two - Enemies need to be hit 3 times before dying.\nPotion is now available to improve health.\nPress enter to begin.", 550, height/6+150);
}

//how to play level three
void howThree(){
  background(0);
  controlP5.getController("Start Game").hide();
  controlP5.getController("How to Play").hide();  
  fill(255, 0, 0);
  textAlign(CENTER);  
  textSize(20);
  text("Level Three - Zombie Boss will die when his health \ndecreases to zero. Avoid his weapons to not be killed.\nPower-ups are no longer available.\n Press enter to begin.", 550, height/6+150);
}

//game introduction
void gameIntro(){
  controlP5 = new ControlP5(this);
  textSize(20);
  how=controlP5.addButton("How to Play", 0, 100, 100, 150, 50);
  play=controlP5.addButton("Start Game", 0, 100, 200, 150, 50);
  mousePressed();
}

//check to see where mouse is on screen
void check(){
  background(backdrop);
  if(!controlP5.isMouseOver(how)){
  PFont font = loadFont("ArialNarrow-Bold-48.vlw");
  textFont(font, 100);
  fill(255, 0, 0);
  text("MOUNT MONSTROSITY", 100, height/2+20);
}
  
  if(controlP5.isMouseOver(how)){
     PFont font = loadFont("Chalkduster-48.vlw");
    textFont(font, 20);
    fill(255, 0, 0);
    text("The Zombie Boss is here and will soon invade the country if he and his \nmonsters are not put to a stop. Kill the monsters and defeat the Boss \nto save the country. Use arrow keys to move and spacebar to shoot \nat the enemies.", 280, height/6);    
    text("Level One - Enemies need to be hit 2 times before dying.\nMagnifying Glass increase score.", 280, height/6+150);
    text("Level Two - Enemies need to be hit 3 times before dying.\nPotion is now available to improve health.", 280, height/6+225);
    text("Level Three - Zombie Boss will die when his health decreases to zero.\nAvoid his weapons to not be killed.", 280, height/6+300);
    image(guide, -10, 405);
  }
  else
    fill(255, 0, 0);
}

//level one of game
void gameOne(){
  controlP5.getController("Start Game").hide();
  controlP5.getController("How to Play").hide();
  gw.display();
  avt.update();

  if (up) avt.move(upForce);
  if (down) avt.move(downForce);
  if (left) avt.move(leftForce);
  if (right) avt.move(rightForce);  

  for (int i =0; i < glass.size(); i++){
    Glasses gla = glass.get(i);

    gla.update();

    if (gla.collision(avt)){
      powerup = minim.loadFile("powerup.mp3");  
      powerup.play();
      avt.boost();
      score+=5;
      glass.remove(gla);
      if (glass.size() < 5) spawnGlasses();
    }
  }

  for (int j =0; j < monsters.size(); j++){
    Monster mon = monsters.get(j);

    mon.update();

    if (mon.collision(avt)){
      avt.hit();
      score-=2;
      monsters.remove(mon);
      if (monsters.size() < 7) spawnMon();
    }

    drawHealthBar();
    if (monsters.size()==0){
      gameState = TWO_INTRO;
      text("Level Two!", 100, 100);
    }
  }
}

//level two of game
void gameTwo(){
  controlP5.getController("Start Game").hide();
  controlP5.getController("How to Play").hide(); 
  gw.display();

  avt.updateTwo();

  if (up) avt.move(upForce);
  if (down) avt.move(downForce);
  if (left) avt.move(leftForce);
  if (right) avt.move(rightForce);

  for (int i =0; i < potion.size(); i++){ 
    Potion ptn = potion.get(i);
    ptn.update();

    if (ptn.collision(avt)){
      powerup = minim.loadFile("powerup.mp3");  
      powerup.play();
      avt.pboost();
      if (life <10)life+=1;
      potion.remove(ptn);
      if (potion.size() < 1) spawnPotion();
    }
  }

  for (int i =0; i < glass.size(); i++){
    Glasses gla = glass.get(i);
    gla.update();

    if (gla.collision(avt)){
      powerup = minim.loadFile("powerup.mp3");  
      powerup.play();     
      avt.boost();
      score+=5;
      glass.remove(gla);
      if (glass.size() < 5) spawnGlasses();
    }
  }

  for (int j =0; j < monsterTwo.size(); j++){
    MonsterTwo mtwo = monsterTwo.get(j);
    mtwo.update();

    if (mtwo.collision(avt)){           
      avt.hit();
      score-=2;
      monsterTwo.remove(mtwo);
      if (monsterTwo.size() < 7) spawnMonTwo();
    }

    drawHealthBar();
    if(monsterTwo.size()==0) gameState = THREE_INTRO;
  }
}

//level three of game
void gameThree(){
  controlP5.getController("Start Game").hide();
  controlP5.getController("How to Play").hide();  
  gw.cave();
  avt.updateThree();
  
  if (up) avt.move(upForce);
  if (down) avt.move(downForce);
  if (left) avt.move(leftForce);
  if (right) avt.move(rightForce); 
  for (int k =0; k < bossProjectile.size(); k++){
    Projectile bossPro = bossProjectile.get(k);
    bossPro.update(bossProjectile);

    if (bossPro.collision(avt)){
      avt.hit();
      bossProjectile.remove(bossPro);
    }

    drawHealthBar();
    bossHealthBar();
  }  
  
  if(boss!=null){
    boss.drawMe();
    boss.update();
  }
    
  if(boss.health == 0){
    timer++;
    if(timer>90) gameState = WON;
     }
  drawHealthBar();
  bossHealthBar();
}
  
void spawnMon(){
  monsters.add(new Monster(new PVector(random(flying[0].width, width), random(flying[0].height/3, height-flying[0].height/3)), new PVector(random(-2,-4), 0)));
}

void spawnMonTwo(){
   monsterTwo.add(new MonsterTwo(new PVector(random(montwo[0].width, width), random(montwo[0].height/6, height-montwo[0].height/6)), new PVector(random(-3, -8), 0)));
}

void spawnGlasses(){
  glass.add(new Glasses(glasses, new PVector(random(glasses.width, width), random(glasses.height, height-glasses.height))));
}

void spawnPotion(){
  potion.add(new Potion(potionImg, new PVector(random(potionImg.width, width), random(potionImg.height, height-potionImg.height))));
}
