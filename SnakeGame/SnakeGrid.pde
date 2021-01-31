class SnakeGrid{
  private boolean[][] grid;
  private Snake snake;
  private int[] apple; //{x,y,blocksAdded,timer}
  public SnakeGrid(int xLength,int yLength, int appleLayers){
    grid = new boolean[yLength][xLength];
    snake = new Snake(xLength, yLength);
    grid[snake.getY()][snake.getX()]=true;
    apple = new int[4];
    apple[0]=(int)random(1,xLength-2);
    apple[1]=(int)random(1,yLength-2);
    while(grid[apple[1]][apple[0]]){
        apple[0]=(int)random(1,grid[0].length-2);
        apple[1]=(int)random(1,grid.length-2); 
    }
    apple[2]=appleLayers;
    apple[3]=snake.getX()+snake.getY()-apple[0]-apple[1];
  }
  public int[] getSnakePos(){
    int[] xy = {snake.getX(),snake.getY()};
    return xy;
  }
  public int[] getApplePos(){
    int[] appPos = {apple[0], apple[1]};
    return appPos;
  }
  public int getAppleDepth(){return apple[2];}
  /*returns {-1} if the game is lost,{x,y} if apple was found or if growing, {x1,y1,x2,y2} otherwise*/
  public int[] update(){
    if(apple[3]>1) apple[3]--;
    else if(apple[2]!=1){
      apple[2]--;
      apple[3]=12-apple[2]/3;
    }
    int[] dust = snake.move(grid,apple);
    if(dust.length==2){
      grid[dust[1]][dust[0]]=false;
    }
    if(dust[0]==-1) return dust;
    if(dust[0]<-1){
      if(dust[0]==-2){
        apple[0]=(int)random(0,grid[0].length-1);
        apple[1]=(int)random(0,grid.length-1); 
        while(grid[apple[1]][apple[0]]){
          apple[0]=(int)random(0,grid[0].length-1);
          apple[1]=(int)random(0,grid.length-1); 
        }
        apple[2]=appleLayers;
        apple[3]=snake.getX()+snake.getY()-apple[0]-apple[1];
      }
      int[] newPos = {snake.getX(),snake.getY()};
      grid[newPos[1]][newPos[0]]=true;
      return newPos;
    }
    int[] xyxy = {snake.getX(),snake.getY(),dust[0],dust[1]};
    grid[xyxy[1]][xyxy[0]]=true;
    return xyxy;
  }
  public void setSnakeDirection(int dir){snake.setDirection(dir);} // Up: 0, Down: 1, Left: 2, Right: 3
}
//abstract class Grid{ 
//  protected byte[][] grid;
//  public Grid(int xLength,int yLength){
//    grid = new byte[yLength][xLength];
//  }
//  public int[] getSnakePos(){
//    int[] xy = {snake.getX(),snake.getY()};
//    return xy;
//  }
//  public int[] getApplePos(){
//    int[] appPos = {apple[0], apple[1]};
//    return appPos;
//  }
//  public int getAppleDepth(){return apple[2];}
//  /*returns {-1} if the game is lost,{x,y} if apple was found or if growing, {x1,y1,x2,y2} otherwise*/
//  public int[] update(){
//    //decreases apple timer
//    if(apple[3]>1) apple[3]--;
//    //if timer reacher zero this move, remove a layer from the apple and reset timer
//    else if(apple[2]!=1){
//      apple[2]--;
//      apple[3]=12-apple[2]/3;
//    }
//    //get position of the place where the tail was
//    int[] dust = snake.move(grid,apple);
//    if(dust.length==2){
//      grid[dust[1]][dust[0]]=false;
//    }
//    //loss
//    if(dust[0]==-1) return dust;
//    //apple or growing
//    if(dust[0]<-1){
//      //if an apple was consumed, make a new one
//      if(dust[0]==-2){
//        //put an apple in a random place
//        apple[0]=(int)random(0,grid[0].length-1);
//        apple[1]=(int)random(0,grid.length-1); 
//        while(grid[apple[1]][apple[0]]){
//          apple[0]=(int)random(0,grid[0].length-1);
//          apple[1]=(int)random(0,grid.length-1); 
//        }
//        apple[2]=appleLayers;
//        apple[3]=snake.getX()+snake.getY()-apple[0]-apple[1];
//      }
//      //get the new head position, and update the grid
//      int[] newPos = {snake.getX(),snake.getY()};
//      grid[newPos[1]][newPos[0]]=true;
//      //return head pos
//      return newPos;
//    }
//    ////get the new head position, and update the grid
//    int[] xyxy = {snake.getX(),snake.getY(),dust[0],dust[1]};
//    grid[xyxy[1]][xyxy[0]]=true;
//    //return head pos and position of the previous tail
//    return xyxy;
//  }
//  public void setSnakeDirection(int dir){snake.setDirection(dir);} // Up: 0, Down: 1, Left: 2, Right: 3
//}
