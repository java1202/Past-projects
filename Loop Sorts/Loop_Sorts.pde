int arr[];
int ARRSIZE = 400;

void setup() {
  size(400, 400);
  background(0);
  arr = randomArray(ARRSIZE);
}//setup

void draw() {
  background(0);
  displayArray(arr);
}

void bubleSort(int[] ray) {
  for (int endPos = arr.length-1; endPos >= 0; endPos--) {
    for (int pos=0; pos < endPos; pos++) {
      if (arr[pos] > arr[endPos]) {
        swap(arr, pos, endPos);
      }
    }
  }
}//bubleSort

void selectionSort(int[] ray) {
  for (int test = 0; test < arr.length - 1; test++) {
      int selectPos = test;
      for (int pos = test + 1; pos < arr.length; pos++) {
        if (arr[pos] < arr[selectPos]) {
          selectPos = pos;
        }
      }
      int i = arr[test];
      arr[test] = arr[selectPos];
      arr[selectPos] = i;
  }
}//selectionSort

void insertionSort(int[] ray) {
   for (int pos = 1; pos < arr.length; pos++) {
      int insertion = arr[pos];
      int endSort = pos - 1;
      while (endSort >= 0 && insertion < arr[endSort]) {
        arr[endSort + 1] = arr[endSort];
        endSort--;
      }
      arr[endSort + 1] = insertion;
   }
}//insertionSort


void swap(int[] arr, int i0, int i1) {
  int t = arr[i0];
  arr[i0] = arr[i1];
  arr[i1] = t;
}//swap

int[] randomArray(int num) {
  int[] values = new int[num];

  for (int i=0; i<values.length; i++) {
    values[i] = int(random(100, 400));
  }//random value loop
  return values;
}//randomArray

void displayArray(int[] arr) {
  int barWidth = width / arr.length;
  int x = 0;
  int y = 0;
  fill(255);
  noStroke();
  for (int i=0; i<arr.length; i++) {
    y = height - arr[i];
    rect(x, y, barWidth, arr[i]);
    x+= barWidth;
  }
}//displayArray

void keyPressed() {
  if (key == 'n') {
    arr = randomArray(ARRSIZE);
  }
  else if (key == 'b') {
    bubleSort(arr);
  }
  else if (key == 's') {
    selectionSort(arr);
  }
  else if (key == 'i') {
    insertionSort(arr);
  }
}
