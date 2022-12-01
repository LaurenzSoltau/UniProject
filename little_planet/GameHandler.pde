// class that handles main game activity
class GameHandler {
  float radius = 30;
  float velocityX;
  float velocityY;
  float posX = 50;
  float posY = 50;
  float forceX;
  float forceY;
  float distance;
  PImage backGround = loadImage("bg.png");


  // ***CALCULATIONS*** //

  // check if player is colliding with one of the placed planets
  boolean checkCollisionCC(ArrayList<Planet> planets) {
    // loop through each planet to check collision with all the planets in the level
    for (Planet planet : planets) {
      // compute distance between the circles
      distance = dist(posX, posY, planet.posX, planet.posY);
      if (distance <= radius + planet.radius)
        // return collision true, if the distance is lessen than combined radiuses, because this is when the circles touch
        return true;
    }
    return false;
  }

  // check for collison between Circular and Rectengular Objects
  boolean checkCollisionCR(ArrayList<Object> objects) {

    float testX = posX;
    float testY = posY;
    // Loop through all rectengular Objects and compute if they collide with player
    for (Object object : objects) {
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
      if(object.type == 1) println(distance);
      if (distance <= radius) {
        println("collision");
        if (object.type == 1 && object.h > object.w) {
          velocityX = -velocityX;
          return false;
        }
        if (object.type == 1 && object.w > object.h) {
          velocityY = -velocityY;
          return false;
        }
        // return true if they collide and object is obstacle
        return true;
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
    // change velocity by force
    velocityX = velocityX + forceX / frameRate;
    velocityY = velocityY + forceY / frameRate;
    // change the player x and y position
    posX = posX + velocityX;
    posY = posY + velocityY;
  }


  // ***DRAWING*** //

  // draw all the placed planets and all bouncers and rectengular objects



  void drawStartScreen() {
  }

  void drawAllObjects(ArrayList<Planet> planets, ArrayList<Object> objects) {
    background(backGround);
    fill(255);
    // loop through all planets to draw them
    imageMode(CENTER);
    for (Planet planet : planets) {
      if (planet.radius == 30) {
        image(smallPlanet, planet.posX, planet.posY, 60, 60);
      } else if (planet.radius == 60) {
        circle(planet.posX, planet.posY, planet.radius*2);
      }
    }
    // loop through other objects to draw them
    imageMode(CORNER);
    for (Object object : objects) {
      if (object.w == 100 && object.h == 20) {
        image(spike_100_20, object.posX, object.posY);
        //rect(object.posX, object.posY, 100, 20);
      } else {
        rect(object.posX, object.posY, object.w, object.h);
      }
    }
    // draw player planet
    imageMode(CENTER);
    image(littlePlanet, posX, posY, 60, 60);
    //circle(posX, posY, radius*2);
  }
}
