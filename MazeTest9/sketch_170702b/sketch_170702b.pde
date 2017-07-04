Maze[] mz = new Maze[2];
void setup() {
  mz[0] = new Maze(2);
  mz[1] = new Maze(3);
}

void draw() {
}

class Maze {
  int w;
  Cell[] cll;
  Maze(int w_) {
    w = w_;
    cll = new Cell[2];
    make();
  }
  void make() {
    for (int i = 0; i < 3; i++) {
      cll[i] = new Cell();
    }
  }
}

class Cell {
  Cell() {
    println(mz[0].w);
  }
}