int clm = 32, row = 32;
float w;
Cell[][] cll = new Cell[clm][row];

void setup() {
  size(801, 801);
  frameRate(60);
  w = min(width, height) == height ? height/row : width/clm;
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) cll[i][j] = new Cell(i, j);
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
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) {
    if (cll[i][j].wll[0]) line(cll[i][j].x1, cll[i][j].y1, cll[i][j].x2, cll[i][j].y1);
    if (cll[i][j].wll[1]) line(cll[i][j].x2, cll[i][j].y1, cll[i][j].x2, cll[i][j].y2);
    if (cll[i][j].wll[2]) line(cll[i][j].x2, cll[i][j].y2, cll[i][j].x1, cll[i][j].y2);
    if (cll[i][j].wll[3]) line(cll[i][j].x1, cll[i][j].y2, cll[i][j].x1, cll[i][j].y1);
  }
}

class Cell {
  int i, j;
  float x1, y1, x2, y2;
  boolean vst = false;
  boolean[] wll = {true, true, true, true};
  Cell(int i_, int j_) {
    i = i_;
    j = j_;
    x1 = i*w;
    y1 = j*w;
    x2 = x1 + w;
    y2 = y1 + w;
  }
}