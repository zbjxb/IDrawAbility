NodeList globalNodes;

void setup()
{
  size(1600, 1200);
  surface.setResizable(true);
  randomSeed(0);
  
  //createGUI();
  
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
}

void mouseMoved() {
}
