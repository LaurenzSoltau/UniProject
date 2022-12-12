// class that handles main game activity
class GameHandler {
  private float radius = 30;
  private float velocityX;
  private float velocityY;
  private float posX = 50;
  private float posY = 50;
  private float originPosX = 50;
  private float originPosY = 50;
  private float forceX;
  private float forceY;
  private float distance;
  private boolean finished = false;
  private LevelHandler levelHandler = new LevelHandler();
  private float buttonSmallPosX = 50;
  private float buttonSmallPosY = 700;
  private float buttonMediumPosX = 150;
  private float buttonMediumPosY = 700;



  // ***CALCULATIONS*** //

  // check if player is colliding with one of the placed planets
  // parameter planet is list of all the planets placed by the player
  // retuns if collision has happends
  boolean checkCollisionCC(ArrayList<Planet> planets) {
    // loop through each planet to check collision with all the planets in the level
    for (Planet planet : planets) {
      // compute distance between the circles
      distance = dist(posX, posY, planet.posX, planet.posY);
      if (distance <= radius + planet.radius) {
        // return collision true, if the distance is lessen than combined radiuses, because this is when the circles touch
        return true;
      }
    }
    return false;
  }

  // check for collison between Circular and Rectengular Objects
  // parameter objects is list of all the rectengual objects in the level
  // returns if collision has happend
  boolean checkCollisionCR(ArrayList<Object> objects) {

    // Loop through all rectengular Objects and compute if they collide with player
    for (Object object : objects) {
      float testX = posX;
      float testY = posY;
      if (posX < object.posX) {
        testX = object.posX;
      } else if (posX > object.posX + object.w) {
        testX = object.posX+object.w;
      }
      if (posY < object.posY) {
        testY = object.posY;
      } else if (posY > object.posY + object.h) {
        testY = object.posY+object.h;
      }

      float distance = dist(posX, posY, testX, testY);
      // collision detected
      if (distance <= radius) {
        if (object.type == 0)
          return true;   // return true if they collide and object is obstacle
        else if (object.type == 1) {
          // check on which side the circle had collided with the rectangle
          boolean isAboveAC, isAboveDB;
          // opposite corner = top_left , corner = bottom right
          isAboveAC = ((object.posX - (object.posX + object.w)) * (posY - (object.posY + object.h)) - (object.posY - (object.posY + object.h)) * (posX - (object.posX + object.w))) > 0;
          // opposite corner = bottom left, corner = upper right
          isAboveDB = ((object.posX - (object.posX + object.w)) * (posY - object.posY) - ((object.posY + object.h) - object.posY) * (posX - (object.posX+object.w))) > 0;
          // collided on left or right side
          if ((!isAboveAC && isAboveDB) || (isAboveAC && !isAboveDB))
            velocityX *= -1;
          // collided on top or bottom side
          else if ((isAboveAC && isAboveDB) || (!isAboveAC && !isAboveDB))
            velocityY *= -1;
        } else {
          finished = true;
          return true;
        }
      }
    }
    return false;
  }

  // calulates the position of the player with respect to the gravitational force of the placed planets
  // the parameter planets is a ArrayList of all the placed Planets 
  void calcPosition(ArrayList<Planet> planets) {
    forceX = 0;
    forceY = 0;
    // loop through each planet and calculate force to apply to the player
    for (Planet planet : planets) {
      float distance = dist(posX, posY, planet.posX, planet.posY);
      forceX += (planet.radius * 2 * 5 * (planet.posX - posX))/(distance*distance);
      forceY += (planet.radius * 2 * 5 * (planet.posY - posY))/(distance*distance);
    }
    // Calculte position of moving Objects



    // change velocity by force
    velocityX = velocityX + forceX / frameRate;
    velocityY = velocityY + forceY / frameRate;
    // change the player x and y position
    posX = posX + velocityX;
    posY = posY + velocityY;
  }


