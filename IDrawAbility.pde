public interface IItemStyle
{
  public void setNewFillEnabled(boolean Enabled);
  public boolean getFillEnabled();
  public void setFillColor(color rgb);
  public color getFillColor();
  
  public void setNewStrokeEnabled(boolean Enabled);
  public boolean getStrokeEnabled();
  public void setStrokeColor(color rgb);
  public color getStrokeColor();
}

public class ItemStyleBase implements IItemStyle
{
  public ItemStyleBase()
  {
  }
  
  public void setNewFillEnabled(boolean Enabled)
  {
    _fillEnabled = Enabled;
  }
  
  public boolean getFillEnabled()
  {
    return _fillEnabled;
  }
  
  public void setFillColor(color rgb)
  {
    _fillColor = rgb;
  }
  
  public color getFillColor()
  {
    return _fillColor;
  }
  
  public void setNewStrokeEnabled(boolean Enabled)
  {
    _strokeEnabled = Enabled;
  }
  
  public boolean getStrokeEnabled()
  {
    return _strokeEnabled;
  }
  
  public void setStrokeColor(color rgb)
  {
    _strokeColor = rgb;
  }
  
  public color getStrokeColor()
  {
    return _strokeColor;
  }
  
  private boolean _fillEnabled = false;
  private color _fillColor = color(255,255,255);
  private boolean _strokeEnabled = true;
  private color _strokeColor = color(0,0,0);
}

public interface IGuiItem
{
  public void setLocation(PVector loc);
  public PVector location();
  public void setSize(PVector size);
  public PVector size();
  
  public void prepareContext();
  public void draw();
  
  public void setStyle(IItemStyle style);
  public IItemStyle getStyle();
  public IItemStyle setRandomStyle();
}

public class GuiItemBase implements IGuiItem
{
  public GuiItemBase()
  {
    _loc = new PVector();
    _size = new PVector();
  }
  
  public void setLocation(PVector loc)
  {
    _loc.set(loc.x, loc.y);
  }
  
  public PVector location()
  {
    return _loc;
  }
  
  public void setSize(PVector size)
  {
    _size.set(size.x, size.y);
  }
  
  public PVector size()
  {
    return _size;
  }
  
  public void prepareContext()
  {
    IItemStyle style = getStyle();
    if (style != null)
    {
      if (style.getFillEnabled())
      {
        fill(style.getFillColor());
      }
      else
      {
        noFill();
      }
      
      if (style.getStrokeEnabled())
      {
        stroke(style.getStrokeColor());
      }
      else
      {
        noStroke();
      }
    }
  }
  
  public void draw()
  {
    prepareContext();
  }
  
  public void setStyle(IItemStyle style)
  {
    _style = style;
  }
  
  public IItemStyle getStyle()
  {
    return _style;
  }
  
  public IItemStyle setRandomStyle()
  {
    IItemStyle style = new ItemStyleBase();
    style.setNewFillEnabled(random(0,2)<1);
    style.setNewStrokeEnabled(random(0,2)<1);
    //color _color = color(int(random(256)),int(random(256)),int(random(256)));
    //println("color's rgb is", red(_color), green(_color), blue(_color));
    style.setFillColor(color(int(random(256)),int(random(256)),int(random(256))));
    style.setStrokeColor(color(int(random(0,256)),int(random(0,256)),int(random(0,256))));
    setStyle(style);
    return style;
  }
  
  private PVector _loc;
  private PVector _size;
  private IItemStyle _style;
}

class RectItem extends GuiItemBase
{
  public RectItem(float x, float y, float width, float height)
  {
    setLocation(new PVector(x, y));
    setSize(new PVector(width, height));
  }
  
  public void draw()
  {
    prepareContext();
    
    PVector loc = location();
    PVector size = size();
    rect(loc.x, loc.y, size.x ,size.y);
  }
}

class EllipseItem extends RectItem
{
  public EllipseItem(float x, float y, float width, float height)
  {
    super(x, y, width, height);
  }
  
  public void draw()
  {
    prepareContext();
    
    PVector loc = location();
    PVector size = size();
    ellipse(loc.x, loc.y, size.x, size.y);
  }
}

class PointItem extends RectItem
{
  public PointItem(float x, float y)
  {
    super(x, y, 1, 1);
  }
  
  public void draw()
  {
    prepareContext();
    
    PVector loc = location();
    point(loc.x, loc.y);
  }
}

////////////////////////////////////// model //////////////////////////////////

public interface INodeContent
{
}

public interface INodePainter
{
  public void setContent(INodeContent content);
  public INodeContent getContent();
  public void paint();
  
  public PVector getOrigin();
  public PVector getSize();
  public void setOrigin(float x, float y);
  public void setSize(float w, float h);
}

public interface INode
{
  public String name();
  public void setContent(INodeContent content);
  public void setPainter(INodePainter painter);
  public INodePainter getPainter();
  public void draw();
}

//// model impl ////
public class BaseNode implements INode
{
  public BaseNode(String name)
  {
    _name = name;
  }
  
  //~ Begin INode
  public String name()
  {
    return _name;
  }
  
  public void setContent(INodeContent content)
  {
    _content = content;
  }
  
  public void setPainter(INodePainter painter)
  {
    _painter = painter;
  }
  
  public INodePainter getPainter()
  {
    return _painter;
  }
  
