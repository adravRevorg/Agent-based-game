class Flock {

  int no = 300;          //no of fishes
  PVector[] x, v, a;     //state of boids
  
  float[] health;
  float maxHealth = 255;
  
  int wid, hei;
  
  int dead = 0;


  Flock() {
    wid = N*SCALE - 10; hei = height; 
    x = new PVector[no];
    v = new PVector[no];
    a = new PVector[no];
    health = new float[no];
    for (int i=0; i<no; i++) {
      x[i] = new PVector(random(wid), random(hei));
      v[i] = PVector.random2D();
      v[i].setMag(random(2, 4));
      a[i] = new PVector(0, 0);
      health[i] = maxHealth;
    }
  }
  
  

  void draw() {
    
    for (int i=0; i<no; i++) {
      if (health[i]<=0) {continue;}
      display(i);
    }
  }
  
  void update(){
    
    dead=0;
    for (int i=0; i<no; i++) {
      if (health[i]<=0) {dead++; continue;}
      computeForces(i);      
    }
    for (int i=0; i<no; i++) {
      updateState(i);      
    }
    
    addDensity();
    
    //if (frameCount>30) decisionToSpread();
  }

  void updateState(int i) {
    x[i].add(v[i]);
    keepWithin(i);
    
    v[i].add(a[i]);
    
    // v[i].limit(maxSpeed);
    //as per paper, fluid velocity gets added to fish, and reduces for itself
    v[i].add((new PVector(fluid.Vx[IX(x[i].x/SCALE,x[i].y/SCALE)], fluid.Vy[IX(x[i].x/SCALE,x[i].y/SCALE)])).mult(v[i].mag()));
    v[i].limit(maxSpeed);
    fluid.Vx[IX(x[i].x/SCALE,x[i].y/SCALE)]*=0.1;fluid.Vy[IX(x[i].x/SCALE,x[i].y/SCALE)]*=0.1;  
    
  }

  void keepWithin(int i) {
    if (x[i].x<0 )  x[i].x = wid-30;
    else if (x[i].x>wid)  x[i].x = 30;

    if (x[i].y<0 )  x[i].y = hei-30;
    else if (x[i].y>hei)  x[i].y = 30;
  }

  void display(int i) {
    pushMatrix();
    translate(x[i].x+30, x[i].y);
    rotate(-atan(v[i].y/v[i].x)+PI/2);
    if (health[i]<maxHealth/2)
          image(fish_weak,0,0);
    else
          image(fish,0,0);
    popMatrix();
  }

  void computeForces(int i) {

    //reset acceleration
    a[i] = new PVector(0, 0);

    PVector steer = new PVector(0, 0);  //for matching velocity
    PVector center = new PVector(0, 0);
    PVector avoid = new PVector(0, 0);

    float close = 0;


    for (int j=0; j<no; j++) {
      float distSq = (PVector.sub(x[j], x[i])).magSq();
      if (distSq>rad*rad || i==j)  continue;    //if this object is far, no point - not considering this boid

      steer.add(v[j]);
      center.add(x[j]);

      PVector tmp = PVector.sub(x[i], x[j]);
      tmp.div(distSq);
      avoid.add(tmp);

      close++;
    }

    if (close==0) {  //if no neighbour nearby, then, just obstacle avoidance
      a[i].add(computeAvoidObstacle(i).mult(k_obs));
      a[i].limit(maxForce);
      return;
    }

    a[i].add(computeSteer(steer, i, close).mult(ks));
    a[i].add(computeSeparation(avoid, i, close).mult(ka));
    a[i].add(computeCentering(center, i, close).mult(kc));
    a[i].add(computeAvoidObstacle(i).mult(k_obs));
    a[i].limit(maxForce);
    
  }


  //Compute force required to avoid collision with other boids
  PVector computeSeparation(PVector avoid, int i, float close) {
    avoid.div(close);
    avoid.setMag(maxSpeedAvoid);
    avoid.sub(v[i]);
    avoid.limit(maxForceAvoid);
    return avoid;
  }

  //compute force required to reach average local position
  PVector computeCentering(PVector center, int i, float close) {
    center.mult(1/close);      //average local position of this boid, ence the desired position
    center.sub(x[i]);
    center.setMag(maxSpeedCenter);
    center.sub(v[i]);
    center.limit(maxForceCenter);
    return center;
  }

  //Compute the steering force needed to attain the average loca velocity
  PVector computeSteer(PVector steer, int i, float close) {
    steer.mult(1/close);      //average local velocity of this boid, ence the desired velocity
    steer.setMag(maxSpeedSteer);  //just get average direction, and have magnitude as per us
    steer.sub(v[i]);
    steer.limit(maxForceSteer);
    return steer;
  }
  
  void addDensity(){
    for (int i=0; i<no; i++) {
      if (health[i]<=0)
          continue;
      if (fluid.s1[IX(x[i].x/SCALE, x[i].y/SCALE)]<10 )
         { if (fluid.s1[IX(x[i].x/SCALE, x[i].y/SCALE)]>100) health[i] = min(health[i]+healthGain*1.5, maxHealth); 
           else health[i] = min(health[i]+healthGain*1.5, maxHealth);
           continue;}
      
      
      addDens(int(x[i].x),int(x[i].y),i);
      health[i]-=healthLoss*fluid.s1[IX(x[i].x/SCALE, x[i].y/SCALE)]/10;
      //fluid.s1[IX(x[i].x/SCALE, x[i].y/SCALE)]*=0.9;
      
    }
    
  }
  
  
PVector computeAvoidObstacle(int i){
  
   //computeObstacles();
   PVector avoidObs = new PVector(0,0);
   for(int j=0;j<O_n;j++){
     
      if (R[j]==0)  continue;
      
      PVector v_i = PVector.sub(xc[j],x[i]).normalize();
      
      PVector vi = PVector.mult(v_i, v[i].dot(v_i));
      PVector vt = PVector.sub(v[i],vi);
      PVector v_t = vt.copy(); v_t.normalize();
      
      float d = PVector.sub(xc[j],x[i]).mag();
      float t = abs(d-R[j])/vi.mag();
      
      if (v_i.dot(PVector.sub(xc[j],x[i]))<0)  
        {avoidObs = new PVector(0,0); return avoidObs;}
      
      if (t<=time_concern){
        float req_dist = R[j] - t*vt.mag();
        float req_a = 2*req_dist/(t*t);
        avoidObs.add(PVector.mult(v_t,req_a));
      }
     }
     avoidObs.limit(maxForceAvoidObs);
     return avoidObs;
}


  void addDens(int cx, int cy, int k){
    int n = SCALE;
    for (int i = -n; i <= n; i++) {
      for (int j = -n; j <= n; j++) {
        fluid.addDensity(cx+i, cy+j, health[k]*ChemInjectRate);
      }
    }
    for (int i = 0; i < 2; i++) {
      float angle = noise(t) * TWO_PI * 2;
      PVector v = PVector.fromAngle(angle);
      v.mult(5);
      t += 0.01;
      fluid.addVelocity(cx, cy, v.x, v.y );
    }
  }

}
