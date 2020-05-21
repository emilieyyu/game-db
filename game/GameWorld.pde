class GameWorld {
  //class that represents the game world.
  //the game world is an image
  PImage bg;
  PImage cave;

  GameWorld() {
    //load the background image
    bg = loadImage("back.jpg");
    bg.resize(1100, 700);
    cave = loadImage("cave.jpg");
    cave.resize(1100, 700);
  }

  void display() {//for level one and level two
    //display the image
    image(bg,0,0);
  }
  
  void cave(){//background for level three
    image(cave, 0, 0);
  }
}