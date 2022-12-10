import processing.sound.*; // Import Soundlibrary
import java.util.ArrayList; // import the arrayList class

private ArrayList<Planet> planets = new ArrayList<Planet>(); // List of all the Placed Planets in each Level
private ArrayList<Object> objects = new ArrayList<Object>(); // List of all bumpers and obstacles in each Level
private GameHandler game; // Handles Calculations and Drawing
public float smallRadius = 30; // size of Small Planet
public float mediumRadius = 40; // size of Big Planet
public PImage titleScreen; // Image of the titlescreen
public PImage littlePlanet; // Image for the character planet
public PImage smallPlanet; // Image for the small planet
public PImage mediumPlanet; // Image for the medium sized planet
public PImage spike100x20; // Image for the 100x20 Spike
public PImage spike20x100; // Image for the 20x100 Spike
public PImage bumper100x20; // Image for the 100x20 Bumper
public PImage bumper20x100; // Image for the 20x100 bumper
public PImage goal; // Image for the goal flag
public PImage backGround;
public int deathCount; // counting the deaths in each run
private int level; // current level
public float startCount = 0; 
private float currentCount = 0;
private boolean counting;
private float lastTime;
private boolean holdingSmallPlanet = false;
private boolean holdingMediumPlanet = false;
public int planetsRemaining = 3;
private SoundFile music;
private SoundFile death;
private SoundFile win;
private SoundFile place;

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
int totalLevels = 6;

void setup() {
  size(1024, 768);
  littlePlanet = loadImage("erde.png");
  smallPlanet = loadImage("mars.png");
  mediumPlanet = loadImage("medium_planet.png");
  spike100x20 = loadImage("spike100x20.png");
  spike20x100 = loadImage("spike20x100.png");
  bumper100x20 = loadImage("bumper100x20.png");
  bumper20x100 = loadImage("bumper20x100.png");
  titleScreen = loadImage("titelscreen.png");
  goal = loadImage("goal50x50.png");
  backGround = loadImage("bg.png");
  game = new GameHandler();
  state = START;
  music = new SoundFile(this, "soundtrack.mp3");
  win = new SoundFile(this, "win.wav");
  death = new SoundFile(this, "deathSound.wav");
  place = new SoundFile(this, "place.wav");
  music.loop();
}


void mousePressed() {
  if (state != PLAYING || planetsRemaining < 1) {
    cursor(ARROW);
    return;
  }
  if (holdingSmallPlanet) {
    place.play();
    planets.add(new Planet(smallRadius, mouseX, mouseY, smallPlanet));
    planetsRemaining--;
    holdingSmallPlanet = false;
    cursor(ARROW);
  }
  if (holdingMediumPlanet) {
    place.play();
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
  if (state == START || state == END) {
    if (state == END) {
      restart();
    }
    lastTime = millis();
    counting = true;
    state = PLAYING;
    objects = game.loadNewLevel(objects, 1);
    level = LEVEL1;
  }
}


void restart() {
  level = 1;
  currentCount = 0;
  deathCount = 0;
  game.reset();
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
        win.play();
        if (level == totalLevels) {
          state = END;
        }
        level++;
        objects = game.loadNewLevel(objects, level);
        planets.clear();
        planetsRemaining = 3;
      } else {
        death.play();
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
