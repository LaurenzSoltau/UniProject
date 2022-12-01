// Class for the spawanable planets
class Planet {
  float radius; // radius of the planet
  String name; // name of the planet
  int count;
  float posX;
  float posY;

  Planet(float radius, float x, float y) {
    this.radius = radius;
    this.name = "planet" + count;
    count++;
    this.posX = x;
    this.posY = y;
  }
}
