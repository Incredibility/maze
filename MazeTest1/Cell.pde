class Cell {
  int grd_, clm, row, i, j;
  float x, y, w, sw;
  boolean[] wall = {true, true, true, true};
  boolean vs = false;
  Cell[] an;
  Grid grd;

  Cell(int grd__, int clm_, int row_, int i_, int j_, float x_mg_, float y_mg_, float w_, float sw_) {
    grd_ = grd__;
    clm = clm_;
    row = row_;
    i = i_;
    j = j_;
    w = w_;
    sw = sw_;
    x = i*w + x_mg_;
    y = j*w + y_mg_;
    an = new Cell[0];
  }

  void show() {
    noStroke();
    if (vs) {
      fill(255);
    } else {
      fill(200);
    }
    rect(x, y, w, w);
    stroke(160);
    strokeWeight(sw);
    if (wall[0]) {
      line(x, y, x + w, y);
    }
    if (wall[1]) {
      line(x, y + w, x + w, y + w);
    }
    if (wall[2]) {
      line(x, y, x, y + w);
    }
    if (wall[3]) {
      line(x + w, y, x + w, y + w);
    }
  }
  Cell checkNeighbours() {
    grd = grd_ == 0 ? p_grd : e_grd;
    if (j - 1 != -1) {
      if (!grd.cell[i][j - 1].vs) append(an, grd.cell[i][j - 1]);
    }
    if (j + 1 != row) {
      if (!grd.cell[i][j + 1].vs) append(an, grd.cell[i][j + 1]);
    }
    if (i - 1 != -1) {
      if (!grd.cell[i - 1][j].vs) append(an, grd.cell[i - 1][j]);
    }
    if (i + 1 != clm) {
      if (!grd.cell[i + 1][j].vs) append(an, grd.cell[i + 1][j]);
    }
    if (an.length > 0) {
      return an[floor(random(an.length))];
    } else {
      return null;
    }
  }
}