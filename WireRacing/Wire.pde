class Wire {
  float x, y, D, t, r, w_x, w_y;
  int cnt = 0;
  int status = 0;//0:停止 1:移動 2:掴み
  Wire(float _x, float _y, float _D) {
    x = _x;
    y = _y;
    D = _D;
  }
  void on(float _x, float _y, float _D, float _t, float _r, float _w_x, float _w_y) {
    x = _x;
    y = _y;
    D = _D;
    t = _t;
    r = _r;
    w_x = _w_x;
    w_y = _w_y;
    cnt = 0;
    status = 1;
    wireSE.play(300);
  }

  void off() {
    cnt = 0;
    status = 0;
  }

  void move() {
    if (status == 1) {
      if (judge() == false) {
        x += r*cos(t) + w_x;
        y += r*sin(t) + w_y;
        cnt++;
      } else {
        status = 2;
      }
      if (cnt > 35) {
        cnt = 0;
        status = 0;
      }
    } else if (status == 2) {
    } else {
    }
  }

  void display(float px, float py) {
    fill(255, 235, 0);
    if (status == 1 || status == 2) {
      stroke(0);
      strokeWeight(3);
      line(px, py-10, x, y);

      stroke(255);
      strokeWeight(2);
      line(px, py-10, x, y);

      stroke(0);
      strokeWeight(1);

      ellipse(x, y, D, D);
    } else {
      stroke(0);
      strokeWeight(2);
      line(px, py-10, px, py-20);

      stroke(255);
      strokeWeight(1);
      line(px, py-10, px, py-20);

      stroke(0);
      strokeWeight(1);

      ellipse(px, py-20, D, D);
    }
  }

  boolean judge() {
    boolean touch = true;
    for (int i = 0; i < road.length; i++) {
      road[i].judge(x, y, D);
      if (road[i].in) {
        touch = false;
      }
    }
    for (int i = 0; i < wall.length; i++) {
      wall[i].judge(x, y, D);
      if (wall[i].touch) {
        touch = true;
      }
    }
    return touch;
  }

  int return_status() {
    return status;
  }

  float return_x() {
    return x;
  }

  float return_y() {
    return y;
  }
}
