class UpBullet extends Bullet{//level two bullets

  UpBullet(float x, float y, float speedx, float speedy) {
    super(x, y, speedx, speedy);
  }

  void drawMe() {
    pushMatrix();
    strokeWeight(1);
    stroke(0);
    fill(255, 100, 10);
    translate(pos.x, pos.y);
    ellipse(0, 0, 25, 10);
    popMatrix();
  }

}