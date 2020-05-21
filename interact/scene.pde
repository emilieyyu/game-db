//defining colours of each object
color windows = color(147, 191, 217);
color chimney = color(111, 119, 166);
color leaves = color(74, 170, 41);
color sand = color (246, 255, 226);
color ocean = color(57, 146, 250);
color path = color(102, 140, 129);
color door = color(156, 187, 249);
color stone = color(125, 151, 67);
color pineapple = color(240, 114, 0);

//defining stroke colours
color windowLine = color(63, 89, 183);
color chimneyLine = color(133, 163, 218);
color houseLine = color(192, 45, 0);
color pathLine = color(58, 94, 65);

//declaring rotation variable and speed
float rot;
float rotspd = 0.03;

void setup(){
  size(1200,700);
}

//drawing out scene + animation
void draw(){
  drawBG();
  star(rot);
    rot = rot + rotspd;
  bubbles(mouseX, mouseY);
}

//drawing bubbles to follow cursor
void bubbles(float x, float y){
  strokeWeight(2);
  pushMatrix();
  translate(x,y);
  
  //drawing bubbles
  fill(255);
  stroke(156, 217, 241);
  ellipse(20, 20, 20, 20);
  ellipse(30, 30, 15, 15);
  ellipse(10, 15, 10, 10);
  popMatrix();
}

//background scene
void drawBG(){
  background(ocean);
  
  //drawing sand
  fill(sand);
  stroke(0);
  rect(450, 530, 300, 300);
  noStroke();
  quad(0, 500, 200, 515, 200, 700, 0, 700);
  quad(200, 515, 300, 530, 300, 700, 200, 700);
  quad(300, 530, 455, 530, 455, 700, 300, 700);
  quad(745, 530, 880, 540, 880, 700, 745, 700);
  quad(880, 540, 1000, 520, 1000, 700, 880, 700);
  quad(1000, 520, 1200, 500, 1200, 700, 1000, 700);
  
  //drawing path + stones
  fill(path);
  stroke(pathLine);
  strokeWeight(2);
  quad(550, 600, 650, 600, 700, 700, 500, 700);
  ellipseMode(CORNER);
  fill(stone);
  ellipse(530, 675, 75, 20);
  ellipse(640, 685, 30, 10);
  ellipse(590, 650, 80, 20);
  ellipse(530, 650, 45, 15);
  ellipse(550, 620, 90, 25);
  ellipse(620, 605, 30, 10);
  
  //drawing house + green leaves
  fill(leaves);
  noStroke();
  rect(575, 190, 50, 120);
  triangle(575, 190, 600, 110, 625, 190);
  arc(610, 150, 50, 170, 2.0944+PI,2.0944+2*PI);
  arc(540, 150, 50, 170, PI-2.0944,2*PI-2.0944);
  arc(640, 200, 30, 150, 2.54+PI,2.54+2*PI);
  arc(530, 200, 30, 150, PI-2.54,2*PI-2.54);
  
  //drawing pineapple house
  stroke(0);
  fill(pineapple);
  arc(450, 300, 300, 600, PI, 2*PI);
  stroke(houseLine);
  strokeWeight(3);
  curve(500, 350, 520, 350, 730, 450, 730, 450);
  curve(480, 420, 480, 420, 750, 550, 750, 550);
  line(460, 510, 680, 600);
  line(650, 320, 490, 390);
  line(700, 390, 460, 500);
  line(730, 470, 450, 595);
  line(750, 550, 680, 600);
  noStroke();
  strokeWeight(1);
  stroke(0);
  line(450, 600, 750, 600);
  
  //drawing door
  fill(door);
  arc(550, 500, 100, 200, PI, 2*PI );
  
  //drawing two windows
  ellipseMode(CORNER);
  stroke(windowLine);
  strokeWeight(1.7);
  fill(133, 163, 218);
  ellipse(660, 500, 50, 50);
  fill(windows);
  ellipse(670, 510, 30, 30);
  fill(133, 163, 218);
  ellipse(510, 420, 60, 60);
  fill(windows);
  ellipse(520, 430, 40, 40);
  
  //drawing chimney
  fill(chimney);
  triangle(715, 330, 740, 330, 727, 385);
  rect(690, 375, 30, 15);
  rect(720, 365, 15, 25);
}

//animation for star rotation
void star(float r){
  pushMatrix();
  translate(600, 560);
  rotate(r);
  noFill();
  stroke(1);
  strokeWeight(1.5);
  triangle(0, -20, 25, 10, -25, 10);
  triangle(-25, -10, 20, -10, 0, 20);
  popMatrix();
}
