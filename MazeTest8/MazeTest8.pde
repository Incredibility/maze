int clm = 32, row = 32;
float w, hw;
Cell[][] cll = new Cell[clm][row];
Cell ply, end;

void setup() {
  size(801, 801);
  frameRate(60);
  w = min(width, height) == height ? height/row : width/clm;
  hw = w/2;
  strokeWeight(0.1*w);
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) cll[i][j] = new Cell(i, j);
  ply = cll[0][0];
  end = cll[clm - 1][row - 1];
  end.wll[2] = false;
  Cell crt = cll[floor(random(clm))][floor(random(row))];
  ArrayList<Cell> stk = new ArrayList<Cell>();
  stk.add(crt);
  while (!stk.isEmpty()) {
    crt.vst = true;
    ArrayList<Cell> nbr = new ArrayList<Cell>();
    if (crt.j != 0 && !cll[crt.i][crt.j - 1].vst) nbr.add(cll[crt.i][crt.j - 1]);
    if (crt.i != clm - 1 && !cll[crt.i + 1][crt.j].vst) nbr.add(cll[crt.i + 1][crt.j]);
    if (crt.j != row - 1 && !cll[crt.i][crt.j + 1].vst) nbr.add(cll[crt.i][crt.j + 1]);
    if (crt.i != 0 && !cll[crt.i - 1][crt.j].vst) nbr.add(cll[crt.i - 1][crt.j]);
    if (!nbr.isEmpty()) {
      stk.add(crt);
      Cell nxt = nbr.get(floor(random(nbr.size())));
      if (crt.j - nxt.j == 1) {
        crt.wll[0] = nxt.wll[2] = false;
      } else if (crt.j - nxt.j == -1) {
        crt.wll[2] = nxt.wll[0] = false;
      }
      if (crt.i - nxt.i == 1) {
        crt.wll[3] = nxt.wll[1] = false;
      } else if (crt.i - nxt.i == -1) {
        crt.wll[1] = nxt.wll[3] = false;
      }
      crt = nxt;
    } else {
      crt = stk.remove(stk.size() - 1);
    }
  }
}

void draw() {
  println(frameRate);
  background(255);
  stroke(0);
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) {
    if (cll[i][j].wll[0]) line(cll[i][j].x1, cll[i][j].y1, cll[i][j].x2, cll[i][j].y1);
    if (cll[i][j].wll[1]) line(cll[i][j].x2, cll[i][j].y1, cll[i][j].x2, cll[i][j].y2);
    if (cll[i][j].wll[2]) line(cll[i][j].x2, cll[i][j].y2, cll[i][j].x1, cll[i][j].y2);
    if (cll[i][j].wll[3]) line(cll[i][j].x1, cll[i][j].y2, cll[i][j].x1, cll[i][j].y1);
  }
  stroke(0, 255, 0);
  fill(0, 255, 0);
  ellipse(ply.x3, ply.y3, hw, hw);
}

void keyPressed() {
  if (keyCode == UP && !ply.wll[0] && !cll[ply.i][ply.j - 1].wll[2]) ply = cll[ply.i][ply.j - 1];
  else if (keyCode == RIGHT && !ply.wll[1] && !cll[ply.i + 1][ply.j].wll[3]) ply = cll[ply.i + 1][ply.j];
  else if (keyCode == DOWN && !ply.wll[2] && !cll[ply.i][ply.j + 1].wll[0]) ply = cll[ply.i][ply.j + 1];
  else if (keyCode == LEFT && !ply.wll[3] && !cll[ply.i - 1][ply.j].wll[1]) ply = cll[ply.i - 1][ply.j];
}

class Cell {
  int i, j;
  float x1, y1, x2, y2, x3, y3;
  boolean vst = false;
  boolean[] wll = {true, true, true, true};
  Cell(int i_, int j_) {
    i = i_;
    j = j_;
    x1 = i*w;
    y1 = j*w;
    x2 = x1 + w;
    y2 = y1 + w;
    x3 = x1 + hw;
    y3 = y1 + hw;
  }
}