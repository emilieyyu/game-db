//fills
color windows = color(147, 191, 217);
color chimney = color(111, 119, 166);
color leaves = color(74, 170, 41);
color sand = color (246, 255, 226);
color ocean = color(57, 146, 250);
color path = color(102, 140, 129);
color door = color(156, 187, 249);
color stone = color(125, 151, 67);
color pineapple = color(240, 114, 0);

//strokes
color windowLine = color(63, 89, 183);
color chimneyLine = color(133, 163, 218);
color houseLine = color(192, 45, 0);
color pathLine = color(58, 94, 65);

//variables 
float str;
float s;
float sca1, sca2, sca3;
float r;
float rot1, rot2;
float arm1, arm2;

int x, y, i;
int mov1 = 5;
int mov2 = 4;
float speed1 = 0.02;
float speed2 = 0.03;
int stop = 800;
int edgeSand = 500;
int border = 35;

void setup(){
  size(1200, 700);
}

void draw(){
  drawBackground(str);
    str= str+speed1;
    
  float sca1 = map(mouseY, 0, height, 0.3, 1);
  rot1 = rot1 + speed2;
  drawCharacter(175, 350, sca1, rot1, 0, 1);
  
  float sca2 = map(mouseY, 0, height, 0.5, 0.1);
  drawCharacter(800, 300, sca2, 0, 0, 1);
  
  drawCharacter(400, 500, 0.3, rot2, 0, 1);
  
  x = x + mov1;
  if ( x > stop || x<0){
    mov1 = -mov1;
  }
  drawCharacter(x, 550, 0.7, 0, 0, 1);

  if (y < edgeSand){
    y +=1;
  }
  drawCharacter(900, y, 0.2, 0, 0, 1);
  
  i = i + mov2;
  if (i-border > width||i<0){
    mov2 = -mov2;
  }
  float rot2 = map( mouseX, 0, width, 0, 2*PI);
  drawCharacter(i, 100, 0.3, rot2, 0, 1);
  
  float sca3 = map( mouseX, 0, width, 0.4, 1);
  drawCharacter(1100, 450, sca3, 0, 0, 1);
  
  float arm1 = map(mouseX, 0, width, 0, 2*PI);//arm rotation
  float arm2 = map(mouseY, 0, height, 0.6, 1.7);//arm scale
  drawCharacter(1000, 550, 0.6, 0, arm1, arm2);

}

void drawCharacter(int x, int y, float s, float r, float arm1, float arm2){

  pushMatrix();
  translate(x, y);
  scale(s);
  rotate(r);

  //body
  fill(249, 255, 0);
  quad(-125, -150, 125, -150, 100, 50, -100, 50);
  strokeWeight(1.7);
  fill(255);
  rect(-95, 50, 190, 25);
  
  fill(230, 144, 0);
  rect(-95, 75, 190, 25);
  
  noFill();
  triangle(-35, 50, -5, 50, -10, 63);
  triangle(5, 50, 35, 50, 10, 63);
  fill(255, 0, 0);
  rect(-5, 50, 10, 10);
  quad(-5, 60, 5, 60, 10, 85, -10, 85);
  fill(0);
  rect(-85, 80, 25, 5);
  rect(-45, 80, 25, 5);
  rect(20, 80, 25, 5);
  rect(60, 80, 25, 5);
  

  //legs
  fill(230, 144, 0);
  rect(-60, 100, 30, 10);
  rect(30, 100, 30, 10);
  fill(249, 255, 0);
  rect(-50, 110, 10, 25);
  rect(40, 110, 10, 25);
  fill(255);
  rect(-50, 135, 10, 30);
  rect(40, 135, 10, 30);
  strokeWeight(3);
  line(-50, 145, -40, 145); 
  line(40, 145, 50, 145);
  stroke(0, 0, 255);
  line(-50, 150, -40, 150); 
  line(40, 150, 50, 150);
  stroke(255, 0, 0);
  line(-50, 155, -40, 155); 
  line(40, 155, 50, 155); 
  
  //shoes
  stroke(0);
  strokeWeight(1);
  fill(0);
  rect(-75, 165, 35, 15);
  rect(40, 165, 35, 15);
  
  //eyes
  stroke(0);
  fill(255);
  ellipseMode(CENTER);
  strokeWeight(1.7);
  ellipse(-38, -65, 80, 80);
  strokeWeight(2);
  ellipse(-25, -70, 27, 27);
  fill(0, 164, 205);
  ellipse(-25, -70, 25, 25);
  fill(0);
  ellipse(-25, -70, 10, 10);
  
  fill(255);
  strokeWeight(1.7);
  ellipse(38, -65, 80, 80); 
  strokeWeight(2);
  ellipse(25, -70, 27, 27);
  fill(0, 164, 205);
  ellipse(25, -70, 25, 25);
  fill(0);
  ellipse(25, -70, 10, 10);
  
  //nose
  fill(249, 255, 0);
  strokeWeight(0.5);
  quad(-5, -30, -10, -50, 10, -50, 5, -25);
  
  //mouth
  stroke(0);
  strokeWeight(1.7);
  noFill();
  arc(0, -35, 170, 80, 0, PI);
  line(80, -38, 90, -35);
  line(-90, -35, -80, -38);
  
  //teeth
  fill(255);
  stroke(1.5);
  rect(-25, 3, 20, 15);
  rect(5, 3, 20, 15);
  
  //arms
  //one arm
  pushMatrix();
  translate(-100, 40);
  rotate(arm1);
  fill(255);
  arc(0, 20, 20, 75, PI, 2*PI, CHORD);  
  fill(249, 255, 0);
  rect(-5, 20, 10, 45);
  rect(-10, 60, 20, 35);
  popMatrix();
  
  //other arm
  pushMatrix();
  translate(100, 60);
  scale(arm2);
  fill(255);
  //arc(-100, 60, 20, 75, PI, 2*PI, CHORD);  
  arc(0, 0, 20, 75, PI, 2*PI, CHORD);
  fill(249, 255, 0);
  rect(-5, 0, 10, 45);
  //rect(-105, 60, 10, 45);
  //rect(-110, 100, 20, 35);
  rect(-10, 40, 20, 35);
  popMatrix();
  
  popMatrix();
}

void drawBackground(float str){
  background(ocean);
  
  //sand
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
 
  
  //path + stones on the path
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
  
  //house + green leaves
  fill(leaves);
  noStroke();
  rect(575, 190, 50, 120);
  triangle(575, 190, 600, 110, 625, 190);
  arc(610, 150, 50, 170, 2.0944+PI,2.0944+2*PI);
  arc(540, 150, 50, 170, PI-2.0944,2*PI-2.0944);
  arc(640, 200, 30, 150, 2.54+PI,2.54+2*PI);
  arc(530, 200, 30, 150, PI-2.54,2*PI-2.54);
  
  //pineapple house
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
  
  //door
  fill(door);
  arc(550, 500, 100, 200, PI, 2*PI );
  
  //two windows
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
  
  //chimney
  fill(chimney);
  triangle(715, 330, 740, 330, 727, 385);
  rect(690, 375, 30, 15);
  rect(720, 365, 15, 25);
  
  pushMatrix();
  translate(600, 560);
  rotate(str);
  noFill();
  stroke(1);
  strokeWeight(1.5);
  triangle(0, -20, 25, 10, -25, 10);
  triangle(-25, -10, 20, -10, 0, 20);
  popMatrix();
}
