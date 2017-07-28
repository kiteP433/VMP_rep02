// Visual Media Processing report2 1516016 3EP4-33 Tomizu Tastuyoshi.
// Class for labeling processing.
public class Labeling {

  // Array of labeling.
  private int labeling[][];

  // Number of labeling.
  private int labelingSize;

  // Array for storing the area of each connected component.
  private int labelingArea[];

  // Constructor.
  Labeling() {
    // Declaration and initialization.
    labeling = new int [WIDTH+1][HEIGHT+1];
    for (int i = 0; i < HEIGHT+1; i++) {
      for (int j = 0; j < WIDTH+1; j++) {
        labeling[j][i] = 0;
      }
    }
    setLabelingSize(0);
  }

  // Method for setting labeling array.
  void setLabeling(int labelingTmp[][]) {
    this.labeling = labelingTmp;
  }

  // Method for getting labeling array.
  int[][] getLabeling() {
    return this.labeling;
  }

  // Method for setting the number of labeling.
  void setLabelingSize(int labelingSizeTmp) {
    this.labelingSize = labelingSizeTmp;
  }

  // Method for getting the number of labeling
  int getLabelingSize() {
    return this.labelingSize;
  }

  // Method to determine if its color is black.
  boolean checkBlack(color colorTmp) {
    color blackColor = color(0);
    if (colorTmp == blackColor) {
      return true;
    } else {
      return false;
    }
  }

  // Method to determine for lookup table.
  boolean checkNearNumber(int number0, int number1) {
    if (number1 != number0 && number1 != 0) {
      return true;
    } else {
      return false;
    }
  }

