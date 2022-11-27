float size = 20;
boolean isPlanet = false;
boolean isPlanet2 = false;
float planetSize = 40;
float planetSize2 = 60;
PVector player = new PVector(50, 50);
float velocityX;
float velocityY;
PVector planet = new PVector();
PVector planet2 = new PVector();
PVector direction = new PVector();
PVector force = new PVector();

void setup() {
  size(400, 400);
}


void calcPos() {
  float forceX = 0;
  float forceY = 0;
  if (isPlanet) {
    float distance = dist(player.x, player.y, planet.x, planet.y);

    forceX += (planetSize * 5 * (planet.x - player.x))/(distance*distance);
    forceY += (planetSize * 5 * (planet.y - player.y))/(distance*distance);
  }
  if (isPlanet2) {
    float distance = dist(player.x, player.y, planet2.x, planet2.y);

    forceX += (planetSize2 * 5 * (planet2.x - player.x))/(distance*distance);
    forceY += (planetSize2 * 5 * (planet2.y - player.y))/(distance*distance);
  }
  velocityX = velocityX + forceX / frameRate;
  velocityY = velocityY + forceY / frameRate;
  player.x = player.x + velocityX;
  player.y = player.y + velocityY;
}

void checkCollision() {
}

void drawCircle() {
  background(150);
  circle(player.x, player.y, size);
  if (isPlanet)
    circle(planet.x, planet.y, planetSize);
  if (isPlanet2)
    circle(planet2.x, planet2.y, planetSize2);
}


void mousePressed() {
  ellipse(mouseX, mouseY, planetSize, planetSize);
  planet.x = mouseX;
  planet.y = mouseY;
  isPlanet = true;
}

void keyPressed() {
  ellipse(mouseX, mouseY, planetSize2, planetSize2);
  planet2.x = mouseX;
  planet2.y = mouseY;
  isPlanet2 = true;
}

void draw() {
  calcPos();
  drawCircle();
  checkCollision();
}
