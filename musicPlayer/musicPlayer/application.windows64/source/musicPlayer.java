import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class musicPlayer extends PApplet {



PFont seg; //creates font

public void setup() {
   
  seg = createFont("digital-7.ttf", 50.0f); //assigns the font
  textFont(seg, 50);
  
  assignSongs();
  checkSongDuration();
}

public void draw() {
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

public void buttonPress() {
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
public void drawShapes() {
  background(10);
  fill(0, 150, 50); //draws fake screen
  rect(screenX, screenY, 343, 82, 10);
  
  fill(255); //draws information to screen
  text(str(currentSong + 1) + "-" + songNames[currentSong], screenX, screenY + 38); //song name
  text(songDurationDisplay, screenX, screenY + 76); //length of song
  text(currentTimeDisplay, screenX + 251, screenY + 76); //how far along into song
  
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
    fill(0, 150, 50); //makes the play pause button green while music playing
  }
  triangle(playX + 10, playY + 15, playX + 27, playY + 25, playX + 10, playY + 35); //finishes drawing the play pause button
  rect(playX + 27, playY + 15, 5, 20);
  rect(playX + 34, playY + 15, 5, 20);
  
  strokeWeight(3); //draws the volume bar
  line(volLineX, volLineY, volLineX + 160, volLineY);
  stroke(0, 150, 50);
  line(volLineX, volLineY, volDotX, volLineY);
  fill(0, 150, 50);
  noStroke();
  ellipse(volDotX, volDotY, 12, 12);
}


SoundFile battleGround;
SoundFile coldRise;
SoundFile coldStep;
SoundFile eureka;
SoundFile ghostWalk;
SoundFile littleDrunkQuietFloats;
SoundFile theNightFalling;
SoundFile burner;
SoundFile cosmos;
SoundFile intoTheDepths;
SoundFile northSea;
SoundFile startYourEngines;
SoundFile theSimplest;

SoundFile[] songs = {battleGround, coldRise, coldStep, eureka, ghostWalk, littleDrunkQuietFloats, theNightFalling, burner, cosmos, intoTheDepths, northSea, startYourEngines, theSimplest};
String[] songNames = {"battleGround", "coldRise", "coldStep", "eureka", "ghostWalk", "littleDrunkQuietFloats", "theNightFalling", "burner", "cosmos", "intoTheDepths", "northSea", "startYourEngines", "theSimplest"};

public void assignSongs() {
  for (int i = 0; i < songNames.length; i++) { //shortens song names if they're too long to display
    if (i < 9) {
      if (songNames[i].length() > 13) {
        songNames[i] = songNames[i].substring(0, 10) + "...";
      }
    } else {
      if (songNames[i].length() > 12) {
        songNames[i] = songNames[i].substring(0, 9) + "...";
      }
    }
  }
  
  battleGround = new SoundFile(this, "battleGround.mp3");
  coldRise = new SoundFile(this, "coldRise.mp3");
  coldStep = new SoundFile(this, "coldStep.mp3");
  eureka = new SoundFile(this, "eureka.mp3");
  ghostWalk = new SoundFile(this, "ghostWalk.mp3");
  littleDrunkQuietFloats = new SoundFile(this, "littleDrunkQuietFloats.mp3");
  theNightFalling = new SoundFile(this, "theNightFalling.mp3");
  burner = new SoundFile(this, "burner.mp3");
  cosmos = new SoundFile(this, "cosmos.mp3");
  intoTheDepths = new SoundFile(this, "intoTheDepths.mp3");
  northSea = new SoundFile(this, "northSea.mp3");
  startYourEngines = new SoundFile(this, "startYourEngines.mp3");
  theSimplest = new SoundFile(this, "theSimplest.mp3");
  
  songs[0] = battleGround;
  songs[1] = coldRise;
  songs[2] = coldStep;
  songs[3] = eureka;
  songs[4] = ghostWalk;
  songs[5] = littleDrunkQuietFloats;
  songs[6] = theNightFalling;
  songs[7] = burner;
  songs[8] = cosmos;
  songs[9] = intoTheDepths;
  songs[10] = northSea;
  songs[11] = startYourEngines;
  songs[12] = theSimplest;
}
public void playPauseMusic() { //function to play and pause the music when the play button is pressed
  if (play) { //if the music is supposed to be playing
    songStartMillis = millis() - (currentTimeS) * 1000;
    songs[currentSong].jump(currentTimeS + (currentTimeM * 60));
    checkSongDuration();
  } else { //if the music is supposed to be stopped
    songs[currentSong].stop(); //stops the music
  }
}

public void endOfSong() { //function that goes to the next song when the current one is finished
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

public void nextSong() { //function that goes to the next song when the next song button is pressed
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

public void prevSong() { //function that goes to the previous song when the previous song button is pressed
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

public void checkSongTime() { //function to count how far into the song the program is
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

public void volChange() { //function to move the volume slider
  if ((mouseX > volLineX) && (mouseX < volLineX + 160)) { //move to mouseX as long as it doesn't go off of the line
    volDotX = mouseX;
  }
  vol = ((volDotX - volLineX) / 160); //sets the volume variable based on the position of the volume knob  
  songs[currentSong].amp(vol);
}

public void checkSongDuration() {
  songDurationM = floor((songs[currentSong].duration()) / 60); //finds how many minutes long the song is
  songDurationS = PApplet.parseInt((60 * ((songs[currentSong].duration()) / 60 - (floor((songs[currentSong].duration()) / 60))))); //finds how many seconds long the song is (excluding any minutes)
  
  if (songDurationS < 10) {  //if seconds less than 10 adds 0 before the number
    songDurationDisplay = str(songDurationM) + ":0" + str(songDurationS); //creates a variable used to display the length of the song
  } else {
    songDurationDisplay = str(songDurationM) + ":" + str(songDurationS);
  }
}
boolean play = false;
boolean pressed = false;
int currentSong = 0;

int playX = 166; //play button coordinates 295
int playY = 116;

int nextX = 221; //next song button coordinates
int nextY = 116;

int prevX = 111; //previous song button coordinates
int prevY = 116;

int screenX = 20; //screen coordinates
int screenY = 20;

float volLineX = 111; //volume slider coordinates, floats to get volume information from them
float volLineY = 176;
float volDotX = 255;
float volDotY = 176;
float vol = 0.9f; //current volume level, 0 - 1

int songDurationM = 0; //how many minutes long the song is
int songDurationS = 0; //how many seconds long the song is, excluding minutes

float songStartMillis = 0; //used to find how far into the song the program is
int currentTimeM = 0; //how many minutes into the song the program is
int currentTimeS = 1; //how many seconds into the song the program is, excluding minutes

String songDurationDisplay = "0:00"; //used to display the length of the song
  String currentTimeDisplay = "0:00"; //used to display how far into the song the program is
  public void settings() {  size(383, 200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "musicPlayer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