  public void draw()
  {
    if (_painter != null)
    {
      _painter.paint();
    }
  }
  //~ End INode
  
  private String _name;
  private INodeContent _content;
  private INodePainter _painter;
}

public class NodeList extends ArrayList<INode>
{
}

public class BasePainter implements INodePainter
{
  public BasePainter(float x, float y, float w, float h)
  {
    _origin = new PVector(x, y);
    _size = new PVector(w, h);
  }
  
  public void setContent(INodeContent content)
  {
    _content = content;
  }
  
  public INodeContent getContent()
  {
    return _content;
  }
  
  public void paint()
  {
  }
  
  public PVector getOrigin()
  {
    return _origin;
  }
  public PVector getSize()
  {
    return _size;
  }
  public void setOrigin(float x, float y)
  {
    _origin.x = x;
    _origin.y = y;
  }
  public void setSize(float w, float h)
  {
    _size.x = w;
    _size.y = h;
  }
  
  private INodeContent _content;
  private PVector _origin;
  private PVector _size;
}

////// a class content begin ///////
public class ClassContent implements INodeContent
{
  public ClassContent(String name, String[] properties, String[] functions)
  {
    _className = name;
    _properties = new String[properties.length];
    _functions = new String[functions.length];
    
    arrayCopy(properties, _properties);
    arrayCopy(functions, _functions);
  }
  
  public String _className;
  public String[] _properties;
  public String[] _functions;
}

public class ClassPainter_01 extends BasePainter
{
  public ClassPainter_01(float x, float y, float w, float h)
  {
    super(x, y, w, h);
  }
  
  public PVector getSize()
  {
    ClassContent content = (ClassContent)getContent();
    if (content != null)
    {
      float max_width = 1;
      
      float cw = textWidth(content._className);
      max_width = max(cw, max_width);
      
      for(String p : content._properties)
      {
        cw = textWidth(p);
        max_width = max(cw, max_width);
      }
      
      for(String f : content._functions)
      {
        cw = textWidth(f);
        max_width = max(cw, max_width);
      }
      
      setSize(max_width+20, 20);
      return super.getSize();
    }
    else
    {
      return super.getSize();
    }
  }
  
  public void paint()
  {
    ClassContent content = (ClassContent)getContent();
    if (content != null)
    {
      pushMatrix();
      PVector origin = getOrigin();
      translate(origin.x, origin.y);
      
      PVector size = getSize();
      float w = size.x;
      float line_height = 30;
      float n_y = 0;
      float p_y = line_height;
      float f_y = p_y + 30*content._properties.length;
      float h = n_y + 20;
      IItemStyle textStyle = new ItemStyleBase();
      
      RectItem nameRegion = new RectItem(0,n_y, w,line_height);
      //nameRegion.setRandomStyle();
      nameRegion.setStyle(textStyle);
      nameRegion.draw();
      
      fill(0,0,0);
      text(content._className, 10, h);
      
      if (content._properties != null)
      {
        RectItem propertyRegion = new RectItem(0,p_y, w,f_y-p_y);
        //propertyRegion.setRandomStyle();
        propertyRegion.setStyle(textStyle);
        propertyRegion.draw();
        
        fill(0,0,0);
        h = p_y+20;
        for(String p : content._properties)
        {
          text(p, 10, h);
          h+=20;
        }
      }
      
      if (content._functions != null)
      {
        RectItem functionRegion = new RectItem(0,f_y, w,line_height*content._functions.length);
        //functionRegion.setRandomStyle();
        functionRegion.setStyle(textStyle);
        functionRegion.draw();
        
        fill(0,0,0);
        h = f_y+20;
        for(String f : content._functions)
        {
          text(f, 10, h);
          h+=20;
        }
      }
      
      popMatrix();
    }
  }
}
////// a class content end ///////

///////////////////////////////////////////////

NodeList globalNodes;

void setup()
{
  size(1600, 1200);
  surface.setResizable(true);
  randomSeed(0);
  
  globalNodes = new NodeList();
  
  String[] properties = {"length: int", "size: int"};
  String[] functions = {"void reset()"};
  INodeContent c1 = new ClassContent("FArray",properties,functions);
  INodePainter p1 = new ClassPainter_01(512,512,800,600);
  p1.setContent(c1);
  
  INode n1 = new BaseNode("Node_1");
  n1.setContent(c1);
  n1.setPainter(p1);
  globalNodes.add(n1);
}

void draw() 
{
  for(INode n : globalNodes)
  {
    n.draw();
  }
  
  if (mousePressed)
  {
    //fill(0);
  }
  else
  {
    //fill(255);
  }
}

void mouseDragged() 
{    
  PointItem item = new PointItem(mouseX, mouseY);
  item.setRandomStyle();
  item.draw();
}

void mouseMoved() {
  float t = random(10);
  if (t <= 5.0)
  {
    EllipseItem item = new EllipseItem(mouseX, mouseY, random(20,40), random(20, 4));
    //IItemStyle style = item.setRandomStyle();
    //println("style's FillMode=",style.getFillEnabled(), "StrokeMode=", style.getStrokeEnabled());
    item.draw();
  }
  else
  {
    RectItem item = new RectItem(mouseX, mouseY, random(20, 40), random(20, 40));
    item.setRandomStyle();
    item.draw();
  }
}
