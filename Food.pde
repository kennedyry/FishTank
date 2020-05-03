class Food {
  int x, y; 
  int speed = (int) random(1, 5); 
  int size = 10; 
  Food(int x, int y) {
    this.x = x; 
    this.y = y;
  }
  void update() {
    fill(255);   
    ellipse(x, y, size, size); 
    fill(0); 
    y += speed; 
    speed += 0.5; 
    x += (int) random(-2, 2);
  }
}