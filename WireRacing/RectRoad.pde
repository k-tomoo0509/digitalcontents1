class RectRoad extends Road {
  float w,h;
  boolean bx,by;
  RectRoad(float _x, float _y, float _w, float _h) {
    super(_x,_y);
    w = _w;
    h = _h;
  }
  
  void display() {
    rect(x,y,w,h);
  }
  
  void judge(float cx, float cy, float cD) {
    if(x + cD/2 <= cx && cx <= x+w - cD/2 && y + cD/2 <= cy && cy <= y+h - cD/2) {
      in = true;
    } else {
      in = false;
    }
  }
}
