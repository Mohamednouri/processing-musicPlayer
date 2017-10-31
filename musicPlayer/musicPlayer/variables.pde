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
float vol = 0.9; //current volume level, 0 - 1

int songDurationM = 0; //how many minutes long the song is
int songDurationS = 0; //how many seconds long the song is, excluding minutes

float songStartMillis = 0; //used to find how far into the song the program is
int currentTimeM = 0; //how many minutes into the song the program is
int currentTimeS = 1; //how many seconds into the song the program is, excluding minutes

String songDurationDisplay = "0:00"; //used to display the length of the song
  String currentTimeDisplay = "0:00"; //used to display how far into the song the program is