Grid grid;

void setup() {
  size(500, 500);
  frameRate(60);
  grid = new Grid();
}

void draw() {
  grid.show();
  grid.cr.vs = true;
  Cell nxt = grid.cr.checkNeighbours();
  if (nxt != null) {
    println(nxt);
    //grid.cr = nxt;
  }
}