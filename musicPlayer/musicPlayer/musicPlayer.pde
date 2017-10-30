import processing.sound.*;

PFont seg; //creates font

void setup() {
  size(383, 200); 
  seg = createFont("digital-7.ttf", 50.0); //assigns the font
  textFont(seg, 50);
  
  assignSongs();
  
  songDurationM = floor((songs[currentSong].duration()) / 60); //for explanation check playPauseMusic()
  songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60)))));
}

void draw() {
  if (songDurationS < 10) {  //if seconds less than 10 adds 0 before the number
    songDurationDisplay = str(songDurationM) + ":0" + str(songDurationS);
  } else {
    songDurationDisplay = str(songDurationM) + ":" + str(songDurationS);
  }
  
  if (currentTimeS - 1 < 10) {
    currentTimeDisplay = str(currentTimeM) + ":0" + str(currentTimeS - 1);
  } else {
    currentTimeDisplay = str(currentTimeM) + ":" + str(currentTimeS - 1);
  }
  
  //start of drawing shapes
  background(10);
  fill(0, 150, 50); //draws fake screen
  rect(screenX, screenY, 343, 82, 10);
  
  fill(255); //draws information to screen
  text(str(currentSong + 1) + "-" + songNames[currentSong], screenX, screenY + 38); //song name
  text(songDurationDisplay, screenX, screenY + 76); //length of song
  text(currentTimeDisplay, screenX + 251, screenY + 76); //how far along into song
  
  songs[currentSong].amp(vol);
  
  strokeWeight(1);
  stroke(255);
  noFill();
  
  rect(playX, playY, 50, 50, 10); //draws back of play button
  
  rect(nextX, nextY, 50, 50, 10); //draws next song button
  triangle(nextX + 10, nextY + 15, nextX + 27, nextY + 25, nextX + 10, nextY + 35);
  triangle(nextX + 27, nextY + 15, nextX + 44, nextY + 25, nextX + 27, nextY + 35);
  
  rect(prevX, prevY, 50, 50, 10); //draws prev song button
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
  stroke(0, 150, 50);
  line(volLineX, volLineY, volDotX, volLineY);
  fill(0, 150, 50);
  noStroke();
  ellipse(volDotX, volDotY, 12, 12);
  //end of drawing shapes
  
  if (mousePressed) {
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
  } else {
    pressed = false; //pressed boolean makes the code above run only once when the mouse is pressed
  }
  
    
  if (((songDurationM <= currentTimeM) && (songDurationS <= currentTimeS - 1)) && (play)) { //if the program is at the end of the song
    endOfSong();
  }
  
  vol = ((volDotX - volLineX) / 160); //sets the volume variable based on the position of the volume knob
  
  checkSongTime();
}

void playPauseMusic() { //function to play and pause the music when the play button is pressed
  if (play) { //if the music is supposed to be playing
    songStartMillis = millis() - (currentTimeS) * 1000;
    songs[currentSong].jump(currentTimeS + (currentTimeM * 60));
    songDurationM = floor((songs[currentSong].duration()) / 60); //finds how many minutes long the song is
    songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60))))); //finds how many seconds long the song is (excluding any minutes)
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
  songs[currentSong].play(); ////plays the song
  songDurationM = floor((songs[currentSong].duration()) / 60); //for explanation check playPauseMusic()
  songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60)))));
  currentTimeM = 0; //these three lines of code are used to setup the program to count how far into the song the program is
  currentTimeS = 1;
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
  currentTimeS = 1;
  songStartMillis = millis();
  play = true; //used so that the program can go to the next song if a song isn't playing
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
  currentTimeS = 1;
  songStartMillis = millis();
  play = true; //used so that the program can go to the previous song if a song isn't playing
}

void checkSongTime() { //function to count how far into the song the program is
  if (play) {
    if (((millis() - songStartMillis) > currentTimeS * 1000)) { //if song is 1000 milliseconds (1 second) further than before
      currentTimeS += 1; //add one to the second counter
    }
    if (currentTimeS >= 61) { //adds to the minute counter every minute
      currentTimeM += 1;
      songStartMillis = millis();
      currentTimeS -= 60; //restarts second counter variable
    }
  }
}

void volChange() { //function to move the volume slider
  if ((mouseX > volLineX) && (mouseX < volLineX + 160)) { //move to mouseX as long as it doesn't go off of the line
    volDotX = mouseX;
  }
}