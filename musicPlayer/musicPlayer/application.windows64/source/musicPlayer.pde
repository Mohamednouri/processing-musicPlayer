import processing.sound.*;

PFont seg; //creates font

void setup() {
  size(383, 200); 
  seg = createFont("digital-7.ttf", 50.0); //assigns the font
  textFont(seg, 50);
  
  assignSongs();
  checkSongDuration();
}

void draw() {
  drawShapes(); //calls function to draw shapes
  
  if (mousePressed) {
    buttonPress();
  } else {
    pressed = false; //pressed boolean makes the code above run only once when the mouse is pressed
  }
    
  if (((songDurationM <= currentTimeM) && (songDurationS <= currentTimeS - 1)) && (play)) { //if the program is at the end of the song
    endOfSong();
  }
  
  checkSongTime(); //calls function to check how far along the song is
}

void buttonPress() {
  if (((mouseX > playX) && (mouseX < playX + 50)) && ((mouseY > playY) && (mouseY < playY + 50)) && !(pressed)) { //if the mouse pressed the play pause button
    if (play) {
      play = false;
    } else {
      play = true;
    }
    playPauseMusic();
    pressed = true;
  } else if (((mouseX > nextX) && (mouseX < nextX + 50)) && ((mouseY > nextY) && (mouseY < nextY + 50)) && !(pressed)) { //if the mouse pressed the next song button
    nextSong();
    pressed = true;
  } else if (((mouseX > prevX) && (mouseX < prevX + 50)) && ((mouseY > prevY) && (mouseY < prevY + 50)) && !(pressed)) { //if the mouse pressed the previous song button
    prevSong();
    pressed = true;
  } else if (((mouseX > volDotX - 12) && (mouseX < volDotX + 12)) && ((mouseY > volDotY - 12) && (mouseY < volDotY + 12))) { //if the mouse is using the volume slider
    volChange();
  }
}