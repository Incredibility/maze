int[][] dms = {{8, 8}, {8, 8}};
Maze[] py = new Maze[2];
Maze wnr;

void setup() {
  size(1280, 720);
  focused = true;
  frameRate(60);
  boolean hil = height < width ? true : false;
  for (int[] dms : dms) for (int dim : dms) dim = constrain(dim, 2, int(0.525*min(width, height)));
  py[0] = new Maze(dms[0], 0.475*width, true, hil);
  py[1] = new Maze(dms[1], 0.525*width, false, hil);
  background(240);
  stroke(130);
  for (Maze py : py) py.makeCells();
}

void draw() {
}

class Maze {
  int[] dim;
  float w, hw, sw, ssw;
  float[] pos;
  Cell[][] cll;
  Maze(int[] dim_, float x_, boolean aln_rht_, boolean hil_) {
    dim = dim_;
    float mnm = min(dim[0], dim[1]), mxm = max(dim[0], dim[1]);
    w = hil_ ? 0.775*height/mnm : 0.44*width/mxm;
    hw = max(1, w/2);
    sw = max(1, 128/mnm);
    ssw = sw/4;
    float[] pos_ = {aln_rht_ ? x_ - dim[0]*w : x_, 0.5*height - 0.5*w*dim[1]};
    pos = pos_;
    cll = new Cell[dim[0]][dim[1]];
  }
  void makeCells() {
    strokeWeight(sw);
    for (int i = 0; i < dim[0]; i++) for (int j = 0; j < dim[1]; j++) {
      cll[i][j] = new Cell(this, i, j);
      if (cll[i][j].wll[0]) line(cll[i][j].x1, cll[i][j].y1, cll[i][j].x2, cll[i][j].y1);
      if (cll[i][j].wll[1]) line(cll[i][j].x2, cll[i][j].y1, cll[i][j].x2, cll[i][j].y2);
      if (cll[i][j].wll[2]) line(cll[i][j].x2, cll[i][j].y2, cll[i][j].x1, cll[i][j].y2);
      if (cll[i][j].wll[3]) line(cll[i][j].x1, cll[i][j].y2, cll[i][j].x1, cll[i][j].y1);
    }
  }
}

class Cell {
  float x1, y1, x2, y2, x3, y3;
  boolean[] wll = {true, true, true, true};
  Cell(Maze par_, int i_, int j_) {
    x1 = i_*par_.w + par_.pos[0];
    y1 = j_*par_.w + par_.pos[1];
    x2 = x1 + par_.w;
    y2 = y1 + par_.w;
    x3 = x1 + par_.hw;
    y3 = y1 + par_.hw;
  }
}

