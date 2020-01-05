import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Animation animation1;

import processing.sound.*;
//SoundFile file;
AudioIn in;
Amplitude amp;

PImage img;

float g= 1;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;

// A list for all particle systems
ArrayList<Gota> chuva;


boolean anima = false;
int t = 0;

void setup() {
  img = loadImage("totoro.png");
  size(1280, 720);
  //fullScreen();

  frameRate(100);


  animation1 = new Animation("ani", 35);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // We are setting a custom gravity


  // Create ArrayLists
  chuva = new ArrayList<Gota>();
  boundaries = new ArrayList<Boundary>();




  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  //in.play();
  amp.input(in);
  //file = new SoundFile(this, "totoro.mp3");
  //file.play();
  //amp.input(file);



  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(501.5, 441, 60, 2, -0.15));
  boundaries.add(new Boundary(546.5, 458, 40, 2, -0.65));
  boundaries.add(new Boundary(569, 482, 32, 2, -1));
  boundaries.add(new Boundary(438, 446, 70, 2, 0.3));
  boundaries.add(new Boundary(387, 471, 46, 2, 0.7));
  boundaries.add(new Boundary(363, 503, 36, 2, 1.2));

  boundaries.add(new Boundary(794, 105, 70, 2, 0.1));
  boundaries.add(new Boundary(868, 108, 80, 2, -0.15));
  boundaries.add(new Boundary(735, 121, 55, 2, 0.46));
  boundaries.add(new Boundary(692, 150, 50, 2, 0.7));
  boundaries.add(new Boundary(926, 122, 40, 2, -0.4));
  boundaries.add(new Boundary(964, 146, 50, 2, -0.7));
}

void draw() {
  image(img, 0, 0, width, height);
  box2d.setGravity(0, -g*g);


  int r = int(random(300));
  if (r == 1 && anima == false) {
    anima = true;
  }
  
  if (anima == true) {
    t++;
    animation1.display(((57400.00/1280.00)/100.00)*width, ((16700.00/720.00)/100.00)*height);
    if (t==35) {
      anima = false;
      t = 0;
    }
  }

  g = (amp.analyze()*50);

  for (int i=0; i<amp.analyze()*30; i++) { 
    chuva.add(new Gota(random(width), random(-100, -20)));
  }
  
  for (int i=0; i<chuva.size()-1; i++) {
    Gota p = chuva.get(i);
    if(p.done()){
      chuva.remove(i);
    }
  }

  // We must always step through time!
  box2d.step();

  // Run all the particle systems
  for (Gota system : chuva) {
    system.display();
  }

  // Display all the boundaries
  for (Boundary wall : boundaries) {
    wall.display();
  }



println(" vetor -- " + chuva.size() +  " fps ---  " + frameRate);
}
