int cols, rows;
int w = 40;
Cell[][] grid;
Cell current;
ArrayList<Cell> stack = new ArrayList<Cell>();
boolean slow = false;

void setup() {
  size(400, 400);
  if (slow) frameRate(5); else frameRate(600);
  cols = floor(width/w);
  rows = floor(height/w);
  grid = new Cell[cols][rows];
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[i][j] = new Cell(i, j);
    }
  }
  current = grid[0][0];
}

void draw() {
  println(frameRate);
  background(230);
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      grid[i][j].show();
    }
  }
  current.visited = true;
  current.highlight();
  Cell next = current.checkNeighbours();
  if (next != null) {
    stack.add(current);
    if (current.i - next.i == -1) {
      current.wall[1] = false;
      next.wall[3] = false;
    } else if (current.i - next.i == 1) {
      current.wall[3] = false;
      next.wall[1] = false;
    }
    if (current.j - next.j == -1) {
      current.wall[2] = false;
      next.wall[0] = false;
    } else if (current.j - next.j == 1) {
      current.wall[0] = false;
      next.wall[2] = false;
    }
    current = next;
  } else if (stack.size() > 0) {
    current = stack.get(stack.size() - 1);
    stack.remove(stack.size() - 1);
  }
}

class Cell {
  int i, j;
  boolean[] wall = {true, true, true, true};
  boolean visited = false;
  Cell(int i_, int j_) {
    i = i_;
    j = j_;
  }
  Cell checkNeighbours() {
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    if (j - 1 != -1 && !grid[i][j - 1].visited) neighbours.add(grid[i][j - 1]);
    if (i + 1 != cols && !grid[i + 1][j].visited) neighbours.add(grid[i + 1][j]);
    if (j + 1 != rows && !grid[i][j + 1].visited) neighbours.add(grid[i][j + 1]);
    if (i - 1 != -1 && !grid[i - 1][j].visited) neighbours.add(grid[i - 1][j]);
    if (neighbours.size() > 0) {
      int r = floor(random(neighbours.size()));
      return neighbours.get(r);
    } else {
      return null;
    }
  }
  void show() {
    int x = i*w;
    int y = j*w;
    if (visited) {
      noStroke();
      fill(255);
      rect(x, y, w, w);
    }
    stroke(160);
    if (wall[0]) line(x, y, x + w, y);
    if (wall[1]) line(x + w, y, x + w, y + w);
    if (wall[2]) line(x + w, y + w, x, y + w);
    if (wall[3]) line(x, y + w, x, y);
  }
  void highlight() {
    int x = i*w;
    int y = j*w;
    noStroke();
    fill(0, 255, 0);
    rect(x, y, w, w);
  }
}