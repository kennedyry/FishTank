class Bubble {
  float speed = random(2, 5); 
  int size = (int)random(5,10); 
  int x, y; 

  Bubble( int x, int y) {
    this.x = x; 
    this.y = y; 
  }
  void update() {
    speed += 0.01; 
    x += random(-5, 5); 
    y -= speed;
    stroke(255); 
    ellipse(x,y, size,size); 
  }
  
  
}