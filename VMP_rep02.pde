// Visual Media Processing report2 1516016 3EP4-33 Tomizu Tastuyoshi.
// Main program.
final int WIDTH  = 640;
final int HEIGHT = 480;

PImage pic0, pic1, pic0Bin, pic1Bin, pic0BinColor, pic1BinColor;

// Class for saving images.
DrawAndSave drawAndSave;

// Class for saving labeling process.
Labeling labeling0, labeling1;

// Array for labeling binary image.
int pic0Label[][];
int pic1Label[][];

// Number of labeling of binarized image.
int pic0LabelNumber;
int pic1LabelNumber;

void setup() {
  size(WIDTH, HEIGHT);
  background(0);

  // Initial setting.
  drawAndSave = new DrawAndSave();
  labeling0 = new Labeling();
  labeling1 = new Labeling(); 
  pic0Label = new int [WIDTH+1][HEIGHT+1];
  pic1Label = new int [WIDTH+1][HEIGHT+1];
  
  // Original image loading.
  pic0 = loadImage("data/pic0.jpg");
  pic1 = loadImage("data/pic1.jpg");
  
  // Binarization processing.
  drawAndSave.drawSaveBinarization(pic0, "0Bin");
  drawAndSave.drawSaveBinarization(pic1, "1Bin");

  // Binary image loading.
  pic0Bin = loadImage("data/pic0Bin.jpg");
  pic1Bin = loadImage("data/pic1Bin.jpg");

  // Get array of labeling information.
  labeling0.labelingProcess(pic0Bin);
  labeling1.labelingProcess(pic1Bin);
  pic0Label = labeling0.getLabeling();
  pic1Label = labeling1.getLabeling();

  // Acquisition of the number of labeling number.
  labeling0.getLabelingCount(pic0Bin, pic0Label);
  labeling1.getLabelingCount(pic1Bin, pic1Label);
  pic0LabelNumber = labeling0.getLabelingSize();
  pic1LabelNumber = labeling1.getLabelingSize();

  // Color coding processing.
  labeling0.labelingColor(pic0Bin, pic0Label, pic0LabelNumber, "0BinColor");
  labeling1.labelingColor(pic1Bin, pic1Label, pic1LabelNumber, "1BinColor");

  // Color coding image loading.
  pic0BinColor = loadImage("data/pic0BinColor.jpg");
  pic1BinColor = loadImage("data/pic1BinColor.jpg");

  // Area drawing (binarization).
  labeling0.drawLabelingArea(pic0Bin, pic0Label, "0BinArea");
  labeling1.drawLabelingArea(pic1Bin, pic1Label, "1BinArea");

  // Area drawing (color).
  labeling0.drawLabelingArea(pic0BinColor, pic0Label, "0ColorArea");
  labeling1.drawLabelingArea(pic1BinColor, pic1Label, "1ColorArea");

  // Draw and save for pic0 and pic1 images. (ex1)
  background(0);
  size(660, 500);
  drawAndSave.drawImage("0", 0,        0, width/2, height/2);
  drawAndSave.drawImage("1", 0, height/2, width/2, height/2);
  save("data/ex1.jpg");

  // Draw and save for pic0 and pic1, pic0Bin, pic1Bin images. (ex2).
  background(0);
  drawAndSave.drawImage("0",          0,        0, width/2, height/2);
  drawAndSave.drawImage("1",          0, height/2, width/2, height/2);
  drawAndSave.drawImage("0Bin", width/2,        0, width/2, height/2);
  drawAndSave.drawImage("1Bin", width/2, height/2, width/2, height/2);
  save("data/ex2.jpg");

  // Draw and save for all images.
  background(0);
  size(1650, 500);
  drawAndSave.drawImage("0",                  0,        0, width/5, height/2);
  drawAndSave.drawImage("1",                  0, height/2, width/5, height/2);
  drawAndSave.drawImage("0Bin",         width/5,        0, width/5, height/2);
  drawAndSave.drawImage("1Bin",         width/5, height/2, width/5, height/2);
  drawAndSave.drawImage("0BinArea",   width*2/5,        0, width/5, height/2);
  drawAndSave.drawImage("1BinArea",   width*2/5, height/2, width/5, height/2);
  drawAndSave.drawImage("0BinColor",  width*3/5,        0, width/5, height/2);
  drawAndSave.drawImage("1BinColor",  width*3/5, height/2, width/5, height/2);
  drawAndSave.drawImage("0ColorArea", width*4/5,        0, width/5, height/2);
  drawAndSave.drawImage("1ColorArea", width*4/5, height/2, width/5, height/2);
}