//class Maze {
//  int clm, row;
//  float w, hw, xmg, ymg, sw, hsw;
//  Cell[][] cll;
//  Cell gen_crt, crt, end;
//  Maze(int clm_, int row_, float xmg_, float ymg_, boolean aln_rht_) {
//    clm = clm_;
//    row = row_;
//    w = min(width, height) == height ? 0.7*height/row : 0.4*width/clm;
//    hw = max(1, w/2);
//    xmg = aln_rht_ ? xmg_ - clm*w : xmg_;
//    ymg = ymg_;
//    sw = clm > row ? max(1, 128/clm) : max(1, 128/row);
//    hsw = sw/4;
//    cll = new Cell[clm][row];
//    for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) cll[i][j] = new Cell(i, j, xmg, ymg, w, hw);
//    gen_crt = cll[floor(random(clm))][floor(random(row))];
//    ArrayList<Cell> stk = new ArrayList<Cell>();
//    stk.add(gen_crt);
//    while (!stk.isEmpty()) {
//      gen_crt.vst = true;
//      ArrayList<Cell> nbr = new ArrayList<Cell>();
//      if (gen_crt.j != 0 && !cll[gen_crt.i][gen_crt.j - 1].vst) nbr.add(cll[gen_crt.i][gen_crt.j - 1]);
//      if (gen_crt.i != clm - 1 && !cll[gen_crt.i + 1][gen_crt.j].vst) nbr.add(cll[gen_crt.i + 1][gen_crt.j]);
//      if (gen_crt.j != row - 1 && !cll[gen_crt.i][gen_crt.j + 1].vst) nbr.add(cll[gen_crt.i][gen_crt.j + 1]);
//      if (gen_crt.i != 0 && !cll[gen_crt.i - 1][gen_crt.j].vst) nbr.add(cll[gen_crt.i - 1][gen_crt.j]);
//      if (!nbr.isEmpty()) {
//        stk.add(gen_crt);
//        Cell nxt = nbr.get(floor(random(nbr.size())));
//        if (gen_crt.j - nxt.j == 1) {
//          gen_crt.wll[0] = nxt.wll[2] = false;
//        } else if (gen_crt.j - nxt.j == -1) {
//          gen_crt.wll[2] = nxt.wll[0] = false;
//        }
//        if (gen_crt.i - nxt.i == 1) {
//          gen_crt.wll[3] = nxt.wll[1] = false;
//        } else if (gen_crt.i - nxt.i == -1) {
//          gen_crt.wll[1] = nxt.wll[3] = false;
//        }
//        gen_crt = nxt;
//      } else {
//        gen_crt = stk.remove(stk.size() - 1);
//      }
//    }
//    int crt_i = floor(random(2)) == 0 ? 0 : clm - 1, crt_j = floor(random(2)) == 0 ? 0 : row - 1, end_i = crt_i == 0 ? clm - 1 : 0, end_j = crt_j == 0 ? row - 1 : 0;
//    crt = cll[crt_i][crt_j];
//    end = cll[end_i][end_j];
//    int end_wll = floor(random(2));
//    if (end == cll[0][0]) if (end_wll == 0) end.wll[0] = false;
//    else end.wll[3] = false;
//    else if (end == cll[clm - 1][0]) if (end_wll == 0) end.wll[0] = false;
//    else end.wll[1] = false;
//    else if (end == cll[clm - 1][row - 1]) if (end_wll == 0) end.wll[1] = false;
//    else end.wll[2] = false;
//    else if (end == cll[0][row - 1]) if (end_wll == 0) end.wll[2] = false;
//    else end.wll[3] = false;
//  }
//}

//Maze py1, py2;
//int py1_clm = 16, py1_row = 16, py2_clm = 16, py2_row = 16;
//int wnr;

//void setup() {
//  size(1920, 1080);
//  frameRate(60);
//  rectMode(CORNERS);
//  focused = true;
//  py1_clm = constrain(py1_clm, 2, 378);
//  py1_row = constrain(py1_row, 2, 378);
//  py2_clm = constrain(py2_clm, 2, 378);
//  py2_row = constrain(py2_row, 2, 378);
//  py1 = new Maze(py1_clm, py1_row, 0.45*width, 0.15*height, true);
//  py2 = new Maze(py2_clm, py2_row, 0.55*width, 0.15*height, false);
//}

