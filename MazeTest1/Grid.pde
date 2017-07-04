class Grid {
  Cell[][] cell;
  Cell cr;
  int clm, row;

  Grid(int grd_, int clm_, int row_) {
    clm = clm_;
    row = row_;
    float w_ = clm > row ? 0.4*width/clm : 0.7*height/row;
    float x_mg_ = grd_ == 0 ? 0.55*width : 0.45*width - e_clm*w_;
    float y_mg_ = 0.15*height;
    float sw_ = clm > row ? max(1, 128/clm) : max(1, 128/row);
    cell = new Cell[clm][row];
    for (int j = 0; j < row; j++) {
      for (int i = 0; i < clm; i++) {
        cell[i][j] = new Cell(grd_, clm, row, i, j, x_mg_, y_mg_, w_, sw_);
      }
    }
    cr = cell[0][0];
  }

  void show() {
    for (int j = 0; j < row; j++) {
      for (int i = 0; i < clm; i++) {
        cell[i][j].show();
      }
    }
  }
  
  void move() {
    cr.vs = true;
    Cell nxt = cr.checkNeighbours();
    if (nxt != null) {
      cr = nxt;
      nxt.vs = true;
    }
  }
}