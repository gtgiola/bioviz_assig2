Table table;
String[][] animal;
int rowCount;
int[][] dist;
float theta;

void setup() {
  size(1000, 800);
  table = loadTable("data/zoo.csv", "header");
  rowCount = table.getRowCount();
  animal = new String[rowCount][18];
  dist = new int[rowCount][rowCount];
  int x;
  for (int i=0; i<rowCount; i++) {
    TableRow row = table.getRow(i);
    animal[i][0] = row.getString("animalname");
    animal[i][1] = row.getString("hair");
    animal[i][2] = row.getString("feathers");
    animal[i][3] = row.getString("eggs");
    animal[i][4] = row.getString("milk");
    animal[i][5] = row.getString("airborne");
    animal[i][6] = row.getString("aquatic");
    animal[i][7] = row.getString("predator");
    animal[i][8] = row.getString("toothed");
    animal[i][9] = row.getString("backbone");
    animal[i][10] = row.getString("breathes");
    animal[i][11] = row.getString("venomous");
    animal[i][12] = row.getString("fins");
    animal[i][13] = str(row.getInt("legs"));
    animal[i][14] = row.getString("tail");
    animal[i][15] = row.getString("domestic");
    animal[i][16] = row.getString("catsize");
    animal[i][17] = str(row.getInt("type"));
  }
  Distance(animal, animal);
  minDistance(0);
}

// function computs the smallest distance
void minDistance(int a) {
  int minDist=50;
  for (int b=0; b<rowCount; b++) {
    if (dist[a][b] <= minDist && a != b) {
      minDist = dist[a][b];
      println(b);
      minDist = 2;
    }
  }
}

// function computes the distance between two animals 
void Distance(String[][] a, String[][] b) {
  for (int c=0; c<rowCount; c++) {
    for (int d=0; d<rowCount; d++) {
      int counter=0;
      for (int x=1; x<17; x++) {
        if (a[c][x].equals(b[d][x]) == false) {
          counter++;
        }
      }
      dist[c][d] = counter;
    }
  }
}

void draw() {
  background(0);
  frameRate(30);
  stroke(255);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  //float a = (mouseX / (float) width) * 90f;
  float a = 30;
  // Convert it to radians
  theta = radians(a);
  // Start the tree from the bottom of the screen
  translate(width/2,height);
  // Draw a line 120 pixels
  //line(0,0,0,-120);
  // Move to the end of that line
  //translate(0,-120);
  // Start the recursive branching!
  branch(20);//distance of branch

}

void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= .66;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    //branch(h);
    popMatrix();
  }
}

