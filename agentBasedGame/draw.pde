void draw() {
  
  if (pause)    return;
    
  add_UI();
  fluid.draw();
  flock.draw();
  
  fluid.update();
  flock.update();
  
  decisionCheck();
  
  newGameTimer++;
  
}


void obstacles_draw(){
  fill(r1,g1,b1); stroke(100);
  
  for(int i=0;i<O;i++){
    circle(xc[i].x, xc[i].y,R[i]);
  }
  
  
  //grid check
  int n = N/SCALE1;noFill();stroke(100);
  for(int i=0; i<n;i++){
    for(int j=0;j<n;j++){
      noFill();
      square(i*SCALE1*SCALE, j*SCALE1*SCALE, SCALE1*SCALE);
      fill(100);
      circle(xc[j*n + i].x, xc[j*n + i].y,10);
    }
  }
  
}

void keyPressed(){
  
  if (key=='w'){
  saveFrame("frames/3.png");
  background(r0,g0,b0);
  obstacles_draw();
  saveFrame("frames/cumulatedDye.png");
  }
  else if (key=='p'){
    pause=!pause;}
}
