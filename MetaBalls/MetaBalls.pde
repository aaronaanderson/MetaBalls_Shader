import controlP5.*;

ControlP5 cp5;//gui for color wheels
boolean showGUI = true;
boolean acceptMouse = true;

int numBalls = 5;//can't change this w/o changing shader file
Ball[] balls = new Ball[numBalls];

PShader metaBallShader;//store the shader (located in same folder as pde files)

void setup() {
  size(1920, 1080, P2D);

  for (int i = 0; i < numBalls; i++) {//make the meta balls
    balls[i] = new Ball();
  }

  cp5 = new ControlP5(this);//somewhat random colors to start with
  cp5.addColorWheel("cOne", 10, 10, 200).setRGB(color(160, 0, 255));
  cp5.addColorWheel("cTwo", 10, 230, 200).setRGB(color(200, 70, 20));
  cp5.addColorWheel("cThree", 10, 450, 200).setRGB(color(110, 140, 140));
  cp5.addColorWheel("cFour", 10, 670, 200).setRGB(color(70, 210, 90));
  cp5.addColorWheel("cFive", 10, 890, 200).setRGB(color(5, 255, 200));

  metaBallShader = loadShader("metaBallsShader.glsl");//load shader
}

void draw() {
  for (int i = 0; i < numBalls; i++) {
    balls[i].update();//just updates the position of the balls
  }
  
  //set the resolution within the shader
  metaBallShader.set("resolution", float(width), float(height));
  
  //send locations to shader
  metaBallShader.set("location_Ball_One", balls[0].location.x/float(width), (height-balls[0].location.y)/float(height));
  metaBallShader.set("location_Ball_Two", balls[1].location.x/float(width), (height-balls[1].location.y)/float(height));
  metaBallShader.set("location_Ball_Three", balls[2].location.x/float(width), (height-balls[2].location.y)/float(height));
  metaBallShader.set("location_Ball_Four", balls[3].location.x/float(width), (height-balls[3].location.y)/float(height));
  metaBallShader.set("location_Ball_Five", balls[4].location.x/float(width), (height-balls[3].location.y)/float(height));
  
  //send Colors
  int c = cp5.get(ColorWheel.class, "cOne").getRGB();//get the color as an int b/c GUI delivers it like that
  metaBallShader.set("color_Ball_One", red(c)/255.0, green(c)/255.0, blue(c)/255.0, 0.0);//parse colors from int
  c = cp5.get(ColorWheel.class, "cTwo").getRGB();
  metaBallShader.set("color_Ball_Two", red(c)/255.0, green(c)/255.0, blue(c)/255.0, 0.0);
  c = cp5.get(ColorWheel.class, "cThree").getRGB();
  metaBallShader.set("color_Ball_Three", red(c)/255.0, green(c)/255.0, blue(c)/255.0, 0.0);
  c = cp5.get(ColorWheel.class, "cFour").getRGB();
  metaBallShader.set("color_Ball_Four", red(c)/255.0, green(c)/255.0, blue(c)/255.0, 0.0);
  c = cp5.get(ColorWheel.class, "cFive").getRGB();
  metaBallShader.set("color_Ball_Five", red(c)/255.0, green(c)/255.0, blue(c)/255.0, 0.0);

  if(acceptMouse){//y sets brightness threshold, x sets metaball size
    metaBallShader.set("threshold", pow(map(mouseY, height, 0, 1.0, 0.0), 2));//curve to make useful
    metaBallShader.set("size", pow(map(mouseX, 0, width, 0.0, 1.0), 3));//curve even more
  }
  
  shader(metaBallShader);//run the shader
  rect(0, 0, width, height);//give the shader something to work on
}

void keyPressed() {
  if (key == 'h') {
    if(showGUI){
      cp5.hide();
      showGUI = !showGUI;
    }else{
      cp5.show();
      showGUI = !showGUI;
    }
  }
  if(key == 'm'){
    acceptMouse = !acceptMouse;
  }
  if(key == 'r'){
    for(int i = 0; i < numBalls; i++){
      balls[i].reset();
    }
  }
}
