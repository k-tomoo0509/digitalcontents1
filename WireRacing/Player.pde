class Player extends Chara {
  boolean[] touch = new boolean[4];
  boolean clear;
  float next_x, next_y;
  float ad, at, pt, w_x = 0, w_y = 0, aw_x, aw_y;
  float up_step = PI/100;
  float mt;
  float pos_t;
  float readyTime;
  int status;
  int beforeQ = 0, roop = 0, end = 0;

  float debug_t;
  Wire wire = new Wire(x, y, 10);
  Player(float _x, float _y, float _D, float _r, float _t) {
    super(_x, _y, _D, _r, _t);
    next_x = _x;
    next_y = _y;
  }

  void display() {
    image(ufo, x-D, y-D, D*2, D*2);
    wire.display(x, y);
  }

  void move(Wall[] wall, Road[] road, float ms) {
    if(ms/1000 < 3) {
      readyTime = ms/1000;
    } else if(!clear) {
      mt = atan2(height/2-my, width/2-mx)+PI;

      if (click) {
        if (wire.return_status() == 0) {
          wire.off();
          wire.on(x, y, 10, mt, 10, w_x, w_y);
        }
      } else {
        wire.off();
      }
      if (key_a) {
        x += cos(mt)*5;
        y += sin(mt)*5;
      }

      wire.move();
      if (wire.return_status() == 2) {
        at = atan2(wire.return_y()-y, wire.return_x()-x);
        ad = dist(x, y, wire.return_x(), wire.return_y());
        w_x += cos(at)/ad;
        w_y += sin(at)/ad;
      }
      next_x = x + w_x*r*10;
      next_y = y + w_y*r*10;
      if (judge(next_x, next_y, D, wall, road) == true) {
        if (judge(next_x, y, D, wall, road) == false) {
          next_y = y;
          w_x *= 0.9;
          w_y = 0;
        } else if (judge(x, next_y, D, wall, road) == false) {
          next_x = x;
          w_x = 0;
          w_y *= 0.9;
        } else {
          next_x = x;
          next_y = y;
          w_x = 0;
          w_y = 0;
        }
      }
      x = next_x;
      y = next_y;
    }
    pos_t = -atan2(player.y-height/2, player.x-width/2);
    if (PI >= pos_t && pos_t >= PI - PI/10) {
      if (status == 3) {
        status = 4;//ゴール
        roop += 1;
        if (roop == 2) {
          clear = true;
          raceBGM.pause();
          goalBGM.play(1500);
        }
      } else {
        status = 1; //スタート
      }
    } else if (PI - PI/10 > pos_t && pos_t >= PI - 2*PI/10) {
      if (status == 1) {
        status = 2; //スタート直後
      }
    } else if (-PI + PI/10 >= pos_t && pos_t > -PI) {
      if (status == 2) {
        status = 3; //スタート直後→ゴール直前
      } else if (status == 1) {
        status = 1; //逆走
      }
    }
  }


  boolean judge(float cx, float cy, float cD, Wall[] wall, Road[] road) {
    boolean t = true;
    for (int i = 0; i < road.length; i++) {
      road[i].judge(cx, cy, cD);
      if (road[i].in) {
        t = false;
      }
    }
    for (int i = 0; i < wall.length; i++) {
      wall[i].judge(cx, cy, cD);
      if (wall[i].touch) {
        t = true;
      }
    }
    return t;
  }
}
