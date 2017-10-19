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
int screenX = 149;
int screenY = 50;
float volLineX = 240; //these are floats so that the program can get volume information from them
float volLineY = 260;
float volDotX = 384;
float volDotY = 260;
float vol = 0.9;

void setup() {
  size(640, 360);
  
  seg = createFont("digital-7.ttf", 50.0);
  textFont(seg, 50);
  
  assignSongs();
}

void draw() {
  background(10);
  fill(0, 150, 50);
  rect(screenX, screenY, 343, 100);
  fill(255);
  text(str(currentSong + 1) + "-" + songNames[currentSong], screenX, screenY + 38);
  songs[currentSong].amp(vol);
  
  stroke(255);
  strokeWeight(1);
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
  
  strokeWeight(3);
  line(volLineX, volLineY, volLineX + 160, volLineY);
  noStroke();
  fill(0, 150, 50);
  ellipse(volDotX, volDotY, 12, 12);
  
  if (keyPressed && key == 'w') {
    if (vol < 1.0) {
      vol += 0.1;
    }
  } else if (keyPressed && key == 's') {
    if (vol > 0) {
      vol -= 0.1;
    }
  }
  
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
    } else if (((mouseX > volDotX - 12) && (mouseX < volDotX + 12)) && ((mouseY > volDotY - 12) && (mouseY < volDotY + 12))) {
      volChange();
    }
  } else {
    pressed = false;
  }
  
  checkVolume();
}

void checkVolume() {
  vol = ((volDotX - volLineX) / 160);
}

void volChange() {
  if ((mouseX > volLineX) && (mouseX < volLineX + 160)) {
    volDotX = mouseX;
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