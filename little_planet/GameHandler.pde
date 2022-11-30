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

  boolean checkCollisionCR(ArrayList<Obstacle> obstacles) {
    float testX = 0;
    float testY = 0;
    for (Obstacle obstacle : obstacles) {
      if (obstacle.type == 0) {
        if (posX < obstacle.posX) {
          testX = obstacle.posX;
        } else if (posX > obstacle.posX + obstacle.w) {
          testX = obstacle.posX+obstacle.w;
        }
        if (posY < obstacle.posY) {
          testY = obstacle.posY;
        } else if (posY > obstacle.posY + obstacle.h) {
          testY = obstacle.posY+obstacle.h;
        }
        float distX = posX - testX;
        float distY = posY - testY;
        float distance = sqrt((distX*distX) + (distY*distY));
        if (distance <= radius)
          return true;
      }
    }
    return false;
  }

  void calcPosition(ArrayList<Planet> planets) {
    forceX = 0;
    forceY = 0;
    for (Planet planet : planets) {
      float distance = dist(posX, posY, planet.posX, planet.posY);
      forceX += (planet.radius * 2 * 5 * (planet.posX - posX))/(distance*distance);
      forceY += (planet.radius * 2 * 5 * (planet.posY - posY))/(distance*distance);
    }
    velocityX = velocityX + forceX / frameRate;
    velocityY = velocityY + forceY / frameRate;
    posX = posX + velocityX;
    posY = posY + velocityY;
  }
  void drawObjects(ArrayList<Planet> planets, ArrayList<Obstacle> objects) {
    background(backGround);
    fill(255);
    for (Planet planet : planets) {
      circle(planet.posX, planet.posY, planet.radius*2);
    }
    for (Obstacle object : objects) {
      rect(object.posX, object.posY, object.w, object.h);
    }
    circle(posX, posY, radius*2);
  }
}
