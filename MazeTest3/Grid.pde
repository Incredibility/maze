class Grid {
  Cell[][] cell = new Cell[40][40];
  Cell cr;

  Grid() {
    for (int j = 0; j < 40; j++) {
      for (int i = 0; i < 40; i++) {
        cell[i][j] = new Cell(i, j);
      }
    }
    cr = cell[0][0];
  }
  
  void show() {
    for (int j = 0; j < 40; j++) {
      for (int i = 0; i < 40; i++) {
        cell[i][j].show();
      }
    }
  }
}