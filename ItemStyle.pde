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
