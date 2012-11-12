import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;

float lastX;
float lastY;

void setup(){
  
  size(640, 480);
  kinect= new SimpleOpenNI(this);
  
  kinect.enableDepth();
//  kinect.enableRGB();
 
}

void draw(){
  
  closestValue = 8000;
  
kinect.update();


 int[] depthValues = kinect.depthMap();
 
 for( int y=0; y<480; y++){
   for(int x=0; x<640; x++){
     
     int reversedX = 640-x-1;
     
     int i = reversedX+y *640;
     int currentDepthValue = depthValues[i];
     
     if(currentDepthValue >610 && currentDepthValue < 1525 && currentDepthValue < closestValue){
       closestValue= currentDepthValue;
       closestX = x;
       closestY = y;
     }
   }
 }
  
float interpolatedX = lerp(lastX, closestX, 0.3f);
float interpolatedY = lerp(lastY, closestY, 0.3f);


//PImage depthImage= kinect.depthImage();
//PImage rgbImage= kinect.rgbImage();

//image(depthImage, 0,0);
//image(rgbImage, 640,0);

stroke(255,0,0);

strokeWeight(3);

line(lastX, lastY, interpolatedX, interpolatedY);

lastX = interpolatedX;
lastY = interpolatedY;

}

void mousePressed(){
  background(0);
}
