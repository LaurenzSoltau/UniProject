// A class that handles levels
class LevelHandler {
  ArrayList<Object> objects;

  ArrayList<Object> loadLevel(int level) {
    objects = new ArrayList<Object>();
    switch(level) {
    case 1:
      objects.add(new Object(300, 50, 20, 20, 2));
      break;
    case 2:
      objects.add(new Object(300, 50, 20, 20, 2));
      objects.add(new Object(500, 150, 100, 20, 0));
      objects.add(new Object(100, 100, 110, 20, 1));
      objects.add(new Object(20, 400, 20, 100, 1));
      break;
    case 3:
      break;
    }
    return objects;
  }
}
