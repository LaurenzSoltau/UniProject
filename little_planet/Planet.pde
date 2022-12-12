// Class for the spawanable planets
class Planet {
  public float radius; // radius of the planet
  public float posX; // x coordinate of the planet
  public float posY; // y coordinate of the planet
  public PImage sprite; // sprite (image) of the planet
  
  // Constructor creates an instance of the object and assign the parameters to the variables of the instance
  public Planet(float radius, float x, float y, PImage sprite) {
    this.radius = radius;
    this.posX = x;
    this.posY = y;
    this.sprite = sprite;
  }
}
