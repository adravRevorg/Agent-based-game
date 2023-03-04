int IX(int x, int y) {
  x = constrain(x, 0, N-1);
  y = constrain(y, 0, N-1);
  return x + (y * N);
}

int IX(float x, float y) {
  x = constrain(x, 0, N-1);
  y = constrain(y, 0, N-1);
  return int(x + (y * N));
}

class Fluid {
  
  float[] s0;
  float[] s;
  
  float[] s1_0;
  float[] s1;
  float total_s1 = 0;

  float[] Vx;
  float[] Vy;

  float[] Vx0;
  float[] Vy0;
  
  float[] grid_s; 

  Fluid() {
    
    s0 = new float[N*N];
    s = new float[N*N];
    s1_0 = new float[N*N];
    s1 = new float[N*N];
    grid_s = new float[(N/SCALE1)*(N/SCALE1)];
    

    Vx = new float[N*N];
    Vy = new float[N*N];

    Vx0 = new float[N*N];
    Vy0 = new float[N*N];
  }

  void update() {
    
    float[] Vx      = this.Vx;
    float[] Vy      = this.Vy;
    float[] Vx0     = this.Vx0;
    float[] Vy0     = this.Vy0;
    float[] s0       = this.s0;
    float[] s = this.s;
    float[] s1_0       = this.s1_0;
    float[] s1 = this.s1;
    this.grid_s = new float[(N/SCALE1)*(N/SCALE1)];
    float[] grid_s = this.grid_s;

    //VELOCITY STEP
    diffuse(1, Vx0, Vx, visc);
    diffuse(2, Vy0, Vy, visc);

    project(Vx0, Vy0, Vx, Vy);

    advect(1, Vx, Vx0, Vx0, Vy0);
    advect(2, Vy, Vy0, Vx0, Vy0);

    project(Vx, Vy, Vx0, Vy0);

    //DENSITY STEP (note the swap in next line s0,s and then s,s0)
    diffuse(0, s0, s, diff);
    advect(0, s, s0, Vx, Vy);
    
    diffuse(0, s1_0, s1, diff);
    advect(0, s1, s1_0, Vx, Vy);
    
    battle();
    fade();
    
    //updateCentres(s1,grid_s);
    updateCentresAndObstacles(s1,grid_s);
  }

  void addDensity(int x, int y, float amount) {
    s[IX(x/SCALE, y/SCALE)] += amount;
  }
  
  void addDensity1(int x, int y, float amount) {
    s[IX(x, y)] += amount;
  }
  void addDensity2(int x, int y, float amount) {
    s1[IX(x, y)] += amount;
  }
  

  void addVelocity(int x, int y, float amountX, float amountY) {
    int index = IX(x, y);
    Vx[index] += amountX;
    Vy[index] += amountY;
  }
  
  
  void battle(){
      total_s1 = 0;
      
      for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
          
          int I = IX(i, j);
            
           
           if (s[I]>s1[I]){
                s[I]-=s1[I];    s1[I]=0;
          }
          else{
                //oil
                s1[I]-=s[I];    s[I]=0;
          }
          total_s1+=s1[I];
        }
      }
  }
    
  
  
  void draw(){
    
    noStroke();               
    colorMode(RGB,255);
    
    
    
    background(r0,g0,b0,255);
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < N; j++) {
        int I = IX(i,j);
        
        if (s[I]>s1[I]){ 
          
            fill(r1,g1,b1, s1[I]);    square(i*SCALE, j*SCALE, SCALE);
            
            fill(r,g,b, s[I]*2);      square(i*SCALE, j*SCALE, SCALE);
            
        }else{
            
            fill(r,g,b, s[I]);        square(i*SCALE, j*SCALE, SCALE);
            
            fill(r1,g1,b1, s1[I]*2);  square(i*SCALE, j*SCALE, SCALE);
          
        }
      }
    }
  }

  

  void fade() {
    for (int i = 0; i < s.length; i++) {
      s[i] = constrain(s[i]*(1-chemicalFadeRate/10), 0, 250);
      s1[i] = constrain(s1[i]*(1-oilFadeRate/10), 0, 250);
    }
  }
}
