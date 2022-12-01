class Object {

  float originX;
  float originY;
  float posX;
  float posY;
  float w;
  float h;
  int type; // 0 = obstacle, 1 = bumper, 2 = finish


  public Object(float posX, float posY, float w, float h, int type) {
    this.posX = posX;
    this.posY = posY;
    this.w = w;
    this.h = h;
    this.type = type;
  }
}
