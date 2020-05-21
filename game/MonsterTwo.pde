class MonsterTwo extends Character{//enemies for level two
  
  PImage [] montwo = new PImage[10];

  MonsterTwo(PVector pos, PVector vel) {
    super(pos, vel);
    health = 3;
    for (int i=0; i<montwo.length;i++){
     montwo[i] = loadImage("mon"+i+".png");
     montwo[i].resize(montwo[i].width/6, montwo[i].height/6);
    }
    img = montwo[currentImgIdx];
  }
  
  void update() {
    if(health !=0){
      super.update();
      if(pos.x-montwo[currentImgIdx].width/2 > width)
        pos.x=-montwo[currentImgIdx].width/2;
        
        if(frameCount% 6 ==0){
          currentImgIdx++;
          if(currentImgIdx==montwo.length){
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
        monsterTwo.remove(this);
      }
    }
  }
  
  void drawDyingMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    //image(img, 0-img.width/2, 0-img.height/2);
    PImage img= montwo[currentImgIdx];
    image(img, -img.width/2, -img.height/2); 
    popMatrix();
  }
  
  void drawMe() {
   if(hitTimer ==0 || hitTimer %2 ==0){ 
    pushMatrix();
    translate(pos.x, pos.y);
    //image(img, 0-img.width/2, 0-img.height/2);
    PImage img= montwo[currentImgIdx];
    image(img, -img.width/2, -img.height/2); 
    popMatrix();
     }
  }
}