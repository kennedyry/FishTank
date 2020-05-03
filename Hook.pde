class Hook {
  int size = 50; 
  int x = (int)random(2 * size, width - (2*size)); 
  int speed = (int)random(2,7); 
  int dropHeight = (int)random(0,height); 
  int dropTime = 100;
  int y = -100; 
  boolean dropping = true; 
  PImage hookPic = loadImage("hook.png"); 
  Hook() {
    hookPic.resize(size,size); 
  }
  void update(){
    image(hookPic, x - size/2, y ); 
    line(x,y,x,0); 
    if (y >= dropHeight) dropping = false; 
    if (dropping) y += speed;
    else y -= speed; 
  }
 
}