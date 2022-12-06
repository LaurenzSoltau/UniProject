// A class that handles levels
class LevelHandler {
  ArrayList<Object> objects;

  ArrayList<Object> loadLevel(int level) {
    objects = new ArrayList<Object>();
    switch(level) {
    case 1:
      objects.add(new Object(300, 50, 20, 20, 2, goal));
      break;
    case 2:
      objects.add(new Object(300, 50, 50, 50, 2, goal));
      objects.add(new Object(500, 150, 100, 20, 0, spike100x20));
      objects.add(new Object(100, 100, 110, 20, 1, bumper100x20));
      objects.add(new Object(20, 400, 20, 100, 1, bumper20x100));
      break;
    case 3:
      break;
    }
    return objects;
  }
}
