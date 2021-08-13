class RectWall extends Wall {
  float w,h;
  RectWall(float _x, float _y, float _w, float _h) {
    super(_x,_y);
    w = _w;
    h = _h;
  }
  
  void display() {
    rect(x,y,w,h);
  }
  
  void judge(float cx, float cy, float cD) {
    if( (x <= cx && cx <= x+w && y - cD/2 <= cy && cy <= y+h + cD/2) ||
        (x - cD/2 <= cx && cx <= x+w + cD/2 && y <= cy && cy <= y+h) ||
        (dist(x,y,cx,cy) <= cD/2) ||
        (dist(x+w,y,cx,cy) <= cD/2) ||
        (dist(x,y+h,cx,cy) <= cD/2) ||
        (dist(x+w,y+h,cx,cy) <= cD/2) ) {
      touch = true;
    } else {
      touch = false;
    }
  }
}
