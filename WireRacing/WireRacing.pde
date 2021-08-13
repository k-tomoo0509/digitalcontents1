boolean left, right, up, down, click, key_a, key_d, key_w, key_s;
float mx, my, sx, sy, rdx, rdy, ex, ey, gx, gy;
PImage ufo, logo, ufo_title;
color bg1, bg2, bg3, bg4, rc, wc;
String scene = "start";
float ms = 0, beforeMs = 0, addMs = 0, ready = 0;
int n = 5;
float [] times = new float[n];
String[] time_data = new String[n];
int end, start;
Wall[] wall = new Wall[13];
Road[] road = new Road[13];
Road r_sample;
Player player, p_sample;
import java.util.Arrays;
import java.util.List;
PFont myFont;
import ddf.minim.*;
Minim minim;
AudioPlayer titleBGM, raceBGM, goalBGM, buttonSE, startSE, wireSE;

void setup() {
  size(1280, 720);
  r_sample = new RectRoad(width/4, height/2, width/2, height/3);
  p_sample = new Player(width/4+width/4, height/2+height/6, 20, 1, 0);
  wall[0] = new EllipseWall(width/2, height/2-400, 40);
  wall[1] = new EllipseWall(width/2, height/2-580, 40);
  wall[2] = new EllipseWall(width/2, height/2-220, 40);
  wall[3] = new EllipseWall(width/2-155, height/2-490, 40);
  wall[4] = new EllipseWall(width/2-155, height/2-310, 40);
  wall[5] = new EllipseWall(width/2+155, height/2-490, 40);
  wall[6] = new EllipseWall(width/2+155, height/2-310, 40);
  wall[7] = new RectWall(width/2-600, height/2-480-20, 300, 20);
  wall[8] = new RectWall(width/2-600, height/2-320, 300, 20);
  wall[9] = new RectWall(width/2+600-100, height/2-600, 20, 100);
  wall[10] = new RectWall(width/2+600-100, height/2-400, 20, 100);
  wall[11] = new RectWall(width/2+600-300, height/2-500, 20, 100);
  wall[12] = new RectWall(width/2+600-300, height/2-300, 20, 100);
  road[0] = new EllipseRoad(width/2 - 800, height/2-400, 200);
  road[1] = new EllipseRoad(width/2 + 800, height/2-400, 200);
  road[2] = new RectRoad(width/2 - 800, height/2 - 500, 1600, 200);
  road[3] = new RectRoad(width/2 - 650, height/2 - 600, 1300, 400);
  road[4] = new RectRoad(width/2 - 900, height/2 - 400, 200, 800);
  road[5] = new RectRoad(width/2 + 700, height/2 - 400, 200, 800);
  road[6] = new EllipseRoad(width/2 - 800, height/2+400, 200);
  road[7] = new EllipseRoad(width/2 + 800, height/2+400, 200);
  road[8] = new RectRoad(width/2 - 800-10, height/2 + 300, 350, 200);
  road[9] = new RectRoad(width/2 + 800 - 320-30, height/2 + 300, 350, 200);
  road[10] = new RectRoad(width/2 - 800 + 320-20, height/2 + 200, 360, 200);
  road[11] = new RectRoad(width/2 + 320/2-20, height/2 + 200, 360, 200);
  road[12] = new RectRoad(width/2 - 320/2-20, height/2 + 100, 360, 200);
  player = new Player(width/2-800, height/2, 20, 1, 0);
  ufo = loadImage("alien_ufo.png");
  ufo_title = loadImage("alien_ufo.png");
  ufo_title.filter(GRAY);
  logo = loadImage("logo_white.png");
  bg1 = color(30, 10, 75);
  bg2 = color(20, 140, 250);
  bg3 = color(0, 0, 100);
  bg4 = color(100, 100, 250);
  rc = color(200, 200, 255);
  wc = color(50, 10, 150);
  sx = width/2;
  sy = height*3/5;
  rdx = 370;
  rdy = 70;
  ex = gx = width*1/2;
  ey = gy = height*9/10;
  time_data = loadStrings("time_data.txt");
  for (int i = 0; i<times.length; i++) {
    times[i] = float(time_data[i]);
    println(times[i]);
  }
  String[] fontList = PFont.list();
  if (Arrays.asList(fontList).contains("游ゴシック体")) {
    myFont = createFont("游ゴシック体", 24);
  } else if (Arrays.asList(fontList).contains("游ゴシック")) {
    myFont = createFont("游ゴシック", 24);
  } else if (Arrays.asList(fontList).contains("Meiryo UI")) {
    myFont = createFont("Meiryo UI", 24);
  } else if (Arrays.asList(fontList).contains("メイリオ")) {
    myFont = createFont("メイリオ", 24);
  } else if (Arrays.asList(fontList).contains("ヒラギノ角ゴ Pro W3")) {
    myFont = createFont("ヒラギノ角ゴ Pro W3", 24);
  } else if (Arrays.asList(fontList).contains("ヒラギノ角ゴ ProN W3N")) {
    myFont = createFont("ヒラギノ角ゴ ProN W3", 24);
  } else if (Arrays.asList(fontList).contains("HiraKakuProN-W3")) {
    myFont = createFont("HiraKakuProN-W3", 24);
  } else if (Arrays.asList(fontList).contains("Droid Sans")) {
    myFont = createFont("Droid Sans", 24);
  } else if (Arrays.asList(fontList).contains("IPAモナー UIゴシック")) {
    myFont = createFont("IPAモナー UIゴシック", 24);
  } else if (Arrays.asList(fontList).contains("Noto Sans CJK JP")) {
    myFont = createFont("Noto Sans CJK JP", 24);
  } else if (Arrays.asList(fontList).contains("Takao Pゴシック")) {
    myFont = createFont("Takao Pゴシック", 24);
  } else {
    println("フォントデータが見つかりませんでした。");
  }
  textFont(myFont);

  minim = new Minim(this);
  titleBGM = minim.loadFile("u-chi-u.mp3");
  titleBGM.setGain(-15);
  raceBGM =  minim.loadFile("fuyugomorioffvofix.mp3");
  raceBGM.setGain(-15);
  goalBGM =  minim.loadFile("letstalk.mp3");
  goalBGM.setGain(-15);
  buttonSE =  minim.loadFile("Shortbridge30-3.mp3");
  buttonSE.setGain(-5);
  startSE =  minim.loadFile("Countdown01-2.mp3");
  startSE.setGain(-5);
  wireSE =  minim.loadFile("Motion-Pop43-1.mp3");
  wireSE.setGain(-5);
  titleBGM.play(1500);
}

