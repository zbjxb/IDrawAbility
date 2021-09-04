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
