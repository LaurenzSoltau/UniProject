import java.util.ArrayList; // import the arrayList class

ArrayList<Planet> planets = new ArrayList<Planet>(); // List of all the Placed Planets in each Level
ArrayList<Object> objects = new ArrayList<Object>(); // List of all bumpers and obstacles in each Level
GameHandler game; // Handles Calculations and Drawing
LevelHandler levelHandler; //levelHandler object which loads the levels
float smallRadius = 30; // size of Small Planet
float mediumRadius = 60; // size of Big Planet
PImage littlePlanet;
PImage smallPlanet;
PImage spike_100_20;

// STATES
int START = 0;
int LEVEL1 = 1;
int LEVEL2 = 2;
int LEVEL3 = 3;
int WAITING_FOR_NEXT_LEVEL = 4;
int END = 5;

int state = START;

void setup() {
  size(1024, 768);
  littlePlanet = loadImage("erde.png");
  smallPlanet = loadImage("mars.png");
  spike_100_20 = loadImage("spike100x20.png");
  game = new GameHandler();
  levelHandler = new LevelHandler();
  objects = levelHandler.loadLevel(1);
}


void mousePressed() {
  planets.add(new Planet(smallRadius, mouseX, mouseY));
}

void keyPressed() {
  planets.add(new Planet(mediumRadius, mouseX, mouseY));
}


void draw() {
  if (state == START) {
  }
  game.calcPosition(planets);
  if (game.checkCollisionCC(planets) || game.checkCollisionCR(objects))
    exit();
  game.drawAllObjects(planets, objects);
}
