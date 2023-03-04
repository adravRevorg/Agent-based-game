


Fluid fluid;
Flock flock;



//RELATED TO FLUID
int N = 256;
int iter = 16;
int SCALE = 4;      //will have to make sure N is a multiple of scale1 then, else index error issues
int SCALE1 = 32;    //make sure SCALE1 is a divisor of N
float t = 0;

float visc = 0.00001;
float dt = 0.2;
float diff = 0.000;


//RELATED TO FLOCKING
float maxSpeedSteer = 4;
float maxSpeedAvoid = 4;
float maxSpeedCenter = 4;
float maxSpeed = 4;

float maxForceSteer = 0.2;      //steering
float maxForceAvoid = 0.2;      //collision avoidance among themselves
float maxForceCenter = 0.2;     //centering
float maxForceAvoidObs = 3;     //avoiding obstacle
float maxForce = 0.2;           //sum of all

//multipliers for avoid, centering, steering, avoiding obstacle
float ka = 1, kc = 1, ks = 1, k_obs = 1;  

float time_concern = 5;
float rad = 100; //distance of neighbourhood
int O, O_n;                     //obstacles   (O : max obstacles, O_n : current obstacles)
PVector[] xc;
float[] R;




//PARAMETERS RELATED TO THE MODEL

//Fish
float healthLoss = 1;
float healthGain = 0.5;
float chemicalFadeRate = 0.2;
float ChemInjectRate = 3;
float fishes_Alive = 300 ;

//Oil
float OilInjectRate = 3;
float oilFadeRate = 0.2;
float maxOilSpill = 300;
float oilSpillTotal = 0;
float oil_Left = 0;

//Interacticty related
PImage fish, fish_weak;
float r = 255, g = 199, b = 185;     //     light vermillion
float r1 = 206, g1 = 255, b1 = 185;  //     light green
float r0 = 156, g0 = 205, b0 = 249;

int margin = 500;

boolean pause = false;
float newGameTimer = 0;
String str = "   Game No              Fish                                                                           Oil                                                             Time Taken    \n    ";

float gameCtr = 1;
