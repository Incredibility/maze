Maze[] py = new Maze[2];
int[][] dms = {{16, 16}, {16, 16}};
int wnr;

void setup() {
  size(1280, 720);
  frameRate(60);
  focused = true;
  for (int[] dim0 : dms) for (int dim1 : dim0) dim1 = constrain(dim1, 2, 252);
  float ymg = 0.15*height;
  py[0] = new Maze(dms[0], 0.45*width, ymg, true);
  py[1] = new Maze(dms[1], 0.55*width, ymg, false);
  background(250);
  stroke(130);
  strokeWeight(py[0].sw);
  for (int i = 0; i < py[0].dim[0]; i++) for (int j = 0; j < py[0].dim[1]; j++) {
    if (py[0].cll[i][j].wll[0]) line(py[0].cll[i][j].x1, py[0].cll[i][j].y1, py[0].cll[i][j].x2, py[0].cll[i][j].y1);
    if (py[0].cll[i][j].wll[1]) line(py[0].cll[i][j].x2, py[0].cll[i][j].y1, py[0].cll[i][j].x2, py[0].cll[i][j].y2);
    if (py[0].cll[i][j].wll[2]) line(py[0].cll[i][j].x2, py[0].cll[i][j].y2, py[0].cll[i][j].x1, py[0].cll[i][j].y2);
    if (py[0].cll[i][j].wll[3]) line(py[0].cll[i][j].x1, py[0].cll[i][j].y2, py[0].cll[i][j].x1, py[0].cll[i][j].y1);
  }
  strokeWeight(py[1].sw);
  for (int i = 0; i < py[1].dim[0]; i++) for (int j = 0; j < py[1].dim[1]; j++) {
    if (py[1].cll[i][j].wll[0]) line(py[1].cll[i][j].x1, py[1].cll[i][j].y1, py[1].cll[i][j].x2, py[1].cll[i][j].y1);
    if (py[1].cll[i][j].wll[1]) line(py[1].cll[i][j].x2, py[1].cll[i][j].y1, py[1].cll[i][j].x2, py[1].cll[i][j].y2);
    if (py[1].cll[i][j].wll[2]) line(py[1].cll[i][j].x2, py[1].cll[i][j].y2, py[1].cll[i][j].x1, py[1].cll[i][j].y2);
    if (py[1].cll[i][j].wll[3]) line(py[1].cll[i][j].x1, py[1].cll[i][j].y2, py[1].cll[i][j].x1, py[1].cll[i][j].y1);
  }
  fill(0, 255, 0);
  strokeWeight(py[0].ssw);
  ellipse(py[0].crt.x3, py[0].crt.y3, py[0].hw, py[0].hw);
  strokeWeight(py[1].ssw);
  ellipse(py[1].crt.x3, py[1].crt.y3, py[1].hw, py[1].hw);
  if (wnr != 0) {
    rectMode(CORNERS);
    stroke(80);
    fill(0, 100);
    if (wnr == 1) {
      strokeWeight(py[1].sw);
      rect(py[1].cll[0][0].x1, py[1].cll[0][0].y1, py[1].cll[py[1].dim[0] - 1][py[1].dim[1] - 1].x2, py[1].cll[py[1].dim[0] - 1][py[1].dim[1] - 1].y2, py[1].ssw);
    } else {
      strokeWeight(py[0].sw);
      rect(py[0].cll[0][0].x1, py[0].cll[0][0].y1, py[0].cll[py[0].dim[0] - 1][py[0].dim[1] - 1].x2, py[0].cll[py[0].dim[0] - 1][py[0].dim[1] - 1].y2, py[0].ssw);
    }
  }
}

void draw() {
  println(frameRate);
}

