class Monster extends Character{//enemies for level one

  PImage [] flying = new PImage[4];

  Monster(PVector pos, PVector vel) {
    super(pos, vel);
    health = 2;
    for (int i=0; i<flying.length;i++){
     flying[i] = loadImage("enemy"+i+".png");
     flying[i].resize(flying[i].width/3, flying[i].height/3);
    }
    img = flying[currentImgIdx];
  }

  void update() {
    if(health !=0){
      super.update();
      if(pos.x-flying[currentImgIdx].width/2 > width)
        pos.x=-flying[currentImgIdx].width/2;
        
        if(frameCount% 6 ==0){
          currentImgIdx++;
          if(currentImgIdx==flying.length){
            currentImgIdx=0;
          }
        }
    }
    if(hitTimer>0)
      hitTimer--;
    if(health<=0){
      drawDyingMe();
      timer++;
      if(timer>30){
      //kill = minim.loadFile("kill.mp3");
      kill.play(); 
        monsters.remove(this);
        
      }
    }
  }
  
  void drawDyingMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    PImage img= flying[currentImgIdx];
    image(img, -img.width/2, -img.height/2);    
    popMatrix();
  }
  
  void drawMe() {
   if(hitTimer ==0 || hitTimer %2 ==0){ 
    pushMatrix();
    translate(pos.x, pos.y);
    PImage img= flying[currentImgIdx];
    image(img, -img.width/2, -img.height/2);
    popMatrix();
     }
  }
}