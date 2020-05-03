class Fish {
  int x = (int)random(-width, -100); 
  int y = (int)random(height / 10, 9 * height / 10); 
  int size = (int)random(5, 50); 
  float speed = random(1, 20); 
  float startingSpeed = speed; 
  float maxSpeed = 10; 
  int searchingRange = (int)random(20, 60); 
  boolean left = true; 
  int bubbleTimer = (int)random(30, 300); 
  boolean hooked; 
  Hook hook; 
  int degree;
  color c; 


  Fish() {
    colorMode(HSB); 
    c = color((int)(random(255)), 255,255); 
  }

  void update() {
    boolean feeding = false; 
    for (Food f : foods) {
      if (f.y > y - size/2 && f.y < y + size/2 && ((left && f.x > x && f.x < x + size/2) || (!left && f.x < x && f.x > x - size/2))) {
        size += 10; 
        deadFoods.add(f);
      }
      if (f.y > y - searchingRange && f.y < y + searchingRange && ((left && x < f.x) || (!left && x > f.x)) && abs(f.x - x) < 300) {
        feeding = true; 
        break;
      }
    }
    if (feeding) {
      if (speed < 15)speed += 0.5;
    } else if (speed > startingSpeed) speed -= 0.1; 
    if (!hooked) {
      if (left)x += map(speed, 1, 15, 1, 7); 
      else x -= map(speed, 1, 15, 1, 7);
    } else {
      x = hook.x; 
      y = hook.y + 50;
    }

    if ( x - 1.5 * size > width) {
      left = false;
      y = (int)random(height / 10, 9 * height / 10); 
      size = (int) random(10, 30);
      speed = (int) random(1, 20);
    } else if (x + 1.5 * size < 0) {
      left = true;
      y = (int)random(height / 10, 9 * height / 10); 
      size = (int) random(10, 30);
      speed = (int) random(1, 20);
    }
  }
  void hookCollision(Hook h) {
    int xDiff = abs(h.x - x); 
    int yDiff = abs(h.y - y); 
    if (xDiff < 1.5 * size && yDiff < 1.5 * size) {
      hooked = true;
    }
    hook = h;
  }  

  void drawSelf() {
    stroke(c); 
    if (hooked && degree < 90) degree++; 
    ellipse(x, y, 2 * size, size); 
    if (left) {
      ellipse(x + size / 3, y - size / 4, size / 10, size/10); 
      line(x - size, y, x - 1.5 * size, y + size/2); 
      line(x - size, y, x - 1.5 * size, y - size/2); 
      line(x - 1.5*size, y + size/2, x - 1.5 * size, y - size/2);
    } else {
      ellipse(x - size / 3, y - size / 4, size / 10, size/10); 
      line(x + size, y, x + 1.5 * size, y + size/2); 
      line(x + size, y, x + 1.5 * size, y - size/2); 
      line(x + 1.5 * size, y + size/2, x + 1.5 * size, y - size/2);
    }
  }
  boolean timeForBubble() {
    if (bubbleTimer <= 0) {
      bubbleTimer = (int)random(300, 600); 
      return true;
    }
    bubbleTimer--; 
    return false;
  }
}