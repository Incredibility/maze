Maze[] py = new Maze[2];
boolean win = false;
color bgc = color(250);
color stc = color(130);

void setup() {
  size(1280, 720);
  frameRate(60);
  focused = true;
  int[][] dms = {{16, 16}, {16, 16}};
  for (int i = 0; i < dms.length; i++) for (int j = 0; j < dms[i].length; j++) dms[i][j] = constrain(dms[i][j], 2, int(0.35*min(width, height)));
  float ymg = 0.15*height;
  float[][] mg = {{0.45*width, ymg}, {0.55*width, ymg}};
  py[0] = new Maze(dms[0], mg[0], true);
  py[1] = new Maze(dms[1], mg[1], false);
  background(bgc);
  stroke(stc);
  for (Maze ply : py) {
    strokeWeight(ply.sw);
    for (Cell[] cll0 : ply.cll) for (Cell cll : cll0) {
      if (cll.wll[0]) line(cll.x1, cll.y1, cll.x2, cll.y1);
      if (cll.wll[1]) line(cll.x2, cll.y1, cll.x2, cll.y2);
      if (cll.wll[2]) line(cll.x2, cll.y2, cll.x1, cll.y2);
      if (cll.wll[3]) line(cll.x1, cll.y2, cll.x1, cll.y1);
    }
  }
  fill(0, 255, 0);
  strokeWeight(py[0].ssw);
  ellipse(py[0].crt.x3, py[0].crt.y3, py[0].hw, py[0].hw);
  strokeWeight(py[1].ssw);
  ellipse(py[1].crt.x3, py[1].crt.y3, py[1].hw, py[1].hw);
}

void draw() {
  //println(frameRate);
}

void keyPressed() {
  if (!win) {
    noStroke();
    fill(bgc);
    rectMode(CENTER);
    if (key == 'w' && !py[0].crt.wll[0] && !py[0].cll[py[0].crt.i][py[0].crt.j - 1].wll[2] || key == 'W' && !py[0].crt.wll[0] && !py[0].cll[py[0].crt.i][py[0].crt.j - 1].wll[2]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i][py[0].crt.j - 1];
    } else if (key == 'd' && !py[0].crt.wll[1] && !py[0].cll[py[0].crt.i + 1][py[0].crt.j].wll[3] || key == 'D' && !py[0].crt.wll[1] && !py[0].cll[py[0].crt.i + 1][py[0].crt.j].wll[3]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i + 1][py[0].crt.j];
    } else if (key == 's' && !py[0].crt.wll[2] && !py[0].cll[py[0].crt.i][py[0].crt.j + 1].wll[0] || key == 'S' && !py[0].crt.wll[2] && !py[0].cll[py[0].crt.i][py[0].crt.j + 1].wll[0]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i][py[0].crt.j + 1];
    } else if (key == 'a' && !py[0].crt.wll[3] && !py[0].cll[py[0].crt.i - 1][py[0].crt.j].wll[1] || key == 'A' && !py[0].crt.wll[3] && !py[0].cll[py[0].crt.i - 1][py[0].crt.j].wll[1]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i - 1][py[0].crt.j];
    }
    if (keyCode == UP && !py[1].crt.wll[0] && !py[1].cll[py[1].crt.i][py[1].crt.j - 1].wll[2]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i][py[1].crt.j - 1];
    } else if (keyCode == RIGHT && !py[1].crt.wll[1] && !py[1].cll[py[1].crt.i + 1][py[1].crt.j].wll[3]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i + 1][py[1].crt.j];
    } else if (keyCode == DOWN && !py[1].crt.wll[2] && !py[1].cll[py[1].crt.i][py[1].crt.j + 1].wll[0]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i][py[1].crt.j + 1];
    } else if (keyCode == LEFT && !py[1].crt.wll[3] && !py[1].cll[py[1].crt.i - 1][py[1].crt.j].wll[1]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i - 1][py[1].crt.j];
    }
    stroke(stc);
    fill(0, 255, 0);
    strokeWeight(py[0].ssw);
    ellipse(py[0].crt.x3, py[0].crt.y3, py[0].hw, py[0].hw);
    strokeWeight(py[1].ssw);
    ellipse(py[1].crt.x3, py[1].crt.y3, py[1].hw, py[1].hw);
    for (Maze ply : py) {
      if (ply.crt == ply.end) {
        win = true;
        rectMode(CORNERS);
        stroke(80);
        strokeWeight(ply.sw);
        fill(0, 100);
        Maze oth = ply == py[0] ? py[1] : py[0];
        rect(oth.cll[0][0].x1, oth.cll[0][0].y1, oth.cll[oth.dim[0] - 1][oth.dim[1] - 1].x2, oth.cll[oth.dim[0] - 1][oth.dim[1] - 1].y2, oth.ssw);
      }
    }
  }
}

