class Missiles{//missiles shot out

  PVector pos, vel;
  Missiles(float x, float y, float speedx, float speedy){
    pos = new PVector(x, y);
    vel = new PVector(speedx, speedy);
  }  
  
  void update(){
    move();
    drawMe();
  }

  void move() {
    pos.add(vel);
  }

  void drawMe(){}
}