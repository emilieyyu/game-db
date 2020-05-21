class PowerUp{//powerups available in the game
  PImage img;
  PVector pos;
  
  PowerUp(PImage img, PVector pos) {
    this.img = img;
    this.pos = pos;
  }
  void detectEdges() {   
    if (pos.x>width+img.width/2) pos.x = -img.width/2;
    if (pos.x<-img.width/2) pos.x = width +img.width/2;
    if (pos.y<-img.height/2) pos.y = height + img.height/ 2;
    if (pos.y>height +img.height/ 2) pos.y = -img.height/ 2;
  }

  boolean collision(Avatar other) {//check to see collision detection
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < img.width/2 + other.img.width/2) {
      return true;
    }
    return false;
  }
  
  void update() {
    detectEdges();
    drawMe();
  }
  
  void drawMe(){}//override

}