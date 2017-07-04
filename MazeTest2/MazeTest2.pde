int cols = 40, rows = 40;
Grid grid;

void setup() {
  size(500,500);
  frameRate(60);
  makegrid();
}

void draw() {
  showgrid();
}

void makegrid() {
  grid = new Grid(cols, rows);
}

void showgrid() {
  grid.show();
}