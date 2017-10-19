import processing.sound.*;

SoundFile battleGround;
SoundFile coldRise;
SoundFile coldStep;
SoundFile eureka;
SoundFile ghostWalk;
SoundFile littleDrunkQuietFloats;
SoundFile theNightFalling;

SoundFile[] songs = {battleGround, coldRise, coldStep, eureka, ghostWalk, littleDrunkQuietFloats, theNightFalling};
String[] songNames = {"battleGround", "coldRise", "coldStep", "eureka", "ghostWalk", "littleDrunkQuietFloats", "theNightFalling"};

void assignSongs() {
  battleGround = new SoundFile(this, "battleGround.mp3");
  coldRise = new SoundFile(this, "coldRise.mp3");
  coldStep = new SoundFile(this, "coldStep.mp3");
  eureka = new SoundFile(this, "eureka.mp3");
  ghostWalk = new SoundFile(this, "ghostWalk.mp3");
  littleDrunkQuietFloats = new SoundFile(this, "littleDrunkQuietFloats.mp3");
  theNightFalling = new SoundFile(this, "theNightFalling.mp3");
  
  songs[0] = battleGround;
  songs[1] = coldRise;
  songs[2] = coldStep;
  songs[3] = eureka;
  songs[4] = ghostWalk;
  songs[5] = littleDrunkQuietFloats;
  songs[6] = theNightFalling;
}