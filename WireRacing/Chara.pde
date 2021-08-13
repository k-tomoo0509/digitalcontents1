abstract class Chara {
  float x, y, D, r, t;
  float pos_t;
  int status = -1;
  float turnspeed_step = 0.0001*PI*10;
  float turnspeed = 0.0;
  float turnspeed_max = 0.04;

  Chara(float _x, float _y, float _D, float _r, float _t) {
    x = _x;
    y = _y;
    D = _D;
    r = _r;
    t = _t;
  }
}
