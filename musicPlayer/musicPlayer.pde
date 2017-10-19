import processing.sound.*;

PFont seg;

boolean play = false;
boolean pressed = false;
int currentSong = 0;
int playX = 295;
int playY = 200;
int nextX = 350;
int nextY = 200;
int prevX = 240;
int prevY = 200;

void setup() {
  size(640, 360);
  
  seg = createFont("digital-7.ttf", 50.0);
  textFont(seg, 50);
  
  assignSongs();
}

void draw() {
  background(10);
  fill(255);
  text(str(currentSong + 1) + "-" + songNames[currentSong], 100, 100);
  
  stroke(255);
  if (play) {
    fill(0, 150, 50);
  } else {
    noFill();
  }
  triangle(playX + 10, playY + 15, playX + 27, playY + 25, playX + 10, playY + 35);
  rect(playX + 27, playY + 15, 5, 20);
  rect(playX + 34, playY + 15, 5, 20);
  
  noFill();
  
  rect(playX, playY, 50, 50, 10);
  
  rect(nextX, nextY, 50, 50, 10);
  triangle(nextX + 10, nextY + 15, nextX + 27, nextY + 25, nextX + 10, nextY + 35);
  triangle(nextX + 27, nextY + 15, nextX + 44, nextY + 25, nextX + 27, nextY + 35);
  
  rect(prevX, prevY, 50, 50, 10);
  triangle(prevX + 27, prevY + 15, prevX + 10, prevY + 25, prevX + 27, prevY + 35);
  triangle(prevX + 44, prevY + 15, prevX + 27, prevY + 25, prevX + 44, prevY + 35);
  
  if (mousePressed) {
    if (((mouseX > playX) && (mouseX < playX + 50)) && ((mouseY > playY) && (mouseY < playY + 50)) && !(pressed)) {
      if (play) {
        play = false;
      } else {
        play = true;
      }
      playPauseMusic();
      pressed = true;
    } else if (((mouseX > nextX) && (mouseX < nextX + 50)) && ((mouseY > nextY) && (mouseY < nextY + 50)) && !(pressed)) {
      nextSong();
      pressed = true;
    } else if (((mouseX > prevX) && (mouseX < prevX + 50)) && ((mouseY > prevY) && (mouseY < prevY + 50)) && !(pressed)) {
      prevSong();
      pressed = true;
    }
  } else {
    pressed = false;
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

void prevSong() {
  songs[currentSong].stop();
  if (currentSong == 0) {
    currentSong = songs.length - 1;
  } else {
    currentSong -= 1;
  }
  songs[currentSong].play();
  play = true;
}

void nextSong() {
  songs[currentSong].stop();
  if (currentSong == songs.length - 1) {
    currentSong = 0;
  } else {
    currentSong += 1;
  }
  songs[currentSong].play();
  play = true;
}

void playPauseMusic() {
  if (play) {
    songs[currentSong].play();
  } else {
    songs[currentSong].stop();
  }
}