void draw() {
  background(0);
  if (scene == "start") {
    start_scene();
    end = 0;
    start = 0;
    addMs = 0;
  } else if (scene == "explanation") {
    explanation_scene();
  } else if (scene == "game") {
    mx = mouseX;
    my = mouseY;
    noStroke();
    for (float i = 0; i < height; i += 5) {
      color c = lerpColor(bg1, bg2, i/height);
      fill(c);
      rect(0, i, width, 5);
    }
    pushMatrix();
    translate(width/2, height/2);
    translate(-width/2, - height/2);
    translate(width/2-player.x, height/2-player.y);
    fill(rc);
    stroke(255);
    strokeWeight(10);
    for (int i = 0; i < road.length; i++) {
      road[i].display();
    }
    noStroke();
    for (int i = 0; i < road.length; i++) {
      road[i].display();
    }
    fill(0, 50);
    triangle(width/2 - 800, height/2-100, width/2 - 800+50, height/2-100+50, width/2 - 800-50, height/2-100+50);
    rect(width/2 - 800-25, height/2-100+50, 50, 100);
    fill(wc);
    stroke(255);
    strokeWeight(10);
    for (int i = 0; i < wall.length; i++) {
      wall[i].display();
    }
    noStroke();
    for (int i = 0; i < wall.length; i++) {
      wall[i].display();
    }
    stroke(0);
    strokeWeight(1);
    fill(255);
    player.move(wall, road, ms);
    player.display();
    popMatrix();
    display_time() ;
    fill(0, 0, 255);
    click = mousePressed;
    if (!player.clear) {
      if (start < 1) {
        addMs = millis()-beforeMs;
        start = 1;
      }
      ms = millis()-addMs-beforeMs;

      textAlign(CENTER, CENTER);
      textSize(150);
      fill(255);

      if (ms/1000 < 1) {
        textBorder("3", width/2, height/2-50, 8, color(255), color(255, 200, 20));
      } else if (ms/1000 < 2) {
        textBorder("2", width/2, height/2-50, 8, color(255), color(255, 200, 20));
      } else if (ms/1000 < 3) {
        textBorder("1", width/2, height/2-50, 8, color(255), color(255, 200, 20));
      } else if (ms/1000 < 3.5) {
        textBorder("START", width/2, height/2-50, 8, color(255), color(255, 200, 20));
      }
    } else if (player.clear) {
      if (end < 1) {
        times = ranking(times, ms);
        end++;
      }
      display_ranking();
      textAlign(CENTER, CENTER);
      textSize(150);
      textBorder("FINISH", width/2, height/2-50, 8, color(255), color(255, 200, 20));
      stroke(0);
      strokeWeight(5);
      fill(255, 255, 0, 150);
      rect(gx-rdx/2, gy-rdy/2, rdx, rdy, 20);
      textSize(40);
      fill(255);
      textBorder("タイトルに戻る", gx, gy-5, 2, color(255), color(0));
    }
  }
}

