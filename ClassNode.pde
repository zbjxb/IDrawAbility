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
  private float _line_height = 30;
  
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
      
      setSize(max_width+20, _line_height*(1+content._properties.length+content._functions.length));
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
      float line_height = _line_height;
      float n_y = 0;
      float p_y = line_height;
      float f_y = p_y + line_height*content._properties.length;
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
      
      noFill();
      
      popMatrix();
    }
  }
}
