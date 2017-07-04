int clm = 200, row = 200;
float w;
Cell current;
Cell[][] cell;
ArrayList<Cell> stack = new ArrayList<Cell>();
void setup() {
  size(800, 800);
  frameRate(60);
  w = min(width, height) == height ? height/row : width/clm;
  cell = new Cell[clm][row];
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) cell[i][j] = new Cell(i, j);
  current = cell[0][0];
  while (unvisited()) {
    current.visited = true;
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    if (current.j - 1 != -1 && !cell[current.i][current.j - 1].visited) neighbours.add(cell[current.i][current.j - 1]);
    if (current.j + 1 != row && !cell[current.i][current.j + 1].visited) neighbours.add(cell[current.i][current.j + 1]);
    if (current.i - 1 != -1 && !cell[current.i - 1][current.j].visited) neighbours.add(cell[current.i - 1][current.j]);
    if (current.i + 1 != clm && !cell[current.i + 1][current.j].visited) neighbours.add(cell[current.i + 1][current.j]);
    if (neighbours.size() != 0) {
      Cell next = neighbours.get(floor(random(neighbours.size())));
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
    } else if (stack.size() != 0) {
      current = stack.get(stack.size() - 1);
      stack.remove(stack.size() - 1);
    }
  }
}

void draw() {
  println(frameRate);
  background(255);
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) cell[i][j].show();
}

boolean unvisited() {
  for (int i = 0; i < clm; i++) for (int j = 0; j < row; j++) if (!cell[i][j].visited) return true;
  return false;
}

class Cell {
  int i, j;
  float x1, y1, x2, y2;
  boolean visited = false;
  boolean[] wall = {true, true, true, true};
  Cell(int i_, int j_) {
    i = i_;
    j = j_;
    x1 = i*w;
    y1 = j*w;
    x2 = x1 + w;
    y2 = y1 + w;
  }
  void show() {
    if (wall[0]) line(x1, y1, x2, y1);
    if (wall[1]) line(x2, y1, x2, y2);
    if (wall[2]) line(x2, y2, x1, y2);
    if (wall[3]) line(x1, y2, x1, y1);
  }
}