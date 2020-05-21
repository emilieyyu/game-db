class Upgrade extends Bullet{//level three bullets

  Upgrade(float x, float y, float speedx, float speedy) {
    super(x, y, speedx, speedy);
  }

  void drawMe() {
    pushMatrix();
    strokeWeight(1);
    stroke(0);
    fill(255, 0, 24);
    translate(pos.x, pos.y);
    ellipse(0, 0, 30, 10);
    popMatrix();
  }

}