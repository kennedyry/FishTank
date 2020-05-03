ArrayList<Fish> fish = new ArrayList<Fish>(); 
ArrayList<Fish> deadFish; 
ArrayList<Bubble> bubbles = new ArrayList<Bubble>(); 
ArrayList<Bubble> deadBubbles = new ArrayList<Bubble>(); 
ArrayList<Food> foods = new ArrayList<Food>(); 
ArrayList<Food> deadFoods = new ArrayList<Food>(); 
ArrayList<Hook> hooks = new ArrayList<Hook>();
ArrayList<Hook> deadHooks = new ArrayList<Hook>(); 

float grassDisplacement = 0; 
boolean grassLeft; 
int bubbleTimer = (int)random(100, 300); 
int numberOfFish = 10; 

void setup() {
  size(1000, 500); 
  for (int i = 0; i < numberOfFish; i++) fish.add(new Fish());
  fill(0);
  strokeWeight(3);
}

void draw() {
  println("Hooks: " + hooks.size() + " Fish: " + fish.size() + " Food: " + foods.size()); 
  background(0); 
  stroke(255); 
  ellipse(width /2, height, width / 10, width / 10); 
  ellipse(width / 2 + width / 10, height, width /5, width /5); 
  ellipse(width / 2 + 3 * width / 10, height, width / 20, width / 20); 
  //ellipse(2 * height /5, 3 * height / 5, 2 * height / 5, height /5); 
  //rect(height / 5, height - 2 * height / 5, 2 * height / 5, 2 * height / 5); 
  deadFish = new ArrayList<Fish>(); 
  for (Fish f : fish) {
    f.update(); 
    f.drawSelf(); 
    if (f.hooked && f.y < -100) {
      deadFish.add(f);
    }
    if (!f.hooked) {
      for (Hook h : hooks) {
        f.hookCollision(h);
        if (f.hooked) break;
      }
    }
    if (f.timeForBubble()) {
      if (f.left)bubbles.add(new Bubble((int)(f.x + 1.5 * f.size), f.y));
      else bubbles.add(new Bubble((int)(f.x - 1.5 * f.size), f.y));
    }
  }
  for (Fish f : deadFish) {
    fish.remove(f); 
    fish.add(new Fish());
  }
  for (Bubble b : bubbles) {
    b.update(); 
    if (b.y + b.size < 0) deadBubbles.add(b);
  }
  for (Food f : foods) {
    f.update(); 
    if (f.y - f.size > height) deadFoods.add(f);
  }  
  for (Food f : deadFoods) foods.remove(f);
  for (Bubble b : deadBubbles)bubbles.remove(b);
  if (bubbleTimer <= 0) {
    bubbleTimer = (int)random(100, 300); 
    bubbles.add(new Bubble((int)random(width/2, width), height - 20));
  }
  bubbleTimer--; 
  if (frameCount % 90 == 0) hooks.add(new Hook());  
  for (Hook h : hooks) {
    h.update();  
    if (!h.dropping && h.y < -200)  deadHooks.add(h);
  }
  for (Hook h : deadHooks) {
    hooks.remove(h);
  }
}

void mousePressed() {
  foods.add(new Food(mouseX, mouseY));
}
