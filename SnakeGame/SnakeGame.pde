int r,g,b;       //snake
int gR,gG,gB;    //grid
int fR,fG,fB;    //frame
int[] aR,aG,aB;  //apple
int appleLayers;

SnakeGrid grid;
int frame;
int blockLength;

boolean start;
boolean lost;

int lastTime;
int delay;

void setup()
{
  size(800,800);
  r=(int)random(100,255);
  g=(int)random(100,255);
  b=(int)random(100,255);
  
  gR=0;
  gG=0;
  gB=0;
  
  fR=(int)random(0,255);
  fG=(int)random(0,255);
  fB=(int)random(0,255);
  
  appleLayers=5;
  aR= new int[appleLayers];
  aG= new int[appleLayers];
  aB= new int[appleLayers];
  aR[0]=(int)random(120,255);
  aG[0]=(int)random(120,255);
  aB[0]=(int)random(120,255);
  aR[1]=aB[0];
  aG[1]=aR[0];
  aB[1]=aG[0];
  for(int i=2; i<appleLayers; i++){
    aR[i]=aR[i-1]-30;
    aG[i]=aG[i-1]-30;
    aB[i]=aB[i-1]-30;
  }
  
  background(fR,fG,fB);
  
  frame=30;
  blockLength=25;
  
  frame=5*round(frame/5.0);
  
  int w=width-frame*2;
  int h=height-frame*2;
  grid = new SnakeGrid(w/blockLength,h/blockLength,appleLayers);
  fill(gR,gG,gB);
  square(frame,frame,width-frame*2);
  int[] pos = getPositionOnSketch(grid.getSnakePos());
  fill(r,g,b);
  square(pos[0],pos[1],blockLength);
  drawApple();
  
  delay=50;
  
  lastTime=millis();
}
void draw(){
  if(millis()-lastTime<delay)
      return;
  lastTime=millis();
  int[] snakeInfo = new int[0];
  if(start) snakeInfo=grid.update();
  drawApple();
  for(int i=0; i<snakeInfo.length; i+=2){
    if(snakeInfo[i]==-1){ //lost
      background(r,g,b);
      return;
    }
    if(i<2) //drawing new block
      fill(r,g,b);
    if(i>1) //deleting last block
      fill(gR,gG,gB);
    int[] pos = getPositionOnSketch(snakeInfo[i],snakeInfo[i+1]);
    square(pos[0],pos[1],blockLength);
  }
}
void keyPressed(){
  start=true;
  switch(key){
    case 'w':
      grid.setSnakeDirection(0);
      break;
    case 's':
      grid.setSnakeDirection(1);
      break;
    case 'a':
      grid.setSnakeDirection(2);
      break;
    case 'd':
      grid.setSnakeDirection(3);
      break;
    case 'W':
      grid.setSnakeDirection(0);
      break;
    case 'S':
      grid.setSnakeDirection(1);
      break;
    case 'A':
      grid.setSnakeDirection(2);
      break;
    case 'D':
      grid.setSnakeDirection(3);
      break;
  }
  if(key == CODED)
      switch(keyCode){
        case UP:
          grid.setSnakeDirection(0);
          break;
        case DOWN:
          grid.setSnakeDirection(1);
          break;
        case LEFT:
          grid.setSnakeDirection(2);
          break;
        case RIGHT:
          grid.setSnakeDirection(3);
          break;      
      }
}
public int[] getPositionOnSketch(int[] xy){
  int x = frame+xy[0]*blockLength;
  int y = frame+xy[1]*blockLength;
  int[] pos = {x,y};
  return pos;
}
public int[] getPositionOnSketch(int a, int b){
  int[] xy = {a,b};
  return getPositionOnSketch(xy);
}
public void drawApple(){
  stroke(.1);
  int[] apple = getPositionOnSketch(grid.getApplePos());
  int layers = grid.getAppleDepth();
  int depth = blockLength/(appleLayers);
  for(int i=0; i<=layers && i<appleLayers; i++){
    fill(aR[i], aG[i], aB[i]);
    if(i==layers) fill(gR,gG,gB);
    if(layers==1){
      fill(aR[0],aG[0],aB[0]);
      square(apple[0],apple[1],depth*(appleLayers-i));
      i+=2;
      apple[0]+=depth;
      apple[1]+=depth;
      fill(gR,gG,gB);
    }
    square(apple[0],apple[1],depth*(appleLayers-i));
    apple[0]+=depth/2;
    apple[1]+=depth/2;
  }
  stroke(1);
}