void mousePressed() {
  if (scene == "start") {
    if (judge(sx-200, sy, rdx, rdy, mouseX, mouseY)) {
      buttonSE.play(0);
      titleBGM.pause();
      raceBGM.play(0);
      startSE.play(0);
      scene = "game";
    }
    if (judge(sx+200, sy, rdx, rdy, mouseX, mouseY)) {
      buttonSE.play(0);
      scene = "explanation";
    }
  } else if (scene == "explanation") {
    if (judge(ex, ey, rdx, rdy, mouseX, mouseY)) {
      buttonSE.play(0);
      scene = "start";
    }
  } else if (player.clear) {
    if (judge(gx, gy, rdx, rdy, mouseX, mouseY)) {
      buttonSE.play(0);
      goalBGM.pause();
      setup();
      scene = "start";
      beforeMs = ms;
      start = 0;
    }
  } else if (scene == "game") {
  }
}

void start_scene() {
  titleBG();
  image(logo, width/2-logo.width*1.5/2, height/4, logo.width*1.5, logo.height*1.5);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(20);
  text("©2021 CR7,石川浩太,香西智雄,苅田悠也", width/2, 4*height/5);
  stroke(0);
  strokeWeight(5);
  fill(255, 255, 0, 150);
  rect(sx-rdx/2-200, sy-rdy/2, rdx, rdy, 20);
  rect(sx-rdx/2+200, sy-rdy/2, rdx, rdy, 20);
  textSize(40);
  fill(255);
  textBorder("スタート", sx-200, sy-5, 2, color(255), color(0));
  textBorder("操作説明", sx+200, sy-5, 2, color(255), color(0));
}

void explanation_scene() {
  titleBG();
  textAlign(LEFT, CENTER);
  textSize(30);
  fill(255);
  text("操作説明", width/4, 50);
  text("ワイヤーを出したい方向にマウスクリックする", width/4, 150);
  text("クリックしている間、ワイヤーは射出したまま伸びていく!!", width/4, 200);
  text("ワイヤーが壁に当たり、刺さったら、その場所まで移動!!", width/4, 250);
  text("マウスクリックをやめると、ワイヤーは元に戻る", width/4, 300);
  textAlign(CENTER, CENTER);
  text("あなた", width/2, height*3/4);
  p_sample.display();

  stroke(0);
  strokeWeight(5);
  fill(255, 255, 0, 150);
  rect(ex-rdx/2, ey-rdy/2, rdx, rdy, 20);
  textSize(40);
  fill(255);
  textBorder("タイトルに戻る", ex, ey-5, 2, color(255), color(0));
}

void display_time() {
  textAlign(LEFT, CENTER);
  textSize(20);
  int n = getDigit(int(ms/1000-player.readyTime));
  String time = nf(ms/1000-player.readyTime, n, 3);
  textBorder("TIME: "+time, 10, 20, 1, color(255), color(0));
}

int getDigit(int ms) {
  int count = 0;
  while (ms != 0) {
    ms/=10;
    count++;
  }
  return count;
}

float [] ranking(float [] times, float ms) {
  float [] buf = new float[times.length];
  for (int i = 0; i<times.length; i++) {
    buf[i] = times[i];
    println(buf[i]);
  }

  for (int i = 0; i<times.length; i++) {
    if (times[i] > ms/1000-player.readyTime) {
      for (int u = i; u<times.length-1; u++) {
        println(times[u+1], buf[u]);
        times[u+1] = buf[u];
      }
      times[i] = ms/1000-player.readyTime;
      break;
    }
  }
  return times;
}

void display_ranking() {
  textAlign(LEFT, CENTER);
  textSize(30);
  for (int i = 0; i<times.length; i++) {
    int n = getDigit(int(times[i]));
    time_data[i] = nf(times[i], n, 3);
  }
  saveStrings("time_data.txt", time_data);
  for (int i = 0; i<times.length; i++) {
    textBorder((i+1)+":"+time_data[i], width-200, 50+100*i, 2, color(255), color(0));
  }
}

boolean judge(float x, float y, float rx, float ry, float mx, float my) {
  if (x-rx/2 < mx && x+rx/2 > mx && y-ry/2 < my && y+ry/2 > my) {
    return true;
  }
  return false;
}

void titleBG() {
  background(255);
  image(ufo_title, width/2, height/2-ufo_title.height*1.75, 3*ufo_title.width, 3*ufo_title.height);
  noStroke();
  for (float i = 0; i < height; i += height/10) {
    color c = lerpColor(bg4, bg3, i/height);
    fill(c, 200);
    rect(0, i, width, height/10);
  }
}

void textBorder(String s, float x, float y, int b, color c1, color c2) {
  for (int j = -b; j <= b; j++) {
    fill(c1);
    for (int k = -b; k <= b; k++) {
      text(s, x+j, y+k);
    }
  }
  fill(c2);
  text(s, x, y);
}

void keyPressed() {
  if (key == 'a') key_a = true;
  if (key == 'd') key_d = true;
  if (key == 'w') key_w = true;
  if (key == 's') key_s = true;
}

void keyReleased() {
  if (key == 'a') key_a = false;
  if (key == 'd') key_d = false;
  if (key == 'w') key_w = false;
  if (key == 's') key_s = false;
}
