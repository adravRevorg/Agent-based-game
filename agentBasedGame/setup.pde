void settings() {
  size(N*SCALE+margin, N*SCALE);
  //fullScreen();
}

void setup() {
  init();
  add_UI();
  addObstacles();
}

void init(){
  fluid = new Fluid();
  flock = new Flock();
  
  fish = loadImage("fish.png");
  fish.resize(25,0);
  
  fish_weak = loadImage("fish_red.png");
  fish_weak.resize(25,0);
  
  textSize(20);
  
}
void addObstacles(){
  O = N/SCALE1; O*=O;   O_n = O;
  xc = new PVector[O];
  R = new float[O];
  for(int i=0; i<O; i++){
    xc[i] = new PVector(random(width*0.75),random(height));
    R[i] = random(50,120);
  }
}
