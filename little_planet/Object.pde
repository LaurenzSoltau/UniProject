class Object {

  public float originX; // x start position of the object
  public float originY; // y start position of the object
  public float posX; // x position of the object
  public float posY; // y position of the object
  public float w; // width of the object
  public float h; // height of the object
  public int type; // 0 = obstacle, 1 = bumper, 2 = finish
  public PImage sprite; // sprite (image) of the object

  // Constructor creates an instance of the object and assign the parameters to the variables of the instance
  public Object(float posX, float posY, float w, float h, int type, PImage sprite) {
    this.posX = posX;
    this.posY = posY;
    this.w = w;
    this.h = h;
    this.type = type;
    this.sprite = sprite;
  }
}
