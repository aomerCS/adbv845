class Platform
{
  float w, h, x, y, vx, direction;

  Platform(float _x, float _y, float _w, float _h, float _vx)
  {
    w = _w;
    h = _h;
    x = _x;
    y = _y;


    vx = _vx;

    direction = random(0, 2);

    // Decides which direction initial movement is in
    if (direction >= 0 && direction < 1)
    {
      vx *= -1;
    }
    if (direction >= 1 && direction < 2)
    {
      vx *= 1;
    }
  }

  void update()
  { 
    // Check if platform touches edges
    if (x > width - w)
    {
      vx *= -1;
    } else if (x < 0)
    {
      vx *= -1;
    }

    x += vx;
  }

  void display()
  {
    if (h < height)
    {
      fill(0,255,0,125);
      rect(x, y, w, h);
    }
  }
}
