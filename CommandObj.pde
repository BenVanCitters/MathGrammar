class CommandObj<T>
{
  public ArrayList<CommandObj> children = new ArrayList<CommandObj>();
}

//"factory" method - passing depth allows 
MathCommand getMathCommand(int depth)
{
  println("getMathCommand: depth = " + depth);
  MathCommand m = null;
  //prevent super deep trees
  if( depth > 10)
  { m = new FloatCommand(-1,1); }
  else
  {
    //decide via a uniform random distribution between all math ops
    int r = (int)random(9);
    switch (r)
    {
      case 0: //add
        m = new AddCommand(depth);
        break;
      case 1: //mult
        m = new MultCommand(depth);
        break;      
      case 2: //sin
        m = new SinCommand(depth);
        break;
      case 3: //cos
        m = new CosCommand(depth);
        break;
      case 4: //time-based variable
        m = new TimeFloatCommand();
        break;     
      case 5:
        m = new DivideCommand(depth);
        break; 
      case 6: //pow x^y
        m = new PowCommand(depth);
        break;
      case 7: //logarithm
        m = new LogCommand(depth);
        break;
//      case 10: //val
//      case 8: //sqrt
//      case 9: //sub
      default: //float
        m = new FloatCommand(-1,1);
        break;    
    }
  }
  return m;
}

class MathCommand<Number> extends CommandObj
{
  int depth = 0;
  public MathCommand() {  }
  public MathCommand(int depth) { this.depth = depth; }
  
  
  //checks the equation to find any and all operations that result in:
  // NaN (div by zero or imaginary numbers)
  // (+/-)Infinity too big or small for variable 
  boolean checkValidMath()
  {  
    Float v = (Float)compute(); 
    boolean inValid = (v.equals(Float.NEGATIVE_INFINITY)) || (v.equals(Float.POSITIVE_INFINITY)) || (v.equals(Float.NaN)); 
    if( inValid ) 
    {  
      boolean goodChildren = true;
      //dive into children to find root of error
      for(int i = 0; i < children.size(); i++)
      {
        MathCommand m = (MathCommand)children.get(i);
        goodChildren = goodChildren & m.checkValidMath();        
      } 
      if(goodChildren)
      { println(this.getClass().getName() + " " + getStr() +  " evaluates NNNAAANNN"); } 
    } 
//    else { println(this.getClass().getName() +" VALID: " + v); }
    return !inValid;
  }
  
  public void printMe()
  { println( getStr() + " = " + compute()); }
  
  public String getStr()
  { return "BLANK MATH"; }
  
  //virtual
  Number compute()
  {  return null; }
}

// Two-variable operator parent class
class BinaryCommand<T> extends MathCommand<T>
{
  MathCommand A,B;
  public BinaryCommand(){this(0);}
  public BinaryCommand(int depth)
  {  super(depth); A = getMathCommand(this.depth+1); 
     B = getMathCommand(this.depth+1);  
     children.add(A);children.add(B); }
  //two arg command constructor 
  public BinaryCommand(MathCommand a, MathCommand b)
  {  A = a; B = b; children.add(a);children.add(b); }
}

//multiplication - binary operator - branch node
class MultCommand extends BinaryCommand<Float>
{
  public MultCommand(int depth) { super(depth);}
  Float compute()
  {  return (Float)A.compute() * (Float)B.compute(); }

  String getStr()
  { return A.getStr() + " * " + B.getStr(); }
}

//division - binary operator - branch node
class DivideCommand extends BinaryCommand<Float>
{
  public DivideCommand(int depth) { super(depth);}
  Float compute()
  {  
    return (Float)A.compute() / (Float)B.compute();
   }

  String getStr()
  { return A.getStr() + " / " + B.getStr(); }
}

//addition - binary operator - branch node
class AddCommand extends BinaryCommand<Float> 
{
  public AddCommand(int depth) { super(depth);}
  Float compute()
  {  
    return (Float)A.compute() + (Float)B.compute();
  }
  
  String getStr()
  { return "( " +  A.getStr() + " + " + B.getStr() + " )"; }
}

// Single variable operator parent class
class UnaryCommand<T> extends MathCommand<T>
{
  MathCommand mc;
  public UnaryCommand(int depth)
  {  super(depth); mc = getMathCommand(this.depth+1); children.add(mc);}
  public UnaryCommand(MathCommand c)
  {  mc = c;  children.add(c); }
}

//Sine
class SinCommand extends UnaryCommand<Float>
{
  public SinCommand(int depth) { super(depth);}
  Float compute()
  {  return sin((Float)mc.compute()); }
  String getStr()
  { return "sin( " + mc.getStr() + " )";  }
}

//the log command really needs a positive input to produce a completely real number...
class LogCommand extends UnaryCommand<Float>
{
  public LogCommand(int depth) { super(depth);}
  Float compute()
  {  return log((Float)mc.compute()); }
  String getStr()
  { return "log( " + mc.getStr() + " )";  }
}

//cosine
class CosCommand extends UnaryCommand<Float>
{
  public CosCommand(int depth) { super(depth);}
  Float compute()
  {  return cos((Float)mc.compute()); }
  String getStr()
  { return "cos( " + mc.getStr() + " )";  }
}

//power command - raises x to the power of y
class PowCommand extends BinaryCommand<Float>
{
  public PowCommand(int depth) { super(depth);}
  Float compute()
  {  return pow((Float)A.compute(),(Float)B.compute()); }
  String getStr()
  { return "pow( " + A.getStr() + ", " + B.getStr() + " )";  }
}

//Single precision constant floating point command - no children - leaf node in grammar tree
class FloatCommand extends MathCommand<Float>
{
  float val;
  public FloatCommand(float min, float max)
  { val = random(min,max); }
  
  Float compute()
  { return val; }
  
  String getStr()
  { return "" + val;   }
}

//sketch-time based command  - no children - leaf node in grammar tree
class TimeFloatCommand extends MathCommand<Float>
{
  public TimeFloatCommand() { }
  
  Float compute()
  { return millis()/1000.f; }
  
  String getStr()
  { return "t(" + compute() + ")"; }
}

//Constant Integer command  - no children - leaf node in grammar tree
class IntCommand extends MathCommand<Integer>
{
  int val;
  //random constructor
  public IntCommand(int min, int max)
  { val = (int)random(min,max); }
  
  Integer compute()
  { return val; }
  
  String getStr()
  { return "" + val; }
}