//void draw() {
//  println(frameRate);
//  background(250);
//  stroke(130);
//  strokeWeight(py1.sw);
//  for (int i = 0; i < py1_clm; i++) for (int j = 0; j < py1_row; j++) {
//    if (py1.cll[i][j].wll[0]) line(py1.cll[i][j].x1, py1.cll[i][j].y1, py1.cll[i][j].x2, py1.cll[i][j].y1);
//    if (py1.cll[i][j].wll[1]) line(py1.cll[i][j].x2, py1.cll[i][j].y1, py1.cll[i][j].x2, py1.cll[i][j].y2);
//    if (py1.cll[i][j].wll[2]) line(py1.cll[i][j].x2, py1.cll[i][j].y2, py1.cll[i][j].x1, py1.cll[i][j].y2);
//    if (py1.cll[i][j].wll[3]) line(py1.cll[i][j].x1, py1.cll[i][j].y2, py1.cll[i][j].x1, py1.cll[i][j].y1);
//  }
//  strokeWeight(py2.sw);
//  for (int i = 0; i < py2_clm; i++) for (int j = 0; j < py2_row; j++) {
//    if (py2.cll[i][j].wll[0]) line(py2.cll[i][j].x1, py2.cll[i][j].y1, py2.cll[i][j].x2, py2.cll[i][j].y1);
//    if (py2.cll[i][j].wll[1]) line(py2.cll[i][j].x2, py2.cll[i][j].y1, py2.cll[i][j].x2, py2.cll[i][j].y2);
//    if (py2.cll[i][j].wll[2]) line(py2.cll[i][j].x2, py2.cll[i][j].y2, py2.cll[i][j].x1, py2.cll[i][j].y2);
//    if (py2.cll[i][j].wll[3]) line(py2.cll[i][j].x1, py2.cll[i][j].y2, py2.cll[i][j].x1, py2.cll[i][j].y1);
//  }
//  fill(0, 255, 0);
//  strokeWeight(py1.hsw);
//  ellipse(py1.crt.x3, py1.crt.y3, py1.hw, py1.hw);
//  strokeWeight(py2.hsw);
//  ellipse(py2.crt.x3, py2.crt.y3, py2.hw, py2.hw);
//  if (wnr != 0) {
//    stroke(80);
//    fill(0, 100);
//    if (wnr == 1) {
//      strokeWeight(py2.sw);
//      rect(py2.cll[0][0].x1, py2.cll[0][0].y1, py2.cll[py2.clm - 1][py2.row - 1].x2, py2.cll[py2.clm - 1][py2.row - 1].y2, py2.hsw);
//    } else {
//      strokeWeight(py1.sw);
//      rect(py1.cll[0][0].x1, py1.cll[0][0].y1, py1.cll[py1.clm - 1][py1.row - 1].x2, py1.cll[py1.clm - 1][py1.row - 1].y2, py1.hsw);
//    }
//  }
//}

//void keyPressed() {
//  if (wnr == 0) {
//    if (key == 'w' && !py1.crt.wll[0] && !py1.cll[py1.crt.i][py1.crt.j - 1].wll[2] || key == 'W' && !py1.crt.wll[0] && !py1.cll[py1.crt.i][py1.crt.j - 1].wll[2]) py1.crt = py1.cll[py1.crt.i][py1.crt.j - 1];
//    else if (key == 'd' && !py1.crt.wll[1] && !py1.cll[py1.crt.i + 1][py1.crt.j].wll[3] || key == 'D' && !py1.crt.wll[1] && !py1.cll[py1.crt.i + 1][py1.crt.j].wll[3]) py1.crt = py1.cll[py1.crt.i + 1][py1.crt.j];
//    else if (key == 's' && !py1.crt.wll[2] && !py1.cll[py1.crt.i][py1.crt.j + 1].wll[0] || key == 'S' && !py1.crt.wll[2] && !py1.cll[py1.crt.i][py1.crt.j + 1].wll[0]) py1.crt = py1.cll[py1.crt.i][py1.crt.j + 1];
//    else if (key == 'a' && !py1.crt.wll[3] && !py1.cll[py1.crt.i - 1][py1.crt.j].wll[1] || key == 'A' && !py1.crt.wll[3] && !py1.cll[py1.crt.i - 1][py1.crt.j].wll[1]) py1.crt = py1.cll[py1.crt.i - 1][py1.crt.j];
//    if (keyCode == UP && !py2.crt.wll[0] && !py2.cll[py2.crt.i][py2.crt.j - 1].wll[2]) py2.crt = py2.cll[py2.crt.i][py2.crt.j - 1];
//    else if (keyCode == RIGHT && !py2.crt.wll[1] && !py2.cll[py2.crt.i + 1][py2.crt.j].wll[3]) py2.crt = py2.cll[py2.crt.i + 1][py2.crt.j];
//    else if (keyCode == DOWN && !py2.crt.wll[2] && !py2.cll[py2.crt.i][py2.crt.j + 1].wll[0]) py2.crt = py2.cll[py2.crt.i][py2.crt.j + 1];
//    else if (keyCode == LEFT && !py2.crt.wll[3] && !py2.cll[py2.crt.i - 1][py2.crt.j].wll[1]) py2.crt = py2.cll[py2.crt.i - 1][py2.crt.j];
//    if (py1.crt == py1.end) wnr = 1;
//    else if (py2.crt == py2.end) wnr = 2;
//  }
//}

////ArrayIndexOutOfBoundsException: -1

