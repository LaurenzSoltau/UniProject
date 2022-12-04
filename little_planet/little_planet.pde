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
int deathCount;
int level;

// STATES
int START = 0;
int PLAYING = 6;
int WAITING_FOR_NEXT_LEVEL = 4;
int END = 5;

int state = START;

// LEVELS
int LEVEL1 = 1;
int LEVEL2 = 2;
int LEVEL3 = 3;

void setup() {
  size(1024, 768);
  littlePlanet = loadImage("erde.png");
  smallPlanet = loadImage("mars.png");
  spike_100_20 = loadImage("spike100x20.png");
  game = new GameHandler();
  levelHandler = new LevelHandler();
  state = START;
}


void mousePressed() {
  if (state == PLAYING)
    planets.add(new Planet(smallRadius, mouseX, mouseY));
}

void keyPressed() {
  if (state == PLAYING)
    planets.add(new Planet(mediumRadius, mouseX, mouseY));
  if (state == START) {
    state = PLAYING;
    objects = levelHandler.loadLevel(LEVEL1);
    level = LEVEL1;
  }
}



void draw() {
  if (state == START) {
    game.drawStart();
  } else if (state == END) {
    game.drawEnd();
  } else if (state == PLAYING) {
    game.calcPosition(planets);
    if (game.checkCollisionCC(planets) || game.checkCollisionCR(objects)) {
      if (game.isFinished()) {
        level++;
        objects = game.loadNewLevel(objects, level);
        planets.clear();
      } else {
        deathCount++;
        objects = game.reloadLevel(objects, level);
        planets.clear();
      }
    }


    game.drawAllObjects(planets, objects, deathCount, level);
  }
}
