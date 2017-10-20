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
int songDurationM = 0;
int songDurationS = 001234;
float songStartMillis = 0;
int currentTimeM = 0;
int currentTimeS = 000123;
String songDurationDisplay;
String currentTimeDisplay;
int songDurationComp;
int currentTimeDisplayComp;

void setup() {
  size(640, 360);
  
  seg = createFont("digital-7.ttf", 50.0);
  textFont(seg, 50);
  
  assignSongs();
}

void draw() {
  if (songDurationS < 10) {
    songDurationDisplay = str(songDurationM) + ":0" + str(songDurationS);
  } else {
    songDurationDisplay = str(songDurationM) + ":" + str(songDurationS);
  }
  
  if (currentTimeS < 10) {
    currentTimeDisplay = str(currentTimeM) + ":0" + str(currentTimeS);
  } else {
    currentTimeDisplay = str(currentTimeM) + ":" + str(currentTimeS);
  }
  
  background(10);
  fill(0, 150, 50);
  rect(screenX, screenY, 343, 82, 10);
  fill(255);
  text(str(currentSong + 1) + "-" + songNames[currentSong], screenX, screenY + 38);
  text(songDurationDisplay, screenX, screenY + 76);
  text(currentTimeDisplay, screenX + 251, screenY + 76);
  songs[currentSong].amp(vol);
  
  strokeWeight(1);
  stroke(255);
  noFill();
  
  rect(playX, playY, 50, 50, 10);
  
  rect(nextX, nextY, 50, 50, 10);
  triangle(nextX + 10, nextY + 15, nextX + 27, nextY + 25, nextX + 10, nextY + 35);
  triangle(nextX + 27, nextY + 15, nextX + 44, nextY + 25, nextX + 27, nextY + 35);
  
  rect(prevX, prevY, 50, 50, 10);
  triangle(prevX + 27, prevY + 15, prevX + 10, prevY + 25, prevX + 27, prevY + 35);
  triangle(prevX + 44, prevY + 15, prevX + 27, prevY + 25, prevX + 44, prevY + 35);
  
  if (play) {
    fill(0, 150, 50);
  }
  triangle(playX + 10, playY + 15, playX + 27, playY + 25, playX + 10, playY + 35);
  rect(playX + 27, playY + 15, 5, 20);
  rect(playX + 34, playY + 15, 5, 20);
  
  strokeWeight(3);
  line(volLineX, volLineY, volLineX + 160, volLineY);
  noStroke();
  fill(0, 150, 50);
  ellipse(volDotX, volDotY, 12, 12);
  
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
  
    
  if ((songDurationM <= currentTimeM) && (songDurationS <= currentTimeS)) {
    endOfSong();
  }
  
  vol = ((volDotX - volLineX) / 160);
  
  checkSongTime();
}

void playPauseMusic() { //function to play and pause the music when the play button is pressed
  if (play) { //if the music is supposed to be playing
    songs[currentSong].play(); //plays the song
    songDurationM = floor((songs[currentSong].duration()) / 60); //finds how many minutes long the song is
    songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60))))); //finds how many seconds long the song is (excluding any minutes)
    currentTimeM = 0; //these three lines of code are used to setup the program to count how far into the song we are
    currentTimeS = 0;
    songStartMillis = millis();
  } else { //if the music is supposed to be stopped
    songs[currentSong].stop(); //stops the music
  }
}

void endOfSong() { //function that goes to the next song when the current one is finished
  songs[currentSong].stop(); //stops playing the current song (REDUNDANT)
  if (currentSong == songs.length - 1) { //if the current song is the last one in the playlist
    currentSong = 0; //goes back to first song
  } else {
    currentSong += 1; //goes to next song
  }
  songs[currentSong].play(); //for explanation check playPauseMusic()
  songDurationM = floor((songs[currentSong].duration()) / 60);
  songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60)))));
  currentTimeM = 0;
  currentTimeS = 0;
  songStartMillis = millis();
}

void nextSong() { //function that goes to the next song when the next song button is pressed
  songs[currentSong].stop(); //stops the current song
  if (currentSong == songs.length - 1) { //for explanation check playPauseMusic() and endOfSong()
    currentSong = 0;
  } else {
    currentSong += 1;
  }
  songs[currentSong].play();
  songDurationM = floor((songs[currentSong].duration()) / 60);
  songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60)))));
  currentTimeM = 0;
  currentTimeS = 0;
  songStartMillis = millis();
  play = true; //used so that you can go the the next song if a song isn't playing
}

void prevSong() { //function that goes to the previous song when the previous song button is pressed
  songs[currentSong].stop(); //for explanation check playPauseMusic() and endOfSong()
  if (currentSong == 0) { //reverse of going to next song
    currentSong = songs.length - 1;
  } else {
    currentSong -= 1;
  }
  songs[currentSong].play();
  songDurationM = floor((songs[currentSong].duration()) / 60);
  songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60)))));
  currentTimeM = 0;
  currentTimeS = 0;
  songStartMillis = millis();
  play = true; //used so that you can go the the next song if a song isn't playing
}

void checkSongTime() { //WORK ON THIS
  if (play) {
    if (((millis() - songStartMillis) > currentTimeS * 1000)) {
      currentTimeS += 1;
    }
    if (currentTimeS / 60 >= 1) {
      currentTimeM += 1;
      songStartMillis = millis();
      currentTimeS -= 60;
    }
  }
}

void volChange() { //function to move the volume slider
  if ((mouseX > volLineX) && (mouseX < volLineX + 160)) { //move to mouseX as long as it doesn't go off of the line
    volDotX = mouseX;
  }
}