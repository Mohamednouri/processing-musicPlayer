import processing.sound.*;

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

void assignSongs() {
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