  // Method for obtaining the minimum value of the surrounding labeling number.
  int getMinLabelNumber(int number0, int number1, int number2, int number3, int number4) {
    int tmp[] = new int[5];
    int min = 0;

    tmp[0] = number0;// Labeling number of the current coordinate.
    tmp[1] = number1;// From the current coordinates, labeling number on the upper left.
    tmp[2] = number2;// From the current coordinates, labeling number on the upper.
    tmp[3] = number3;// From the current coordinates, labeling number on the upper right.
    tmp[4] = number4;// From the current coordinates, labeling number on the left.

    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i] != 0) {
        min = tmp[i];
        break;
      }
    }

    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i] != 0 && min > tmp[i]) {
        min = tmp[i];
      }
    }
    return min;
  }

  // Method of labeling processing.
  void labelingProcess(PImage pic) {
    int labelingTmp[][] = new int [WIDTH+1][HEIGHT+1];
    int pos;
    int labelingNumber;
    int number0, number1, number2, number3, number4;
    pic.loadPixels();

    // initialization.
    for (int i = 0; i < pic.height; i++) {
      for (int j = 0; j < pic.width; j++) {
        labelingTmp[j][i] = 0;
      }
    }
    labelingNumber = pos = number0 = number1 = number2 = number3 = number4 = 0;

    // Extraction of connected components.
    color color0, color1, color2, color3, color4;
    boolean zeroFlag = true;

    for (int y = 0; y < pic.height; y++) {
      for (int x = 0; x < pic.width; x++) {

        // The current coordinate in the primary array.
        pos = x + y*pic.width;
        color0 = pic.pixels[pos];

        // If the color of the element at that coordinate is black or not, if it is black,
        if (!checkBlack(color0)) {
          zeroFlag = true;

          // Confirmation of elements around the current coordinate. If it is black, the flag will remain true,
          // Upper left: "pos" do not exist at the top row and the left end.
          if (y != 0 && x != 0) {
            color1 = pic.pixels[(x-1) + (y-1)*pic.width];
            number1 = labelingTmp[x-1][y-1];
            if (zeroFlag) {
              zeroFlag = checkBlack(color1);
            }
          }
          // Above: "pos" does not exist in the top row.
          if (y != 0) {
            color2 = pic.pixels[x + (y-1)*pic.width];
            number2 = labelingTmp[x][y-1];
            if (zeroFlag) {
              zeroFlag = checkBlack(color2);
            }
          }
          // Upper right: "pos" do not exist at the top row and the right end.
          if (y != 0 && x != pic.width - 1) {
            color3 = pic.pixels[(x + 1) + (y - 1)*pic.width];
            number3 = labelingTmp[x + 1][y - 1];
            if (zeroFlag) {
              zeroFlag = checkBlack(color3);
            }
          }
          // Left: "pos" do not exist at the left end.
          if (x != 0) {
            color4 = pic.pixels[(x-1) + y*pic.width];
            number4 = labelingTmp[x-1][y];
            if (zeroFlag) {
              zeroFlag = checkBlack(color4);
            }
          }
          if (zeroFlag) {
            labelingNumber++;
          } else {
            labelingNumber = getMinLabelNumber(number0, number1, number2, number3, number4);
          }
          labelingTmp[x][y] = labelingNumber;
        } else {
          // Through.
        }
      }
    }
    labelingTmp = lookUpTableUpdate(pic, labelingTmp);
    setLabeling(labelingTmp);
  }

  // Method for lookup table update processing.
  int[][] lookUpTableUpdate(PImage pic, int labelingTmp[][]) {
    int updateLabeling[][] = new int [640][480];
    int pos;
    int min;
    int number0, number1, number2, number3, number4;
    boolean labelingNumberFlag;
    pic.loadPixels();

    // initialization..
    pos = min = number0 = number1 = number2 = number3 = number4 = 0;
    for (int i = 0; i < pic.height; i++) {
      for (int j = 0; j < pic.width; j++) {
        updateLabeling[j][i] = 0;
      }
    }

    for (int y = 0; y < pic.height; y++) {
      for (int x = 0; x < pic.width; x++) {
        number0 = labelingTmp[x][y];
        labelingNumberFlag = false;
        if (number0 != 0) {
          // Upper left.
          if (y != 0 && x != 0) {
            number1 = labelingTmp[x-1][y-1];
            labelingNumberFlag = checkNearNumber(number0, number1);
          }
          // Upper.
          if (y != 0) {
            number2 = labelingTmp[x][y-1];
            labelingNumberFlag = checkNearNumber(number0, number2);
          }
          // Upper right.
          if (y != 0 && x != pic.width - 1) {
            number3 = labelingTmp[x+1][y-1];          
            labelingNumberFlag = checkNearNumber(number0, number3);
          }
          // Left.
          if (x != 0) {
            number4 = labelingTmp[x-1][y];          
            labelingNumberFlag = checkNearNumber(number0, number4);
          }
          if (labelingNumberFlag) {
            min = getMinLabelNumber(number0, number1, number2, number3, number4);
            if (number0 != min) {
              for (int i = 0; i < pic.height; i++) {
                for (int j = 0; j < pic.width; j++) {
                  if (updateLabeling[j][i] == number0) {
                    updateLabeling[j][i] = min;
                  }
                }
              }
            }
          } else {
            updateLabeling[x][y] = number0;
          }
        } else {
          // Through.
        }
      }
    }
    return updateLabeling;
  }

  // Method for getting the number of labeling numbers.
  void getLabelingCount(PImage pic, int labelingTmp[][]) {
    int labelingNumber = 0;

    for (int y = 0; y < pic.height; y++) {
      for (int x = 0; x < pic.width; x++) {
        if (labelingTmp[x][y] > labelingNumber) {
          labelingNumber = labelingTmp[x][y];
        }
      }
    }
    setLabelingSize(labelingNumber);
  }

  // Method for rendering connected component and area.
  void drawLabelingArea(PImage pic, int labelingTmp[][], String name) {
    int labelingNumber;
    int labelingArea[];
    int pointX[];
    int pointY[];
    int sum;
    pic.loadPixels();

    labelingNumber = getLabelingSize();
    labelingArea = new int [labelingNumber+1];
    pointX = new int [labelingNumber+1];
    pointY = new int [labelingNumber+1];

    // Calculate the area of each connected component.
    for (int i = 0; i < labelingNumber; i++) {
      sum = 0;
      for (int y = 0; y < pic.height; y++) {
        for (int x = 0; x < pic.width; x++) {
          if (labelingTmp[x][y] == i) {
            sum++;
          }
        }
      }
      labelingArea[i] = sum;
    }

    // Process of acquiring coordinates for drawing area
    int count;

    for (int i = 0; i < labelingNumber; i++) {
      count = 0;
      for (int y = 0; y < pic.height; y++) {
        for (int x = 0; x < pic.width; x++) {
          if (count == labelingArea[i]*3/5) {
            pointX[i] = x;
            pointY[i] = y;
          }
          if (labelingTmp[x][y] == i) {
            count++;
          }
        }
      }
    }

    // Draw the area of connected component.
    image(pic, 0, 0, WIDTH, HEIGHT);
    for (int i = 0; i < labelingNumber; i++) {
      fill(255, 0, 0);
      textSize(22);
      text(labelingArea[i], pointX[i], pointY[i]);
    }
    save("data/pic" + name +".jpg");
  }

  // Method for creating an array of random colors.
  color[] setRandomColor(int labelingNumberTmp) {
    color labelingColor[] = new color[labelingNumberTmp+1];
    float r, g, b;
    randomSeed(labelingNumberTmp*18);

    for (int i = 0; i < labelingNumberTmp; i++) {
      r = (float)random(0, 255);
      g = (float)random(0, 255);
      b = (float)random(0, 255);
      labelingColor[i] = color(r, g, b);
      for (int j = 0; j < labelingNumberTmp; j++) {
        if (j != i) {
          if (labelingColor[i] == labelingColor[j]) {
            i--;
          }
        }
      }
    }
    return labelingColor;
  }

  // Method to store image by color-coded for each connected component.
  void labelingColor(PImage pic, int labelingTmp[][], int labelingNumberTmp, String name) {
    PImage picTmp = createImage(640, 480, RGB);
    int pos;
    color labelingColor[] = new color[labelingNumberTmp+1];
    labelingColor = setRandomColor(labelingNumberTmp);
    pic.loadPixels();

    for (int y = 0; y < pic.height; y++) {
      for (int x = 0; x < pic.width; x++) {
        for (int i = 0; i < labelingNumberTmp; i++) {
          if (labelingTmp[x][y]==i) {
            pos = x + y*pic.width;
            picTmp.pixels[pos] = labelingColor[i];
          }
        }
      }
    }
    picTmp.updatePixels(0, 0, WIDTH, HEIGHT);
    picTmp.save("data/pic" + name +".jpg");
  }
}

