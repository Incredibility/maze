class Cell {
  int i, j;

  Cell(int i_, int j_) {
    i = i_;
    j = j_;
  }

  void show() {
    rect(i*10+50,j*10+50,10,10);
  }
}