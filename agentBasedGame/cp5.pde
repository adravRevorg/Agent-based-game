import controlP5.*;

ControlP5 cp5;

int slider_length;
int slider_height;
float xpos;

boolean reset = true;

Textarea text0, text1, text2, text3, text4;

void add_UI(){
  cp5 = new ControlP5(this);
  
  slider_length = floor(width*0.1);
  slider_height = 15;
  xpos = width - margin/2;
  int p = 150, g = 22;
  
  cp5.setColorForeground(color(32,42,68));      //16,42,42
  cp5.setColorCaptionLabel(color(32,42,68));
  cp5.setColorBackground(color(53,81,92));
  
  //Flocking Control
  text0 = cp5.addTextarea("txt")
                  .setPosition(xpos,p)
                  .setLineHeight(30)
                  .setColor(color(0));
                  ;p+=g;
  text0.setText("FLOCKING   CONTROLS");
  
  cp5.addSlider("maxForceSteer")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
     
  cp5.addSlider("maxForceAvoid")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
     
  cp5.addSlider("maxForceCenter")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
     
  cp5.addSlider("maxForceAvoidObs")
     .setPosition(xpos,p)
     .setRange(0,20)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
     
 cp5.addSlider("maxForce")
     .setPosition(xpos,p)
     .setRange(0,20)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g;
  
  /*
  cp5.addSlider("ka")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
  
  cp5.addSlider("kc")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ; p+=g; 
    
  cp5.addSlider("ks")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("k_obs")
     .setPosition(xpos,p)
     .setRange(0,15)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
  */   
  cp5.addSlider("maxSpeedSteer")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("maxSpeedCenter")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
  
  cp5.addSlider("maxSpeedAvoid")
     .setPosition(xpos,p)
     .setRange(0,5)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("maxSpeed")
     .setPosition(xpos,p)
     .setRange(0,10)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("time_concern")
     .setPosition(xpos,p)
     .setRange(0,10)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=2*g;
     
 text1 = cp5.addTextarea("txt1")
                  .setPosition(xpos,p)
                  .setLineHeight(30)
                  .setColor(color(0));
                  ;p+=g;
 text1.setText("FLUID   CONTROLS");
     
 cp5.addSlider("visc")
     .setPosition(xpos,p)
     .setRange(0,10)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
 cp5.addSlider("dt")
     .setPosition(xpos,p)
     .setRange(0,1)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
 cp5.addSlider("rad")
     .setPosition(xpos,p)
     .setRange(0,200)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=2*g;
     
 text2 = cp5.addTextarea("txt2")
                  .setPosition(xpos,p)
                  .setLineHeight(30)
                  .setColor(color(0));
                  ;p+=g;
 text2.setText("COMBAT   CONTROLS");
 
 cp5.addSlider("healthLoss")
     .setPosition(xpos,p)
     .setRange(0,50)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
 cp5.addSlider("healthGain")
     .setPosition(xpos,p)
     .setRange(0,50)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("oilFadeRate")
     .setPosition(xpos,p)
     .setRange(0,1)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("chemicalFadeRate")
     .setPosition(xpos,p)
     .setRange(0,1)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("OilInjectRate")
     .setPosition(xpos,p)
     .setRange(0,10)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("ChemInjectRate")
     .setPosition(xpos,p)
     .setRange(0,10)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  p+=2*g; 
   
  text3 = cp5.addTextarea("txt3")
                  .setPosition(xpos,p)
                  .setLineHeight(30)
                  .setColor(color(0));
                  ;p+=g;
  text3.setText("CURRENT  STATUS");
  
  cp5.addSlider("fishes_Alive")
     .setPosition(xpos,p)
     .setRange(0,flock.no)
     .setWidth(slider_length)
     .setHeight(slider_height + 5)
     ;  p+=g;
     
  cp5.addSlider("oil_Left")
     .setPosition(xpos,p)
     .setRange(0,flock.no)
     .setWidth(slider_length)
     .setHeight(slider_height + 5)
     ;  p+=g;   
   
   p+=2*g;
   
  
  
  cp5.addButton("reset")
     .setValue(0)
     .setPosition(xpos,p)
     .setSize(100,slider_height)
     ; p+=g;
   text4 = cp5.addTextarea("txt4")
                    .setPosition(xpos,p)
                    .setLineHeight(30)
                    .setColor(color(0));
                    ;p+=2*g;
    text4.setText("PLAY    AGAIN");
     
     
  /* color Changing controls
  cp5.addSlider("r")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
 
  cp5.addSlider("g")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("b")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("r1")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
 
  cp5.addSlider("g1")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("b1")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("r0")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
 
  cp5.addSlider("g0")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;
     
  cp5.addSlider("b0")
     .setPosition(xpos,p)
     .setRange(0,255)
     .setWidth(slider_length)
     .setHeight(slider_height)
     ;  p+=g;*/
     
 
     
}

void reset(){
  if (!pause)  {return;}
  //reset for  a new start
  fluid = new Fluid();
  flock = new Flock();
  pause = false;
  newGameTimer = 0;
  oilSpillTotal = 0;
  gameCtr++;
}
