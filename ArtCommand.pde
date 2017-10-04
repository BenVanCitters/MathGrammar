class ArtCommand extends CommandObj
{
  void doTheBiz()
  {}
}

class EllipseCommad extends ArtCommand
{
  MathCommand x,y,w,h;

  public EllipseCommad(MathCommand _x, MathCommand _y, 
                       MathCommand _w, MathCommand _h)
  {
    x = _x; y = _y;
    w = _w; h = _h;
    children.add(x);
    children.add(y);
    children.add(w);
    children.add(h);
  }
  
  public EllipseCommad()
  {
    x = new FloatCommand(0,width);
    y = new FloatCommand(0,height);
    w = new FloatCommand(0,50);
    h = new FloatCommand(0,50);
    children.add(x);
    children.add(y);
    children.add(w);
    children.add(h);
  }  
  void doTheBiz()
  { 
    ellipse((Float)x.compute(),
            (Float)y.compute(),
            (Float)w.compute(),
            (Float)h.compute());
  }
}

class RectangleCommad extends ArtCommand
{
  MathCommand x,y,w,h;
  public RectangleCommad(FloatCommand _x, FloatCommand _y, 
                       FloatCommand _w, FloatCommand _h)
  {
    x = _x; y = _y;
    w = _w; h = _h;
    children.add(x);
    children.add(y);
    children.add(w);
    children.add(h);
  }
  public RectangleCommad()
  {
    x = new FloatCommand(0,width);
    y = new FloatCommand(0,height);
    w = new FloatCommand(0,50);
    h = new FloatCommand(0,50);
    children.add(x);
    children.add(y);
    children.add(w);
    children.add(h);
  }  
  void doTheBiz()
  { 
    rect((Float)x.compute(),
         (Float)y.compute(),
         (Float)w.compute(),
         (Float)h.compute());
  }
}

class Translate2DCommand extends ArtCommand
{
  MathCommand x,y;

  public Translate2DCommand()
  {
    x = new FloatCommand(0,width);
    y = new FloatCommand(0,height);
    children.add(x);
    children.add(y);
  }  
  void doTheBiz()
  { 
    translate((Float)x.compute(),
              (Float)y.compute());
  }
}

class Rotate2DCommad extends ArtCommand
{
  MathCommand angle;

  public Rotate2DCommad()
  {
    angle = new FloatCommand(0,TWO_PI);

    children.add(angle);
  }  
  void doTheBiz()
  { 
    rotate((Float)angle.compute());
  }
}
