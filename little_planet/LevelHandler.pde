// A class that handles levels
class LevelHandler {
  ArrayList<Object> objects;

  ArrayList<Object> loadLevel(int level) {
    objects = new ArrayList<Object>();
    switch(level) {
    case 1:
      objects.add(new Object(150, 150, 100, 20, 0));
      objects.add(new Object(800, 250, 20, 100, 1));
      objects.add(new Object(100, 600, 110, 20, 1));
      break;
    case 2:
      break;
    }
    return objects;
  }
}
