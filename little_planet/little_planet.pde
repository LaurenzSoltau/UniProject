import java.util.ArrayList; // import the arrayList class

ArrayList<Planet> planets = new ArrayList<Planet>(); // List of all the Placed Planets in each Level
ArrayList<Object> objects = new ArrayList<Object>(); // List of all bumpers and obstacles in each Level
GameHandler game; // Handles Calculations and Drawing
LevelHandler levelHandler; //levelHandler object which loads the levels
float smallRadius = 30; // size of Small Planet
float mediumRadius = 40; // size of Big Planet
PImage titleScreen;
PImage littlePlanet;
PImage smallPlanet;
PImage mediumPlanet;
PImage spike100x20;
PImage spike20x100;
PImage spike50x30;
PImage bumper100x20;
PImage bumper20x100;
PImage goal;
int deathCount;
int level;
float startCount = 0;
float currentCount = 0;
boolean counting;
float lastTime;
boolean holdingSmallPlanet = false;
boolean holdingMediumPlanet = false;
int planetsRemaining = 3;

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
  mediumPlanet = loadImage("medium_planet.png");
  spike100x20 = loadImage("spike100x20.png");
  spike20x100 = loadImage("spike20x100.png");
  spike50x30 = loadImage("spike50x30.png");
  bumper100x20 = loadImage("bumper100x20.png");
  bumper20x100 = loadImage("bumper20x100.png");
  titleScreen = loadImage("titelscreen.png");
  goal = loadImage("goal50x50.png");
  game = new GameHandler();
  levelHandler = new LevelHandler();
  state = START;
}


void mousePressed() {
  if (state != PLAYING || planetsRemaining < 1) {
    cursor(ARROW);
    return;
  }
  if (holdingSmallPlanet) {
    planets.add(new Planet(smallRadius, mouseX, mouseY, smallPlanet));
    planetsRemaining--;
    holdingSmallPlanet = false;
    cursor(ARROW);
  }
  if (holdingMediumPlanet) {
    planets.add(new Planet(mediumRadius, mouseX, mouseY, mediumPlanet));
    planetsRemaining--;
    holdingMediumPlanet = false;
    cursor(ARROW);
  }

  if (game.clickedSmall(mouseX, mouseY)) {
    holdingSmallPlanet = true;
    cursor(smallPlanet);
    //planets.add(new Planet(smallRadius, mouseX, mouseY, smallPlanet));
  } else if (game.clickedMedium(mouseX, mouseY)) {
    holdingMediumPlanet = true;
    mediumPlanet.resize(40, 40);
    cursor(mediumPlanet);
    mediumPlanet = loadImage("medium_planet.png"); // ugly workaround cursor bug in windows
    //planets.add(new Planet(mediumRadius, mouseX, mouseY, mediumPlanet));
  }
}
void keyPressed() {
  if (holdingMediumPlanet || holdingSmallPlanet) {
    holdingMediumPlanet = false;
    holdingSmallPlanet = false;
    cursor(ARROW);
  }
  if (state == START) {
    lastTime = millis();
    counting = true;
    state = PLAYING;
    objects = levelHandler.loadLevel(LEVEL1);
    level = LEVEL1;
  }
}


void restart() {
  
}


void draw() {
  if (state == START) {
    game.drawStart();
  } else if (state == END) {
    game.drawEnd();
    counting = false;
  } else if (state == PLAYING) {
    game.calcPosition(planets);
    if (game.checkCollisionCC(planets) || game.checkCollisionCR(objects)) {
      if (game.isFinished()) {
        if (level == 6) {
          state = END;
        }
        level++;
        objects = game.loadNewLevel(objects, level);
        planets.clear();
        planetsRemaining = 3;
      } else {
        holdingMediumPlanet = false;
        holdingSmallPlanet = false;
        cursor(ARROW);
        deathCount++;
        objects = game.reloadLevel(objects, level);
        planets.clear();
        planetsRemaining = 3;
      }
    }

    if (counting) {
      currentCount += millis() - lastTime;
      lastTime = millis();
    }
    game.drawAllObjects(planets, objects);
    game.drawHUD();
    text(mouseX + " " + mouseY, mouseX, mouseY);
  }
  
}
