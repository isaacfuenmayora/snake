import java.util.LinkedList;

class Snake{
  private int xLength, yLength;
  private int tailX, tailY, headX, headY;
  private boolean walls;
  private int snakeLength;
  private int direction;  // Up: 0, Down: 1, Left: 2, Right: 3
  private int timer;      // determines how long is left until the snake stops increasing
  private LinkedList<Integer> dirs;
  public Snake(int xLength,int yLength){
    this.xLength=xLength;
    this.yLength=yLength;
    walls=true;
    snakeLength=1;
    headX=(int)random(1,xLength-2);
    headY=(int)random(1,xLength-2);
    tailX=headX;
    tailY=headY;
    dirs = new LinkedList<Integer>();
  }
  public int getX(){return headX;}
  public int getY(){return headY;}
  public int getTailX(){return tailX;}
  public int getTailY(){return tailY;}
  public int getLength(){return snakeLength;}
  public void setDirection(int dir){
    if(dirs.size()>0 && snakeLength>1 && (dirs.getLast()+dir<2 || dirs.getLast()+dir>4))
      return;
    direction=dir;
  }
  /** moves the snake, returns {-1} if it is not a valid move, {-2} if got apple, {-3} if still growing, otherwise returns the position left in the dust **/
  public int[] move(boolean[][] grid, int[] apple){
     int dx=0, dy=0;
     if(direction<2) dy=1;
     else dx=1;
     if(direction%2==0){
       dx=-dx;
       dy=-dy;
     }
     int newX = headX+dx;
     int newY = headY+dy;
     if(newX<0 || newX>=xLength || newY<0 || newY>=yLength || grid[newY][newX]){
       int[] nope = {-1};
       return nope; 
     }
     headX=newX;
     headY=newY;
     dirs.add(direction);
     if(newX==apple[0] && newY==apple[1]){
       int[] yup = {-2};
       snakeLength++;
       timer=max(0,timer+apple[2]-1);
       return yup;
     }
     if(timer>0){
       int[] growing = {-3};
       timer--;
       return growing;
     }
     int[] dust = {tailX,tailY};
     int dir = dirs.poll();
     dx=0; dy=0;
     if(dir<2) dy=1;
     else dx=1;
     if(dir%2==0){
       dx=-dx;
       dy=-dy;
     }
     tailX+=dx;
     tailY+=dy;
     return dust;
  }
}
