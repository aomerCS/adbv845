class Player
{
  // width, height, xPos, yPos, Velocity, Acceleration
  float w, h, x, y, vx, vy, ax, ay, 
    speedLimit, friction, gravity, bounce, jumpForce, guard;

  boolean onGround;
  String collisionSide;

  Player()
  {
    w = 30;
    h = 30;
    x = width/2;
    y = 700-h;
    vx = 0;
    vy = 0;
    ax = 0;
    ay = 0;
    //friction = 0.96;
    gravity = 0.8; 
    bounce = -0.7;
    speedLimit = 5;
    guard = 1E-5;
    jumpForce = -15.5;
    onGround = false;
    collisionSide = "";
  }

  void update()
  {

    if (left && !right)
    {
      ax = -0.2;
      friction = 1;
    }
    if (!left && right)
    {
      ax = 0.2;
      friction = 1;
    }
    if (!left && !right)
    {
      ax = 0;
    }

    // Jump
    if (up && !down && onGround)
    {
      vy = jumpForce;
      onGround = false;
      friction = 1;
    }

    if (!up && down)
    {
      //ay = 0.2;
      //friction = 1;
    }
    if (!up && !down)
    {
      //ay = 0;
    }

    // Activates gravity and friction
    if (!up && !down && !left && !right)
    {
      friction = 0.8;
      //gravity = 0.8;
    }

    // acceleration increases velocity
    vx += ax;
    vy = vy + ay;

    // reduces velocity when friction < 1, friction 1 = no friction
    vx = vx*friction;
    //vy *= friction;

    // gravity acts on player
    vy += gravity;

    // Stops player from accelerating infinitely
    if (vx > speedLimit)
    {
      vx = speedLimit;
    }

    if (vx < -speedLimit)
    {
      vx = -speedLimit;
    }

    // Faster speed when desending
    if (vy > 3 * speedLimit)
    {
      vy = 3 * speedLimit;
    }

    if (vy < -speedLimit)
    {
      //vy = -speedLimit;
    }

    // Prevents vx from becoming infintesimly small
    if (!up && !down && !left && !right)
    {
      if (abs(vx) < guard)
      {
        vx = 0;
      }
    }

    //Movement
    x += vx;
    y += vy;

    checkBoundaries();
  }

  void checkBoundaries()
  {
    // Left & Right
    if (x < 0)
    {
      x = 0;
    }
    if (x > width-w)
    {
      x = width-w;
    }

    // Bottom
    /*if (y + h > height && level == 1)
    {
      onGround = true;
      vy = 0;
      y = height-h;
    }*/

    if (y > height)
    {
      finish();
    }
  }

  void checkPlatform()
  {
    if (collisionSide == "bottom" && vy >= 0)
    {
      onGround = true;
      vy = 0;
    } else if (collisionSide == "top" && vy <= 0)
    {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0)
    {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0)
    {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0)
    {
      onGround = false;
    }
  }

  void display()
  {

    fill(0, 0, 255, 128);
    rect(x, y, w, h);
  }
}