  // ***DRAWING*** //

  // draw all the placed planets and all bouncers and rectengular objects


  // reloads the level and resets all the important variables
  // the parameter objects is a list of all the objects in the level, level is specifing which level to reload
  // returns a new list of all objects in the level
  ArrayList<Object> reloadLevel(ArrayList<Object> objects, int level) {
    objects.clear();
    posX = originPosX;
    posY = originPosY;
    velocityX = 0;
    velocityY = 0;
    return levelHandler.loadLevel(level);
  }

  // loads ne level and resets all the important variables
  // the parameter objects, is a list of the objects in the level, level is specifying the level
  // returns new list with the objects for the next level
  ArrayList<Object> loadNewLevel(ArrayList<Object> objects, int level) {
    objects.clear();
    posX = originPosX;
    posY = originPosY;
    velocityX = 0;
    velocityY = 0;
    finished = false;
    return levelHandler.loadLevel(level);
  }
  // is checking, if player has finished the current level
  // return if player has finished
  boolean isFinished() {
    return finished;
  }

  // draws all the objects to the screen
  //takes a list of all places planets and all objects in the level as arguments
  void drawAllObjects(ArrayList<Planet> planets, ArrayList<Object> objects) {
    background(backGround);
    // loop through all planets to draw them
    imageMode(CENTER);
    for (Planet planet : planets) {
      if (planet.radius == 30) {
        image(smallPlanet, planet.posX, planet.posY, planet.radius*2, planet.radius*2);
      } else if (planet.radius == 40) {
        image(mediumPlanet, planet.posX, planet.posY, planet.radius*2, planet.radius*2);
      }
    }
    // loop through other objects to draw them
    for (Object object : objects) {
      imageMode(CORNER);
      fill(255, 255, 255, 160);
      image(object.sprite, object.posX, object.posY);
      //rect(object.posX, object.posY, object.w, object.h);

      // draw player planet
      imageMode(CENTER);
      image(littlePlanet, posX, posY, 60, 60);
    }
  }
  
  // checks if user clicked the smallPlanet in the hud
  // retuns if he has or hasnt
  boolean clickedSmall(float x, float y) {
    distance = dist(x, y, buttonSmallPosX, buttonSmallPosY);
    if (distance < 30) {
      return true;
    }
    return false;
  }

  // checks if user clicked the medium Planet in the hud
  // retuns if he has or hasnt
  boolean clickedMedium(float x, float y) {
    distance = dist(x, y, buttonMediumPosX, buttonMediumPosY);
    if (distance < 40) {
      return true;
    }
    return false;
  }

  // resets the x and y position of the player to the starting position
  void reset() {
    posX = originPosX;
    posY = originPosX;
  }

  // draw the hud to the screen
  void drawHUD() {
    fill(50, 50, 50, 160);
    rect(0, 630, width, height-630);


    image(smallPlanet, buttonSmallPosX, buttonSmallPosY);
    image(mediumPlanet, buttonMediumPosX, buttonMediumPosY);


    fill(255);
    textSize(50);
    text(deathCount, width-100, 50);
    text(level, 100, 50);
    text(round(currentCount/1000), width/2, 50);
    text("Planets Remaining: " + planetsRemaining, buttonMediumPosX + 70, buttonMediumPosY + 20);
    textSize(20);
    text("Click on the planets on the left to place one", buttonMediumPosX + 70, buttonMediumPosY + 50);
  }

  // draws the startscreen  
  void drawStart() {
    image(titleScreen, 0, 0);
  }

  // draws the endscreen
  void drawEnd() {
    background(255);
    textSize(100);
    fill(0);
    text("End", 400, 400);
    textSize(40);
    text("Du hast " + round(currentCount/1000) + " Sekunden gebraucht", 220, 500);
    text("Drücke eine Taste um nocheinmal zu spielen!", 120, 600);
    fill(255);
  }
}
