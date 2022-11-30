// A class for Leves
class Level {
  ArrayList<Obstacle> objects;

  ArrayList<Obstacle> loadLevel(int level) {
    objects = new ArrayList<Obstacle>();
    switch(level) {
    case 1:
      objects.add(new Obstacle(150, 150, 40, 40, 0));
      objects.add(new Obstacle(300, 400, 20, 40, 0));
    }
    return objects;
  }
}