void keyPressed() {
  if (wnr == 0) {
    noStroke();
    fill(250);
    rectMode(CENTER);
    if (key == 'w' && !py[0].crt.wll[0] && !py[0].cll[py[0].crt.i][py[0].crt.j - 1].wll[2] || key == 'W' && !py[0].crt.wll[0] && !py[0].cll[py[0].crt.i][py[0].crt.j - 1].wll[2]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i][py[0].crt.j - 1];
    }
    else if (key == 'd' && !py[0].crt.wll[1] && !py[0].cll[py[0].crt.i + 1][py[0].crt.j].wll[3] || key == 'D' && !py[0].crt.wll[1] && !py[0].cll[py[0].crt.i + 1][py[0].crt.j].wll[3]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i + 1][py[0].crt.j];
    }
    else if (key == 's' && !py[0].crt.wll[2] && !py[0].cll[py[0].crt.i][py[0].crt.j + 1].wll[0] || key == 'S' && !py[0].crt.wll[2] && !py[0].cll[py[0].crt.i][py[0].crt.j + 1].wll[0]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i][py[0].crt.j + 1];
    }
    else if (key == 'a' && !py[0].crt.wll[3] && !py[0].cll[py[0].crt.i - 1][py[0].crt.j].wll[1] || key == 'A' && !py[0].crt.wll[3] && !py[0].cll[py[0].crt.i - 1][py[0].crt.j].wll[1]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[0].crt = py[0].cll[py[0].crt.i - 1][py[0].crt.j];
    }
    if (keyCode == UP && !py[1].crt.wll[0] && !py[1].cll[py[1].crt.i][py[1].crt.j - 1].wll[2]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i][py[1].crt.j - 1];
    }
    else if (keyCode == RIGHT && !py[1].crt.wll[1] && !py[1].cll[py[1].crt.i + 1][py[1].crt.j].wll[3]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i + 1][py[1].crt.j];
    }
    else if (keyCode == DOWN && !py[1].crt.wll[2] && !py[1].cll[py[1].crt.i][py[1].crt.j + 1].wll[0]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i][py[1].crt.j + 1];
    }
    else if (keyCode == LEFT && !py[1].crt.wll[3] && !py[1].cll[py[1].crt.i - 1][py[1].crt.j].wll[1]) {
      rect(py[0].crt.x3, py[0].crt.y3, py[0].ttw, py[0].ttw);
      py[1].crt = py[1].cll[py[1].crt.i - 1][py[1].crt.j];
    }
    if (py[0].crt == py[0].end) wnr = 1;
    else if (py[1].crt == py[1].end) wnr = 2;
    stroke(130);
    fill(0, 255, 0);
    strokeWeight(py[0].ssw);
    ellipse(py[0].crt.x3, py[0].crt.y3, py[0].hw, py[0].hw);
    strokeWeight(py[1].ssw);
    ellipse(py[1].crt.x3, py[1].crt.y3, py[1].hw, py[1].hw);
    if (wnr != 0) {
      rectMode(CORNERS);
      stroke(80);
      fill(0, 100);
      if (wnr == 1) {
        strokeWeight(py[1].sw);
        rect(py[1].cll[0][0].x1, py[1].cll[0][0].y1, py[1].cll[py[1].dim[0] - 1][py[1].dim[1] - 1].x2, py[1].cll[py[1].dim[0] - 1][py[1].dim[1] - 1].y2, py[1].ssw);
      } else {
        strokeWeight(py[0].sw);
        rect(py[0].cll[0][0].x1, py[0].cll[0][0].y1, py[0].cll[py[0].dim[0] - 1][py[0].dim[1] - 1].x2, py[0].cll[py[0].dim[0] - 1][py[0].dim[1] - 1].y2, py[0].ssw);
      }
    }
  }
}

class Maze {
  int[] dim;
  float w, hw, ttw, xmg, ymg, sw, ssw;
  Cell[][] cll;
  Cell gen_crt, crt, end;
  Maze(int[] dim_, float xmg_, float ymg_, boolean aln_rht_) {
    dim = dim_;
    w = height < width ? 0.7*height/dim[1] : 0.4*width/dim[0];
    hw = max(1, w/2);
    ttw = max(1, 2*w/3);
    xmg = aln_rht_ ? xmg_ - dim[0]*w : xmg_;
    ymg = ymg_;
    sw = max(1, 128/max(dim[0], dim[1]));
    ssw = sw/4;
    cll = new Cell[dim[0]][dim[1]];
    for (int i = 0; i < dim[0]; i++) for (int j = 0; j < dim[1]; j++) cll[i][j] = new Cell(i, j, xmg, ymg, w, hw);
    gen_crt = cll[floor(random(dim[0]))][floor(random(dim[1]))];
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