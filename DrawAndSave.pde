// Visual Media Processing report2 1516016 3EP4-33 Tomizu Tastuyoshi.
// Class for drawing and saving.
public class DrawAndSave {

  // Method for drawing image by inserting text.
  void drawImage(String name, int w, int h, int x, int y) {
    String path = "data/pic" + name + ".jpg";
    PImage pic = loadImage(path);
    image(pic, w, h, x, y);
  }

  // Method for saving image.
  void saveImage(String name) {
    String path = "data/pic" + name + ".jpg";
    save(path);
  }

  // Method for drawing and saving image.
  void drawSave(PImage pic, String name) {
    image(pic, 0, 0, WIDTH, HEIGHT);
    saveImage(name);
  }

  // Method for drawing and saving a binarization image.
  void drawSaveBinarization(PImage pic, String name) {
    pic.filter(THRESHOLD, 0.5);
    drawAndSave.drawSave(pic, name);
  }
}

