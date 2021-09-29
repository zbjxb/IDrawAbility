public interface IMouseEventHandler
{
  public void selectCallback();
  public void onMouseEnter();
  public void onMouseHover();
  public void onMouseDragged();
  public void onMouseLeave();
}

public interface IMouseEventProcessor
{
  public void registerMouseEventHandler(IMouseEventHandler handler);
  public void process();
}


////////////// impl ////////////////////

public class MouseEventProcessor implements IMouseEventProcessor
{
  public ArrayList<IMouseEventHandler> _handles;
  
  public  MouseEventProcessor()
  {
    _handles = new ArrayList<IMouseEventHandler>();
  }
  
  public void registerMouseEventHandler(IMouseEventHandler handler)
  {
    if (!_handles.contains(handler))
    {
      _handles.add(handler); //<>//
    }
  }
  
  public void process()
  {
    for(IMouseEventHandler h : _handles)
    {
      if (h != null)
      {
        h.selectCallback();
      }
    }
  }
}

public class MouseEventHandlerCore implements IMouseEventHandler
{
  private INodePainter _painter;
  private boolean _bInner = false;
  private PVector _lastPos = new PVector();
  
  public MouseEventHandlerCore(INodePainter painter)
  {
    _painter = painter;
    globalMouseProcessor.registerMouseEventHandler(_painter);
  }
  
  public void selectCallback()
  {
    if (_painter != null)
    {
      PVector mouse = new PVector(mouseX, mouseY);
      
      PVector top_left = _painter.getOrigin();
      PVector bottom_right = PVector.add(top_left, _painter.getSize());

      if (mouseX > top_left.x && mouseX < bottom_right.x
      && mouseY > top_left.y && mouseY < bottom_right.y)
      {
        if (!_bInner)
        {
          _bInner = true;
          _lastPos.x = mouseX;
          _lastPos.y = mouseY;
          onMouseEnter();
          //print("onMouseEnter called\n");
        }
        else
        {
          PVector delta = PVector.sub(_lastPos, mouse);
          if (abs(delta.x) < 0.000001 && abs(delta.y) < 0.000001)
          {
            // do nothing
          }
          else
          {
            if (!mousePressed)
            {
              onMouseHover();
              //print("onMouseHover called\n");
            }
            else
            {
              onMouseDragged();
              //print("onMouseDragged called\n");
            }
          }
        }
      }
      else
      {
        if (_bInner)
        {
          _bInner = false;
          onMouseLeave();
          //print("onMouseLeave called\n");
        }
        else
        {
          // do nothing
        }
      }
    }
  }
  
  public void onMouseEnter()
  {
    if (_painter != null)
    {
      _painter.onMouseEnter();
    }
  }
  
  public void onMouseHover()
  {
    if (_painter != null)
    {
      _painter.onMouseHover();
    }
  }
  
  public void onMouseDragged()
  {
    if (_painter != null)
    {
      _painter.onMouseDragged();
    }
  }
  
  public void onMouseLeave()
  {
    if (_painter != null)
    {
      _painter.onMouseLeave();
    }
  }
}
