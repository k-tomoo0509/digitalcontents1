class EllipseRoad extends Road {
  float D;
  EllipseRoad(float _x, float _y, float _D) {
    super(_x, _y);
    D = _D;
  }

  void display() {
    ellipse(x, y, D, D);
  }

  void judge(float cx, float cy, float cD) {
    if (dist(x, y, cx, cy) + cD/2 <= D/2 ) {
      in = true;
    } else {
      in = false;
    }
  }
}
