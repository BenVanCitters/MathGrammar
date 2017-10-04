EllipseCommad e;// = new EllipseCommad();
MathCommand m;
void setup()
{
  size(500,500);
// e = new EllipseCommad(getMathCommand(0),
//   getMathCommand(0),
//   getMathCommand(0),
//   getMathCommand(0));
  m = getMathCommand(0);
}
float[] minMax = {9999999,-9999999};
void draw()
{
//  e.doTheBiz();
  
  float val = (Float)m.compute();
  minMax[0] = min(val,minMax[0]);
  minMax[1] = max(val,minMax[1]);
  float spread = minMax[1]-minMax[0];
  float norm = (val-minMax[0])/spread;
  pushStyle();
  fill(0,0,0,10);
  noStroke();
  rect(0,0,width,height);
  popStyle();
  
  float t = (millis()/100.f);
  pushStyle();
  fill(255); stroke(255);
  ellipse(t%width,(1-norm)*height,10,10);
  popStyle();
  String eval = ("eval: " + val );
  pushStyle();
  fill(0,0,100);
  rect(0,0,150,50);
  fill(255);
  text(eval,30,30);
  popStyle();
  
  println("======================");
  m.printMe();   
  m.checkValidMath();
}
