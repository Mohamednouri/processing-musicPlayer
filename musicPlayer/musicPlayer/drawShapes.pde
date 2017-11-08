void drawShapes() {
  background(10);
  fill(0, 150, 50); //draws fake screen
  rect(screenX, screenY, 343, 82, 10);
  
  fill(255); //draws information to screen
  text(str(currentSong + 1) + "-" + songNames[currentSong], screenX, screenY + 38); //song name
  text(songDurationDisplay, screenX + 251, screenY + 76); //length of song
  text(currentTimeDisplay, screenX, screenY + 76); //how far along into song
  text("-", screenX + 159, screenY + 76); //draws - between time values
  
  strokeWeight(1);
  stroke(255);
  noFill();
  
  rect(playX, playY, 50, 50, 10); //draws back of play button
  
  rect(nextX, nextY, 50, 50, 10); //draws next song button
  triangle(nextX + 10, nextY + 15, nextX + 27, nextY + 25, nextX + 10, nextY + 35);
  triangle(nextX + 27, nextY + 15, nextX + 44, nextY + 25, nextX + 27, nextY + 35);
  
  rect(prevX, prevY, 50, 50, 10); //draws prev song button
  triangle(prevX + 24, prevY + 15, prevX + 7, prevY + 25, prevX + 24, prevY + 35);
  triangle(prevX + 41, prevY + 15, prevX + 24, prevY + 25, prevX + 41, prevY + 35);
  
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