class Maze {
  int[] dim;
  float w, hw, ttw, xmg, ymg, sw, ssw;
  Cell[][] cll;
  Cell crt, end;
  Maze(int[] dim_, float[] mg_, boolean aln_rht_) {
    dim = dim_;
    w = height < width ? 0.7*height/dim[1] : 0.4*width/dim[0];
    hw = max(1, w/2);
    ttw = max(1, 2*w/3);
    xmg = aln_rht_ ? mg_[0] - dim[0]*w : mg_[0];
    ymg = mg_[1];
    sw = max(1, 128/max(dim[0], dim[1]));
    ssw = sw/4;
    cll = new Cell[dim[0]][dim[1]];
    for (int i = 0; i < dim[0]; i++) for (int j = 0; j < dim[1]; j++) cll[i][j] = new Cell(i, j, xmg, ymg, w, hw);
    Cell gen_crt = cll[floor(random(dim[0]))][floor(random(dim[1]))];
    ArrayList<Cell> stk = new ArrayList<Cell>();
    stk.add(gen_crt);
    while (!stk.isEmpty()) {
      gen_crt.vst = true;
      ArrayList<Cell> nbr = new ArrayList<Cell>();
      if (gen_crt.j != 0 && !cll[gen_crt.i][gen_crt.j - 1].vst) nbr.add(cll[gen_crt.i][gen_crt.j - 1]);
      if (gen_crt.i != dim[0] - 1 && !cll[gen_crt.i + 1][gen_crt.j].vst) nbr.add(cll[gen_crt.i + 1][gen_crt.j]);
      if (gen_crt.j != dim[1] - 1 && !cll[gen_crt.i][gen_crt.j + 1].vst) nbr.add(cll[gen_crt.i][gen_crt.j + 1]);
      if (gen_crt.i != 0 && !cll[gen_crt.i - 1][gen_crt.j].vst) nbr.add(cll[gen_crt.i - 1][gen_crt.j]);
      if (!nbr.isEmpty()) {
        stk.add(gen_crt);
        Cell nxt = nbr.get(floor(random(nbr.size())));
        if (gen_crt.j - nxt.j == 1) {
          gen_crt.wll[0] = nxt.wll[2] = false;
        } else if (gen_crt.j - nxt.j == -1) {
          gen_crt.wll[2] = nxt.wll[0] = false;
        }
        if (gen_crt.i - nxt.i == 1) {
          gen_crt.wll[3] = nxt.wll[1] = false;
        } else if (gen_crt.i - nxt.i == -1) {
          gen_crt.wll[1] = nxt.wll[3] = false;
        }
        gen_crt = nxt;
      } else {
        gen_crt = stk.remove(stk.size() - 1);
      }
    }
    int crt_i = floor(random(2)) == 0 ? 0 : dim[0] - 1, crt_j = floor(random(2)) == 0 ? 0 : dim[1] - 1, end_i = crt_i == 0 ? dim[0] - 1 : 0, end_j = crt_j == 0 ? dim[1] - 1 : 0;
    crt = cll[crt_i][crt_j];
    end = cll[end_i][end_j];
    int end_wll = floor(random(2));
    if (end == cll[0][0]) if (end_wll == 0) end.wll[0] = false;
    else end.wll[3] = false;
    else if (end == cll[dim[0] - 1][0]) if (end_wll == 0) end.wll[0] = false;
    else end.wll[1] = false;
    else if (end == cll[dim[0] - 1][dim[1] - 1]) if (end_wll == 0) end.wll[1] = false;
    else end.wll[2] = false;
    else if (end == cll[0][dim[1] - 1]) if (end_wll == 0) end.wll[2] = false;
    else end.wll[3] = false;
  }
}

class Cell {
  int i, j;
  float xmg, ymg, w, hw, x1, y1, x2, y2, x3, y3;
  boolean vst = false;
  boolean[] wll = {true, true, true, true};
  Cell(int i_, int j_, float xmg_, float ymg_, float w_, float hw_) {
    i = i_;
    j = j_;
    xmg = xmg_;
    ymg = ymg_;
    w = w_;
    hw = hw_;
    x1 = i*w + xmg;
    y1 = j*w + ymg;
    x2 = x1 + w;
    y2 = y1 + w;
    x3 = x1 + hw;
    y3 = y1 + hw;
  }
}