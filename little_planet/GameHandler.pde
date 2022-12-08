// class that handles main game activity
class GameHandler {
  float radius = 30;
  float velocityX;
  float velocityY;
  float posX = 50;
  float posY = 50;
  float originPosX = 50;
  float originPosY = 50;
  float forceX;
  float forceY;
  float distance;
  boolean finished = false;
  PImage backGround = loadImage("bg.png");
  LevelHandler levelHandler = new LevelHandler();

  float buttonSmallPosX = 50;
  float buttonSmallPosY = 700;
  float buttonMediumPosX = 150;
  float buttonMediumPosY = 700;



  // ***CALCULATIONS*** //

  // check if player is colliding with one of the placed planets
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

  // calculate the Postition of the player
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



  ArrayList<Object> reloadLevel(ArrayList<Object> objects, int level) {
    objects.clear();
    posX = originPosX;
    posY = originPosY;
    velocityX = 0;
    velocityY = 0;
    return levelHandler.loadLevel(level);
  }

  ArrayList<Object> loadNewLevel(ArrayList<Object> objects, int level) {
    objects.clear();
    posX = originPosX;
    posY = originPosY;
    velocityX = 0;
    velocityY = 0;
    finished = false;
    return levelHandler.loadLevel(level);
  }

  boolean isFinished() {
    return finished;
  }

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
      rect(object.posX, object.posY, object.w, object.h);

      // draw player planet
      imageMode(CENTER);
      image(littlePlanet, posX, posY, 60, 60);
    }
  }

  boolean clickedSmall(float x, float y) {
    distance = dist(x, y, buttonSmallPosX, buttonSmallPosY);
    if (distance < 30) {
      return true;
    }
    return false;
  }

  boolean clickedMedium(float x, float y) {
    distance = dist(x, y, buttonMediumPosX, buttonMediumPosY);
    if (distance < 40) {
      return true;
    }
    return false;
  }
  
  void reset() {
     posX = originPosX;
     posY = originPosX;
  }

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

  void drawStart() {
    image(titleScreen, 0, 0);
  }

  void drawEnd() {
    background(255);
    textSize(100);
    fill(0);
    text("End", 400, 400);
    textSize(40);
    text("Du hast" + round(currentCount/1000) + "Sekunden gebraucht", 200 , 500);
    fill(255);
  }
}
