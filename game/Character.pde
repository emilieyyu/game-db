class Character{
  PImage img;
  PVector pos;
  PVector vel;
  int hitTimer = 0;
  int health;
  int timer = 0;
  
  int currentImgIdx =0;
  float damp =0.8;
  
  Character(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = vel;
    hitTimer = 0;
  }
  
  void detectEdges() {//checking edges
    if (pos.x>width+img.width/2) pos.x = -img.width/2;
    if (pos.x<-img.width/2) pos.x = width +img.width/2;
    if (pos.y<-img.height/2) pos.y = height + img.height/ 2;
    if (pos.y>height +img.height/ 2) pos.y = -img.height/ 2;
  }
  
  boolean collision(Avatar other) {//checking collision
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < img.width/2 + other.img.width/2) {
      return true;
    }
    return false;
  }

  void hit(){//if hit
  if(hitTimer ==0){
    health--;
    score++;
    hitTimer=30;
    }
  }
  
  void update(){
    pos.add(vel);
    detectEdges();
    drawMe();
  }

  void drawDyingMe(){}//override
  
  void drawMe(){}//override

}