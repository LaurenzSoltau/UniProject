class Obstacle {

  float posX;
  float posY;
  float w;
  float h;
  int type; // 0 = obstacle, 1 = bumper


  Obstacle(float posX, float posY, float w, float h, int type) {
    this.posX = posX;
    this.posY = posY;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  
  
}
