class Boss{//big boss that appears in level three
  
  PImage img;
  PVector pos;
  PVector vel;  

  float damp = 0.8;
  int state;
  int hitTimer = 0;
  int timer = 0;
  int maxHealth = 50;
  int health = maxHealth;
  float healthPercentage = 1;
  
  ArrayList<Projectile> bossProjectile = new ArrayList<Projectile>();

  Boss(PImage img, PVector pos){
    this.img = img;
    this.pos = pos;
    vel = new PVector();
    health = 50;
    state = 1;
  }
  
  void checkProjectile() {
    for (int i=0; i<bossProjectile.size(); i++) {
      Projectile currProjectile=bossProjectile.get(i);
      currProjectile.update(bossProjectile);
      }
   }
   
  void move() {
    pos.add(vel);
    vel.mult(damp);
  }  
  
  void update() {
    if(health!= 0){
      move();
      if(pos.x < 0     + img.width / 2) pos.x = 0     + img.width / 2;
      if(pos.x > width - img.width / 2) pos.x = width - img.width / 2;
      if(pos.y > height- img.height/ 2) pos.y = height- img.height / 2;
      if(pos.y < 0     + img.height/ 2) pos.y = 0     + img.height / 2;   
      drawMe();
    if (hitTimer>0) {
      hitTimer --; 
      }
    checkProjectile();
    if(frameCount % 30 ==0){
      boss.fireBoss();
      }
    }
    if (health <= 0) {
      drawDyingMe();

    }
    if (boss.collision(avt)) {
      avt.hit();
      avt.health=avt.health-2;
      score=score-5;
    }
    
    if(health >=0){
    println(health);
    }
  }
  
  boolean collision(Avatar other) {//collision check
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < img.width/2 + other.img.width/2) {
      return true;
    }
    return false;
  }  
  
  void fireBoss() {//boss firing at player
    bossProjectile.add(new Projectile(pos.x,pos.y, random(-5), random(-3, 3)));
  }

  void hit() {//if boss is hit
    if (hitTimer==0) {
      health-=5;
      score+=5;
      hitTimer = 30;
      healthPercentage = (float)health / (float)maxHealth;
     }
   }
 
 void drawDyingMe() { //override
    pushMatrix();
    translate(pos.x, pos.y);
    image(img,0-img.width/2,0-img.height/2);
    popMatrix();
  }  
  
  void drawMe() {
      if (hitTimer == 0 || hitTimer % 2 == 0) {
        pushMatrix();
        translate(pos.x, pos.y);
        image(img,0-img.width/2,0-img.height/2);
        popMatrix();
      }
  }
}