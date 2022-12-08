// A class that handles levels
class LevelHandler {
  ArrayList<Object> objects;

  ArrayList<Object> loadLevel(int level) {
    objects = new ArrayList<Object>();
    switch(level) {
    case 1:
      objects.add(new Object(750, 500, 50, 50, 2, goal));
      break;
    case 2:
      objects.add(new Object(1000, 480, 50, 50, 2, goal));

      break;
    case 3:
      objects.add(new Object(180, 400, 50, 50, 2, goal));
      objects.add(new Object(120, 180, 100, 20, 0, spike100x20));
      break;
      
     case 4:
     objects.add(new Object(700, 50, 50, 50, 2, goal));
     objects.add(new Object(350, 350, 100, 20, 1, bumper100x20));
     objects.add(new Object(350, 10, 20, 100, 0, spike20x100));
       break;
       
    case 5:
      objects.add(new Object(450, 400, 50, 50, 2, goal));
      objects.add(new Object(100, 0, 20, 100, 0, spike20x100));
      objects.add(new Object(100, 100, 20, 100, 0, spike20x100));
      objects.add(new Object(100, 200, 20, 100, 0, spike20x100));
      break;
      
      case 6:
      objects.add(new Object(300, 370, 50, 50, 2, goal));
      objects.add(new Object(30, 300, 20, 100, 1, bumper20x100));
      objects.add(new Object(270, 150, 20, 100, 1, bumper20x100));
      objects.add(new Object(170, 280, 100, 20, 0, spike100x20));
      objects.add(new Object(270, 20, 20, 100, 0, spike20x100));
    }
    
  
    return objects;
  }
}
