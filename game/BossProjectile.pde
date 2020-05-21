class Projectile extends Missiles{//actual projectile that the boss shoots out
  int hitTimer = 0;
  int timer = 0;  
  
  PImage img;
  int currentImgIdx =0;
  PImage [] weapon = new PImage[4];

  Projectile(float x, float y, float speedx, float speedy) {
     super(x, y, speedx, speedy);
     for (int i=0; i<weapon.length;i++){
     weapon[i] = loadImage("weapon"+i+".png");
     weapon[i].resize(weapon[i].width/4, weapon[i].height/4);
    }
    img = weapon[currentImgIdx];
  }
  
  void update(ArrayList bossProjectile) {
    super.update();
    if (dist(avt.pos.x, avt.pos.y, pos.x, pos.y) < avt.img.width/2 + img.width/2){   
      avt.hit();
      avt.health-=2;
      bossProjectile.remove(this);
    }
    if(pos.x-weapon[currentImgIdx].width/2 > width)
        pos.x=-weapon[currentImgIdx].width/2;
        
        if(frameCount% 6 ==0){
          currentImgIdx++;
          if(currentImgIdx==weapon.length){
            currentImgIdx=0;
          }
        }
        
    if (pos.y > height) {
      bossProjectile.remove(this);
    }
    if (pos.x <0) {
      bossProjectile.remove(this);
    }
    if (pos.x >width) {
      bossProjectile.remove(this);
    }
    if(pos.y<0){
      bossProjectile.remove(this);
    }
  }
  
  boolean collision(Avatar other) {//check collision with player
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < img.width/2 + other.img.width/2){
      return true;
    }
    return false;
  }  
  

  void drawMe() {
    if(hitTimer ==0 || hitTimer %2 ==0){ 
    pushMatrix();
    translate(pos.x, pos.y);
    PImage img= weapon[currentImgIdx];
    image(img, -img.width/4, -img.height/4);
    popMatrix();
    }
  }
}
  