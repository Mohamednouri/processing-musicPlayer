void playPauseMusic() { //function to play and pause the music when the play button is pressed
  if (play) { //if the music is supposed to be playing
    songStartMillis = millis() - (currentTimeS) * 1000;
    songs[currentSong].jump(currentTimeS + (currentTimeM * 60));
    checkSongDuration();
  } else { //if the music is supposed to be stopped
    songs[currentSong].stop(); //stops the music
  }
}

void endOfSong() { //function that goes to the next song when the current one is finished
  if (currentSong == songs.length - 1) { //if the current song is the last one in the playlist
    currentSong = 0; //goes back to first song
  } else {
    currentSong += 1; //goes to next song
  }
  songs[currentSong].play(); //plays the song
  checkSongDuration();
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
  checkSongDuration();
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
  checkSongDuration();
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
  
  if (currentTimeS - 1 < 10) {
    currentTimeDisplay = str(currentTimeM) + ":0" + str(currentTimeS - 1); //creates a variable used to display how far along the song is
  } else {
    currentTimeDisplay = str(currentTimeM) + ":" + str(currentTimeS - 1);
  }
}

void volChange() { //function to move the volume slider
  if ((mouseX > volLineX) && (mouseX < volLineX + 160)) { //move to mouseX as long as it doesn't go off of the line
    volDotX = mouseX;
  }
  vol = ((volDotX - volLineX) / 160); //sets the volume variable based on the position of the volume knob  
  songs[currentSong].amp(vol);
}

void checkSongDuration() {
  songDurationM = floor((songs[currentSong].duration()) / 60); //finds how many minutes long the song is
  songDurationS = int((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60))))); //finds how many seconds long the song is (excluding any minutes)
  
  if (songDurationS < 10) {  //if seconds less than 10 adds 0 before the number
    songDurationDisplay = str(songDurationM) + ":0" + str(songDurationS); //creates a variable used to display the length of the song
  } else {
    songDurationDisplay = str(songDurationM) + ":" + str(songDurationS);
  }
}