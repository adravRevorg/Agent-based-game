void mouseDragged() {
  
  if (oilSpillTotal>=maxOilSpill || mouseButton==LEFT)  return;
      
  int cx = mouseX;
  int cy = mouseY;
  int n = SCALE;
  if (cx<5 || cx>width-margin || cy<4 || cy >height)  return;
  cx = constrain(mouseX/SCALE,0,N);
  cy = constrain(mouseY/SCALE,0,N);
  for (int i = -n; i <= n; i++) {
    for (int j = -n; j <= n; j++) {
       
          fluid.addDensity2(cx+i, cy+j,250); // 250
          oilSpillTotal+=0.0025;
       
    }
  }
  for (int i = 0; i < 2; i++) {
    float angle = noise(t) * TWO_PI * 2;
    PVector v = PVector.fromAngle(angle);
    v.mult(0.5);
    t += 0.01;
    fluid.addVelocity(cx, cy, v.x, v.y );
  }
  
}

void updateCentresAndObstacles(float[] s, float[] grid){
  
  int n = N/SCALE1;
  
  //reset to zero values
  xc = new PVector[O];
  R = new float[O];
  for(int i=0; i<O; i++){
    xc[i] = new PVector(0,0);
  }
  
  for(int i=0;i<N;i++){
    for(int j=0; j<N;j++){
      
      //for grid sake
      int row = j/SCALE1, col = i/SCALE1;
      int I = row*n + col;
      grid[I]+=s[IX(i,j)];
      
      //for obstacle sake
      float x = i*SCALE; float y = j*SCALE;
      
      PVector loc = new PVector(x,y);
      
      loc.setMag(s[IX(i,j)]);
      xc[I].add(loc);
    }
  }
  for(int i=0; i<n;i++){
    for(int j=0;j<n;j++){
        
      R[j*n + i] = map(grid[j*n + i],0,20000,0,40);
      xc[j*n + i].limit(SCALE1*SCALE);  
      /* Last line is SUPER IMPORTANT ! because vector addition can exceeed sktech , because we are multiplying with density values
      Basically, kind of normalising*/
      xc[j*n + i].add(new PVector(i*SCALE1*SCALE,j*SCALE1*SCALE));
    }
  }
  O = O_n;
}


void decisionCheck(){
  
  fishes_Alive = flock.no - flock.dead;
  oil_Left = maxOilSpill - oilSpillTotal;
  
  if (flock.dead==flock.no)  {
      background(r0,g0,b0);  fill(0);
      String s = "       " + gameCtr + "                      DEAD                                               SURVIVED ( " + int(oilSpillTotal) + "  units of Oil used)                        " + newGameTimer;
      
      str = str + "\n" + s;
      
      text(str, 100,300);
      stroke(0);strokeWeight(3);
      line(100,320,950,320);
      line(220,300,220,800);
      pause = true;
  }
  else if(fluid.total_s1<80000 && newGameTimer>50){
      background(r0,g0,b0);fill(0);
      
      
      
      String s = "       " + gameCtr + "                    SURVIVED ( " + int(fishes_Alive) + " alive)                                       DEAD                                                           " + newGameTimer;
      str = str + "\n" + s;
      
      text(str, 100,300);
      stroke(0);strokeWeight(3);
      line(100,320,950,320);
      line(220,300,220,800);
      pause = true;
  }
  
}
    
      
void decisionToSpread(){
  int ctr = 0;
  for(int j=0;j<O_n;j++){
    if (R[j]<10)
        ctr++;
  }
  if (ctr>=O_n/2)  maxForceAvoid = 5;
  else             maxForceAvoid = 0.2;
}
  
  

  
