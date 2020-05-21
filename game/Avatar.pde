class Avatar{//character the player has control over
  
  PImage img;
  PVector pos, vel;
  float damp = 0.8;
  int score = 0;
  int maxHealth = 10;
  int health = maxHealth;
  int fireTimer = 0;
  float healthPercentage = 1;
  
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<UpBullet> upbullet = new ArrayList<UpBullet>();  
  ArrayList<Upgrade> upgrade = new ArrayList<Upgrade>();

  
  Avatar(PImage img, PVector pos){
    this.img = img;
    this.pos = pos;
    vel = new PVector();
  }
  
  void move(PVector acc) {
    vel.add(acc);
  }

  void update() {//update level one
    vel.mult(damp);
    pos.add(vel);
    drawMe();
    if(fireTimer>0) fireTimer--;
    for(int i= 0; i<bullets.size();i++){
      Bullet currBullet = bullets.get(i);
      currBullet.update(bullets);
    }
    //boundary detection. just keep the player from going off the walls.
    if(pos.x < 0     + img.width / 2) pos.x = 0     + img.width / 2;
    if(pos.x > width - img.width / 2) pos.x = width - img.width / 2;
    if(pos.y > height- img.height/ 2) pos.y = height- img.height / 2;
    if(pos.y < 0     + img.height/ 2) pos.y = 0     + img.height / 2;
   
    drawMe();
  }
  
  void updateTwo() {//update level two
    vel.mult(damp);
    pos.add(vel);
    drawMe();
    if(fireTimer>0) fireTimer--;
    for(int i= 0; i<upbullet.size();i++){
      UpBullet nextBullet = upbullet.get(i);
      nextBullet.updateTwo(upbullet);
    }
    //boundary detection. just keep the player from going off the walls.
    if(pos.x < 0     + img.width / 2) pos.x = 0     + img.width / 2;
    if(pos.x > width - img.width / 2) pos.x = width - img.width / 2;
    if(pos.y > height- img.height/ 2) pos.y = height- img.height / 2;
    if(pos.y < 0     + img.height/ 2) pos.y = 0     + img.height / 2;
   
    drawMe();
  }  
  
  void updateThree(){//update level three
    vel.mult(damp);
    pos.add(vel);
    drawMe();
    if(fireTimer>0) fireTimer--;
    for(int i= 0; i<upgrade.size();i++){
      Upgrade newUpgrade = upgrade.get(i);
      newUpgrade.updateThree(upgrade);
    }
    //boundary detection. just keep the player from going off the walls.
    if(pos.x < 0     + img.width / 2) pos.x = 0     + img.width / 2;
    if(pos.x > width - img.width / 2) pos.x = width - img.width / 2;
    if(pos.y > height- img.height/ 2) pos.y = height- img.height / 2;
    if(pos.y < 0     + img.height/ 2) pos.y = 0     + img.height / 2;   
    drawMe();
  }
  
  void fire() {//shooting level one
    //shoot = minim.loadFile("shoot.mp3");
    if(fireTimer ==0){
    bullets.add(new Bullet(pos.x+40, pos.y-25, 15, 0));
    shoot.play(); 
    fireTimer=45;
    }
}
  void firetwo() {//shooting level two
    //shoot = minim.loadFile("shoot.mp3");    
    if(fireTimer ==0){
    upbullet.add(new UpBullet(pos.x+40, pos.y-25, 15, 0));
    shoot.play();
    fireTimer=45;
    }
}
  void upfire() {//shooting level three
    //shoot = minim.loadFile("shoot.mp3");    
    if(fireTimer ==0){
    upgrade.add(new Upgrade(pos.x+40, pos.y-25, 15, 0));
    shoot.play();
    fireTimer=45;
    }
}
  
  void hit() {//when player is hit
    health--;
    score -=2;
    //check if the health is 0 (the player has lost)
    if(health == 0) {
    //if yes, then tell the game we've lost
     gameState = LOST;
    }
    //and always replace the character in corner of screen
    //hurt = minim.loadFile("hurt.mp3");
    hurt.play();
    pos.x = 0;
    pos.y = height;
    //and update the health percentage
    healthPercentage = (float)health / (float)maxHealth; 
  }
  
  void boost(){//boost in score
    score+=5;
  }
  
  void pboost(){//boost in health
    if(health<10)
    health+=1;
    healthPercentage = (float)health / (float)maxHealth;
  }
  
  void drawMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    //draw the image
    image(img,0-img.width/2,0-img.height/2);
    popMatrix();
  }
}