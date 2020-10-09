Player p1;
Platform[] platforms;

int level, seconds, minutes;
boolean left, right, up, down, gameOn;

void setup()
{
  size(800, 800);
  textSize(20);
  textAlign(CENTER, BOTTOM);

  // Defining variables
  left = false;
  right = false;
  up = false;
  down = false;
  gameOn = true;
  level = 1;

  // Creating objects
  p1 = new Player();
  createPlatforms();
}

void draw()
{ 
  background(255);

  if (p1.y + p1.h >= 0 && gameOn == true)
  { 
    play();
    display();
  } else
  {
    restart();
  }
}

void createPlatforms()
{
  // Creates instance of platforms
  platforms = new Platform[7];
  platforms[0] = new Platform(width/2-100, 700, 200, 25, 0);
  for (int i=1; i < platforms.length; i += 1)
  {
    platforms[i] = new Platform(random(200, 500), 700-(100*i), 200, 25, random(1, 4));
  }
}

void play()
{

  for (int i=0; i < platforms.length; i += 1)
  {
    if (gameOn == true)
    {
      platforms[i].update();
      p1.collisionSide = PlatformCollisions(p1, platforms[i]);
      p1.checkPlatform();
      platforms[i].display();
    }
  }

  p1.update();

  p1.display();
}

void restart()
{
  level += 1;
  p1.x = width/2-p1.h;
  p1.y = 700 - p1.h;
  createPlatforms();
  play();
}

void finish()
{
  gameOn = false;
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(0);
  text("You reached Level "+ level, width/2, height/2-30);
  text("It took you " + nf(minutes, 2) + ":"+ nf(seconds, 2), width/2, height/2 + 60);
  noLoop();
}

void display()
{
  if (gameOn)
  {
    fill(0);
    text("Level "+ level, width/2, 20);
    seconds = (frameCount/60)%60;
    minutes = (frameCount/60/60)%60;
    text(nf(minutes, 2) + ":"+ nf(seconds, 2), width/2, 40);
  }
}

String PlatformCollisions(Player r1, Platform r2)
{

  // Distance between centres of player and platform
  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.w/2 + r2.w/2;
  float combinedHalfHeights = r1.h/2 + r2.h/2;

  // Checks if collision or overlap has occured
  // First loop for X, second loop for Y
  if (abs(dx) < combinedHalfWidths)
  {
    if (abs(dy) < combinedHalfHeights)
    {
      // Checks by how much player and platform have overlapped
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);

      // Checks which overlap is the LEAST between X and Y
      // Moves rectangle to remove overlap 
      // and calls display as to not show overlap
      if (overlapX >= overlapY)
      { 
        if (dy > 0)
        {
          r1.y += overlapY;
          return "top";
        } else
        {
          r1.y -= overlapY;
          return "bottom";
        }
      } else 
      {
        if (dx > 0)
        {
          r1.x += overlapX;
          return "left";
        } else
        {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else
    {
      // No collision on y-axis
      return "none";
    }
  } else
  {
    // No collision on x-axis
    return "none";
  }
}

void keyPressed()
{

  switch (key)
  {
  case 'w':
    {
      up = true;
      break;
    }

  case 'a':
    {
      left = true;
      break;
    }

  case 's':
    {
      down = true;
      break;
    }

  case 'd':
    {
      right = true;
      break;
    }
  }
}

void keyReleased()
{

  switch (key)
  {
  case 'w':
    {
      up = false;
      break;
    }

  case 'a':
    {
      left = false;
      break;
    }

  case 's':
    {
      down = false;
      break;
    }

  case 'd':
    {
      right = false;
      break;
    }
  }
}

void displayPosData()
{
  // for troubleshooing issues
  fill(0);
  String s = "\nMOVEMENT|" + " w: " + p1.w + "  h: " + p1.h + "  key: " + key + "  up: " + up + "  down: " + down + "  left: " + left + "  right: " + right +
    "\nPLAYER pos|" + " x: " + p1.x + "  y: " + p1.y +
    "\nPLAYER speed|" + " vx: " + p1.vx + "  vy: " + p1.vy +  
    "\nPLAYER acceleration|" + " ax: " + p1.ax + "  ay: " + p1.ay +
    "\nPLAYER forces|" + " speedLimit: " + p1.speedLimit + "  friction: " + p1.friction + "  gravity" + p1.gravity + "  bounce" + p1.bounce + "  jumpForce" + p1.jumpForce + "  guard" + p1.guard + 
    "\ncollisionsSide: " + p1.collisionSide + 
    "\nOnGround: " + p1.onGround;
  text(s, 50, 50);
}
