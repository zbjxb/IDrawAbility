///////////////////// Init section /////////////////////
NodeList globalNodes = new NodeList();
IMouseEventProcessor globalMouseProcessor = new MouseEventProcessor();


///////////////////// main logic ///////////////////////

void setup()
{
  size(1366, 768);
  surface.setResizable(true);
  randomSeed(0);
  
  //createGUI();
  
  String[] properties = {"length: int", "size: int"};
  String[] functions = {"void reset()"};
  INodeContent c1 = new ClassContent("FArray",properties,functions);
  INodePainter p1 = new ClassPainter_01(512,512,800,600);
  p1.setContent(c1);
  
  INodePainter p2 = new ClassPainter_01(128,128,800,600);
  p2.setContent(c1);
  
  INode n1 = new BaseNode("Node_1");
  n1.setContent(c1);
  n1.setPainter(p1);
  globalNodes.add(n1);
  
  INode n2 = new BaseNode("Node_2");
  n2.setContent(c1);
  n2.setPainter(p2);
  globalNodes.add(n2);
}

void update()
{
  globalMouseProcessor.process();
}

void draw() 
{
  background(255,255,255);
  update();
  
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
}

void mouseMoved() {
}
