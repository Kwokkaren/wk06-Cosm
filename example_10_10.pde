// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-10: The raindrop catching game
import cosm.*;
import processing.serial.*;
DataIn feed;
Serial myPort;


Catcher catcher;    // One catcher object
Timer timer;        // One timer object
Drop[] drops;       // An array of drop objects
int totalDrops = 0; // totalDrops

String apiKey = "oRTUQtCRy3XWTZxOtLqb70GebRKSAKxyNXh4UVRwWFRGYz0g"; //COSM API Key
String feedId = "77927"; //COSM Feed ID

float feedValue;

int count = 0;
int currentTime;
int prevTime;
int retrieveInterval = 1000; // data retrieving interval in microsecond(1000ms = 1s);


void setup() {
  size(400,400);
  smooth();
feed = new DataIn(this, apiKey, feedId);
  
  catcher = new Catcher(15); // Create the catcher with a radius of 32
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(300);   // Create a timer that goes off every 2 seconds
  timer.start();             // Starting the timer
}


void draw() {
  background(255);
  
  // Set catcher location
  catcher.setLocation(mouseX,mouseY); 
  // Display the catcher
  catcher.display(); 
  
  // Check the timer
  if (timer.isFinished()) {
    // Deal with raindrops
    // Initialize one drop
    drops[totalDrops] = new Drop();
    // Increment totalDrops
    totalDrops ++ ;
    // If we hit the end of the array
    if (totalDrops >= drops.length) {
      totalDrops = 0; // Start over
    }
    timer.start();
  }
  
  // Move and display all drops
  for (int i = 0; i < totalDrops; i++ ) {
    drops[i].move();
    drops[i].display();
    if (catcher.intersect(drops[i])) {
      drops[i].caught();
    }
  }
}



