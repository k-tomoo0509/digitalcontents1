class EllipseWall extends Wall {
  float D;
  EllipseWall(float _x, float _y, float _D) {
    super(_x,_y);
    D = _D;
  }
  
  void display() {
    ellipse(x,y,D,D);
  }
  
  void judge(float cx, float cy, float cD) {
    if(dist(x,y,cx,cy) <= (D + cD)/2 ) {
      touch = true;
    } else {
      touch = false;
    }
  }
}