//class Maze {
//  int clm, row;
//  float w, hw, xmg, ymg, sw, hsw;
//  Cell[][] cll;
//  Cell gen_crt, crt, end;
//  Maze(int clm_, int row_, float xmg_, float ymg_, boolean aln_rht_) {
//    clm = clm_;
//    row = row_;
//    w = min(width, height) == height ? 0.7*height/row : 0.4*width/clm;
//    hw = max(1, w/2);
//    xmg = aln_rht_ ? xmg_ - clm*w : xmg_;
//    ymg = ymg_;
//    sw = clm > row ? max(1, 128/clm) : max(1, 128/row);
//    hsw = sw/4;
//    cll = new Cell[clm][row];
//    for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) cll[i][j] = new Cell(i, j, xmg, ymg, w, hw);
//    gen_crt = cll[floor(random(clm))][floor(random(row))];
//    ArrayList<Cell> stk = new ArrayList<Cell>();
//    stk.add(gen_crt);
//    while (!stk.isEmpty()) {
//      gen_crt.vst = true;
//      ArrayList<Cell> nbr = new ArrayList<Cell>();
//      if (gen_crt.j != 0 && !cll[gen_crt.i][gen_crt.j - 1].vst) nbr.add(cll[gen_crt.i][gen_crt.j - 1]);
//      if (gen_crt.i != clm - 1 && !cll[gen_crt.i + 1][gen_crt.j].vst) nbr.add(cll[gen_crt.i + 1][gen_crt.j]);
//      if (gen_crt.j != row - 1 && !cll[gen_crt.i][gen_crt.j + 1].vst) nbr.add(cll[gen_crt.i][gen_crt.j + 1]);
//      if (gen_crt.i != 0 && !cll[gen_crt.i - 1][gen_crt.j].vst) nbr.add(cll[gen_crt.i - 1][gen_crt.j]);
//      if (!nbr.isEmpty()) {
//        stk.add(gen_crt);
//        Cell nxt = nbr.get(floor(random(nbr.size())));
//        if (gen_crt.j - nxt.j == 1) {
//          gen_crt.wll[0] = nxt.wll[2] = false;
//        } else if (gen_crt.j - nxt.j == -1) {
//          gen_crt.wll[2] = nxt.wll[0] = false;
//        }
//        if (gen_crt.i - nxt.i == 1) {
//          gen_crt.wll[3] = nxt.wll[1] = false;
//        } else if (gen_crt.i - nxt.i == -1) {
//          gen_crt.wll[1] = nxt.wll[3] = false;
//        }
//        gen_crt = nxt;
//      } else {
//        gen_crt = stk.remove(stk.size() - 1);
//      }
//    }
//    int crt_i = floor(random(2)) == 0 ? 0 : clm - 1, crt_j = floor(random(2)) == 0 ? 0 : row - 1, end_i = crt_i == 0 ? clm - 1 : 0, end_j = crt_j == 0 ? row - 1 : 0;
//    crt = cll[crt_i][crt_j];
//    end = cll[end_i][end_j];
//    int end_wll = floor(random(2));
//    if (end == cll[0][0]) if (end_wll == 0) end.wll[0] = false;
//    else end.wll[3] = false;
//    else if (end == cll[clm - 1][0]) if (end_wll == 0) end.wll[0] = false;
//    else end.wll[1] = false;
//    else if (end == cll[clm - 1][row - 1]) if (end_wll == 0) end.wll[1] = false;
//    else end.wll[2] = false;
//    else if (end == cll[0][row - 1]) if (end_wll == 0) end.wll[2] = false;
//    else end.wll[3] = false;
//  }
//}

//class Cell {
//  int i, j;
//  float xmg, ymg, w, hw, x1, y1, x2, y2, x3, y3;
//  boolean vst = false;
//  boolean[] wll = {true, true, true, true};
//  Cell(int i_, int j_, float xmg_, float ymg_, float w_, float hw_) {
//    i = i_;
//    j = j_;
//    xmg = xmg_;
//    ymg = ymg_;
//    w = w_;
//    hw = hw_;
//    x1 = i*w + xmg;
//    y1 = j*w + ymg;
//    x2 = x1 + w;
//    y2 = y1 + w;
//    x3 = x1 + hw;
//    y3 = y1 + hw;
//  }
//}