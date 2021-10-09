import processing.sound.*;

float[] x = new float[50];
float[] y = new float[50];
float[] speed = new float[50];
int z = 350;
int v;
int score = 0, lives = 3;
float p = random(150 ,650), q = -100;
int bull_y = 600;
boolean firing = false;
boolean collision = false;
PImage img;
PImage target;
SoundFile song;
SoundFile laser;


void setup()
{
  size(800,800);
  frameRate(60);
  stars();
  img = loadImage("Ship.png");
  target = loadImage("tar.png");
  song = new SoundFile(this, "Retro.mp3");
  laser = new SoundFile(this, "laser.mp3");
  song.loop();
}

void draw()
{
  background(1);
  smooth();
  println(frameRate);
  //Animate 50 stars to uniquely move up at a random speed and point in the screen
  for(int i = 0; i < 50; i++) 
  {
    fill(255);
    ellipse(x[i],y[i],5,5);
    
  
    y[i] = y[i] + speed[i];
    //reset when it reaches border
    if(y[i] > 800) 
    {
      y[i] = 0;
    }
  }
  
  if(firing == true)
  {
   v = z+46;
   bullet();
  }
  enemy();
  ship();
  textSize(40);
  fill(255,225,0);
  text("Score: "+score, 10,760);
  textSize(40);
  fill(255,225,0);
  text("Lives: "+lives, 610,760);
  
}
void stars()
{ 
  //Create 50 Stars at random points on the x and y axis
  for(int i = 0; i < 50; i++) 
  {  
    x[i] = random(0, width);
    y[i] = random(0, height);
    speed[i] = random(5,7);
  }
}

void ship()
{
  image(img, z, 600, 100, 100);
  
  if(dist(p,q,z-80,600)<= 95 )
  {
    exit();
  }
}

void bullet()
{
  if(firing == true)
  {
   bull_y += -100;
   fill(0, 200, 0);
   rect(v, bull_y, 6, 30);
  }
  if(bull_y < 0)
  {
    bull_y = 600;
    firing = false;
  }
}

void enemy()
{
  image(target, p, q, 250, 150);
 
  if(collision == false)
  {
    q += 5;
    if(score > 10)
    {
     q += 2;
    }
    if(score > 20)
    {
     q += 1 ;
    }
    if(score > 50)
    {
     q += 2.5 ;
    }
    if(q > 800)
    {
     lives--;
     p = random(100,700);
     q =  -200;
     if(lives == 0)
     {
       exit();
     }
    }
   }
    if(dist(p+125,q,v,bull_y)<= 65)
    {
     collision = true;
    }
    if(collision == true)
    {
     p = random(100,700);
     q =  -200;
     score++;
     collision = false;
    }
 }
void keyPressed()
{
  if(key == 'd' )
  {
    if(z < 740)
    {
     z += 13.5;
    }
    if(score >= 15)
    {
     z += 14;
    }
  }
  if(key == 'a' )
  {
    if(z > -40)
    {
     z += -13.5;
    }
    if(score >= 15)
    {
     z += -14;
    }
  }
  if(key == ' ')
  {
    laser.play();
    firing = true;
  }
}
