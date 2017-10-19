import processing.sound.*;

boolean play = false;
int currentSong = 5;
int playX = 295;
int playY = 155;
int nextX = 350;
int nextY = 155;
int prevX = 200;
int prevY = 155;


void setup() {
  size(640, 360);
  
  assignSongs();
}

void draw() {
  background(10);
  stroke(255);
  fill(10);
  rect(playX, playY, 50, 50, 10);
  if (play) {
    fill(0, 150, 50);
  } else {
    fill(10);
  }
  triangle(playX + 10, playY + 15, playX + 27, playY + 25, playX + 10, playY + 35);
  rect(playX + 27, playY + 15, 5, 20);
  rect(playX + 34, playY + 15, 5, 20);
  
  fill(10);
  
  rect(nextX, nextY, 50, 50, 10);
  triangle(nextX + 10, nextY + 15, nextX + 27, nextY + 25, nextX + 10, nextY + 35);
  triangle(nextX + 27, nextY + 15, nextX + 44, nextY + 25, nextX + 27, nextY + 35);
  
  rect(prevX, prevY, 50, 50, 10);
  triangle(prevX + 27, prevY + 15, prevX + 10, prevY + 25, prevX + 27, prevY + 35);
  triangle(prevX + 44, prevY + 15, prevX + 27, prevY + 25, prevX + 44, prevY + 35);
  
  /*if (mousePressed && (((mouseX > 300) && (mouseX < 350)) && ((mouseY > 170) && (mouseY < 220)))) {
    if (play) {
      play = false;
    } else {
      play = true;
    }
    playPauseMusic();
  }*/
  
  if (keyPressed && key == ' ') {
    playPressed();
  }
}

void playPressed() {
  if (play) {
    play = false;
  } else {
    play = true;
  }
  playPauseMusic();
}

void playPauseMusic() {
  try {
    if (play) {
      songs[currentSong].play();
    } else {
      songs[currentSong].stop();
    }
  } catch (Exception ex) {
    print("oops");
  }
}