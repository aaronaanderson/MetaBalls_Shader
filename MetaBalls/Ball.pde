
//simple class to store ball behavior

class Ball{
  
  Ball(){
    reset();
  }
  
  void update(){
    location.add(velocity);
    checkBounds();
  }
  
  void display(){//just for checking, not used.
    ellipse(location.x, location.y, 20, 20);
  }
  
  void checkBounds(){
    if(location.x < 0 || location.x > width){
      velocity.x *= -1.0;
    }
    if(location.y < 0 || location.y > height){
      velocity.y *= -1.0;
    }
  }
  
  void reset(){
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-1.0, 1.0), random(-1.0, 1.0));
    velocity.normalize();
    velocity.mult(3);
  }
  PVector location;
  PVector velocity;
  
};
