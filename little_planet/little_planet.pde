import java.util.ArrayList; // import the arrayList class

ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>(); 
public enum Type {CIRCLE, RECTANGLE, STAR}
GameHandler game;
Level levelHandler;
float smallSize = 30;
float mediumSize = 60;


void setup() {
  size(1024, 768);
  game = new GameHandler();
  levelHandler = new Level();
}

    
void mousePressed() {
  planets.add(new Planet(smallSize, mouseX, mouseY));
}

void keyPressed() {
  planets.add(new Planet(mediumSize, mouseX, mouseY));
}


void draw() {
  obstacles = levelHandler.loadLevel(1);
  game.calcPosition(planets);
  if (game.checkCollisionCC(planets) || game.checkCollisionCR(obstacles))
    exit();
  game.drawObjects(planets, obstacles);
  
}
