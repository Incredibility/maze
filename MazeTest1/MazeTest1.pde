Grid p_grd, e_grd;
int p_clm, p_row, e_clm, e_row;

void setup() {
  size(1280, 720);
  frameRate(60);
  dimensions();
  makeGrids();
}

void draw() {
  background(240);
  move();
  showGrids();
}

void dimensions() {
  int p_clm_ = 8;
  int p_row_ = 8;
  int e_clm_ = 8;
  int e_row_ = 8;
  p_clm = constrain(p_clm_, 2, 252);
  p_row = constrain(p_row_, 2, 252);
  e_clm = constrain(e_clm_, 2, 252);
  e_row = constrain(e_row_, 2, 252);
}

void makeGrids() {
  p_grd = new Grid(0, p_clm, p_row);
  e_grd = new Grid(1, e_clm, e_row);
}

void showGrids() {
  p_grd.show();
  e_grd.show();
}

void move() {
  p_grd.move();
  e_grd.move();
}