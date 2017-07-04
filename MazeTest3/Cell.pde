class Cell {
  int i, j;
  boolean[] wall = {true, true, true, true};
  boolean vs = false;
  Cell[] an = new Cell[4];

  Cell(int i_, int j_) {
    i = i_;
    j = j_;
  }

  void show() {
    if (vs) {
      fill(255);
      rect(i*10 + 50, j*10 + 50, 10, 10);
    }
    if (wall[0]) {
      line(i*10 + 50, j*10 + 50, i*10 + 50 + 10, j*10 + 50);
    }
    if (wall[1]) {
      line(i*10 + 50, j*10 + 50 + 10, i*10 + 50 + 10, j*10 + 50 + 10);
    }
    if (wall[2]) {
      line(i*10 + 50, j*10 + 50, i*10 + 50, j*10 + 50 + 10);
    }
    if (wall[3]) {
      line(i*10 + 50 + 10, j*10 + 50, i*10 + 50 + 10, j*10 + 50 + 10);
    }
  }

  Cell checkNeighbours() {
    int a = 0;
    if (j - 1 != -1) {
      if (!grid.cell[i][j - 1].vs) {
        an[0] = grid.cell[i][j - 1];
      }
    }
    if (j + 1 != 40) {
      if (!grid.cell[i][j + 1].vs) {
        an[1] = grid.cell[i][j + 1];
      }
    }
    if (i - 1 != -1) {
      if (!grid.cell[i - 1][j].vs) {
        an[2] = grid.cell[i - 1][j];
      }
    }
    if (i + 1 != 40) {
      if (!grid.cell[i + 1][j].vs) {
        an[3] = grid.cell[i + 1][j];
      }
    }
    for (int i = 0; i < an.length; i++) {
      if (an[i] == null) {
        an = subset(an, i);
      }
    }
    if (an[an.length - 1] == null) {
    }
    if (an.length > 0) {
      int r = floor(random(an.length));
      println(r);
      return an[r];
    } else {
      return null;
    }
  }
}