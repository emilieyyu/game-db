class Glasses extends PowerUp {//new PowerUp Feature, increases score

  Glasses(PImage img, PVector pos) {
    super(img, pos);
  }

  void drawMe() {
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0-img.width/2, 0-img.height/2);
    popMatrix();
  }
}