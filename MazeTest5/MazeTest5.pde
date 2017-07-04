Grid p_grd, e_grd;
int p_clm, p_row, e_clm, e_row;
boolean slow = false;

void setup() {
  size(1280, 720);
  if (slow) frameRate(10); else frameRate(300);
  dimensions();
  makeGrids();
  makeMaze();
}

void draw() {
  println(frameRate);
  background(240);
  p_grd.show();
  e_grd.show();
  p_grd.move();
  e_grd.move();
}

void dimensions() {
  int p_clm_ = 50;
  int p_row_ = 50;
  int e_clm_ = 16;
  int e_row_ = 16;
  p_clm = constrain(p_clm_, 0, 252);
  p_row = constrain(p_row_, 0, 252);
  e_clm = constrain(e_clm_, 0, 252);
  e_row = constrain(e_row_, 0, 252);
}

void makeGrids() {
  p_grd = new Grid(0, p_clm, p_row);
  e_grd = new Grid(1, e_clm, e_row);
}

void makeMaze() {
}

class Grid {
  Cell current;
  int grd, clm, row;
  float w, x_mg, y_mg, sw;
  Cell[][] cell;
  ArrayList<Cell> stack = new ArrayList<Cell>();
  Grid(int grd_, int clm_, int row_) {
    grd = grd_;
    clm = clm_;
    row = row_;
    w = clm > row ? 0.4*width/clm : 0.7*height/row;
    x_mg = grd == 0 ? 0.55*width : 0.45*width - e_clm*w;
    y_mg = 0.15*height;
    sw = clm > row ? max(1, 128/clm) : max(1, 128/row);
    cell = new Cell[clm][row];
    for (int i = 0; i < clm; i++) {
      for (int j = 0; j < row; j++) {
        cell[i][j] = new Cell(grd, i, j, x_mg, y_mg, w, sw);
      }
    }
    current = cell[0][0];
  }
  void move() {
    current.visited = true;
    Cell next = current.checkNeighbours();
    if (next != null) {
      stack.add(current);
      if (current.j - next.j == 1) {
        current.wall[0] = false;
        next.wall[2] = false;
      } else if (current.j - next.j == -1) {
        current.wall[2] = false;
        next.wall[0] = false;
      }
      if (current.i - next.i == 1) {
        current.wall[3] = false;
        next.wall[1] = false;
      } else if (current.i - next.i == -1) {
        current.wall[1] = false;
        next.wall[3] = false;
      }
      current = next;
    } else if (stack.size() > 0) {
      current = stack.get(stack.size() - 1);
      stack.remove(stack.size() - 1);
    }
  }
  void show() {
    for (int i = 0; i < clm; i++) {
      for (int j = 0; j < row; j++) {
        cell[i][j].colour();
      }
    }
    current.highlight();
    for (int i = 0; i < clm; i++) {
      for (int j = 0; j < row; j++) {
        cell[i][j].show();
      }
    }
  }
}

class Cell {
  int grd, i, j;
  float x_mg, y_mg, w, sw, x1, y1, x2, y2;
  boolean visited = false;
  boolean[] wall = {true, true, true, true};
  Cell(int grd_, int i_, int j_, float x_mg_, float y_mg_, float w_, float sw_) {
    grd = grd_;
    i = i_;
    j = j_;
    x_mg = x_mg_;
    y_mg = y_mg_;
    w = w_;
    sw = sw_;
    x1 = i*w + x_mg;
    y1 = j*w + y_mg;
    x2 = x1 + w;
    y2 = y1 + w;
  }
  void colour() {
    if (visited) {
      fill(255);
    } else {
      fill(100);
    }
    noStroke();
    rect(x1, y1, w, w);
  }
  void show() {
    stroke(160);
    strokeWeight(sw);
    if (wall[0]) {
      line(x1, y1, x2, y1);
    }
    if (wall[1]) {
      line(x2, y1, x2, y2);
    }
    if (wall[2]) {
      line(x2, y2, x1, y2);
    }
    if (wall[3]) {
      line(x1, y2, x1, y1);
    }
  }
  Cell checkNeighbours() {
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    Grid grid = grd == 0 ? p_grd : e_grd;
    if (j - 1 != -1 && !grid.cell[i][j - 1].visited) {
      neighbours.add(grid.cell[i][j - 1]);
    }
    if (j + 1 != grid.row && !grid.cell[i][j + 1].visited) {
      neighbours.add(grid.cell[i][j + 1]);
    }
    if (i - 1 != -1 && !grid.cell[i - 1][j].visited) {
      neighbours.add(grid.cell[i - 1][j]);
    }
    if (i + 1 != grid.clm && !grid.cell[i + 1][j].visited) {
      neighbours.add(grid.cell[i + 1][j]);
    }
    if (neighbours.size() > 0) {
      int r = floor(random(neighbours.size()));
      return neighbours.get(r);
    } else {
      return null;
    }
  }
  void highlight() {
    noStroke();
    fill(0, 255, 0);
    rect(x1, y1, w, w);
  }
}