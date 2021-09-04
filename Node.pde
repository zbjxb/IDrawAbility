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
