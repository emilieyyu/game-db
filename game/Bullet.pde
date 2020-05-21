class Bullet extends Missiles{//what the player shoots out

  int hitTimer = 0;
  Bullet(float x, float y, float speedx, float speedy) {
    super(x, y, speedx, speedy);
  }

  void update(ArrayList bullets) {//update for level one
    super.update();
    for (int i = 0; i < monsters.size(); i++) {
      Monster monster = monsters.get(i);
      if (dist(monster.pos.x, monster.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {       
        monster.hit();
        score+=3;
        bullets.remove(this);
      }
      if(monsters.size()==0) gameState = TWO_INTRO;
    }
    if (pos.y < 0)
      bullets.remove(this);
  }
  
  void updateTwo(ArrayList upbullets) {//update for level two
    super.update();
    for (int i = 0; i < monsterTwo.size(); i++) {
      MonsterTwo monsTwo = monsterTwo.get(i);
      if (dist(monsTwo.pos.x, monsTwo.pos.y, pos.x, pos.y) < 50 / 2 + 10 / 2) {     
        monsTwo.hit();
        score+=4;
        upbullets.remove(this);
      }
      if(monsterTwo.size()==0) gameState=WON;
    }
    if (pos.y < 0)
      upbullets.remove(this);
  }
  
  void updateThree(ArrayList upgrade) {//update for level three
    super.update();
     if (dist(boss.pos.x, boss.pos.y, pos.x, pos.y) < boss.img.width/ 2 + avt.img.width/ 2) {
      kill = minim.loadFile("kill.mp3");
      kill.play();        
       boss.hit();
        score+=5;
        upgrade.remove(this);    
    if (pos.y < 0)
      upgrade.remove(this);
      }
   }

  void drawMe() {
    pushMatrix();
    strokeWeight(1);
    stroke(0);
    fill(255, 209, 48);
    translate(pos.x, pos.y);
    ellipse(0, 0, 20, 10);
    popMatrix();
  }
}