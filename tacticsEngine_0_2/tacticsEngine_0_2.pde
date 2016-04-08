int filas = 10;
int columnas = 10;
//define el radio del cursor.
int radius = 10;

//Tipos de unidades
int king = 1;
int knight = 2;

//int a = int(random(columnas));
//int b = int(random(filas));

//Inicializa matriz de datos, batallón y motor gráfico.
int [][] matriz = new int[filas][columnas];
Batallion bravo = new Batallion();
Board campo = new Board();

void setup(){
size(600,600);
//background(255);

setMatrix();
printMatrix();
  
}

void draw(){
  background(200);
  printTiles();
  printCursor();
  
  //detecta ubicación ocupada por unidad
  if( !bravo.isEmpty( mouseX/20, mouseY/20 )){ 
    ellipse(300,300,20,20);
  }
  
  //Indica posición en consola:
  //print("pos_x: "+mouseX/20+" "+"pos_y: "+mouseY/20+" ");
}


void mouseClicked(){
  
  //Distingue unidad y reacciona al hacer click
  //Se supone que al hacer click en la unidad 
  //será posible elegirla de manera unívoca 
  //y desplegar su rango de movimiento
  
  if( !bravo.isEmpty( mouseX/20, mouseY/20 )){ 
    for (int j = 0; j < columnas; j++){
      for (int i = 0; i < filas; i++){
          switch(bravo.locateUnit(i,j)){
        case 1:
          fill(255,0,0);
          ellipse(300,300,20,20);
          break;
        case 2:
          fill(0,255,255);
          ellipse(300,300,20,20);
          break;
          }
      }
    }
  }
}

//Funciones. O no se como pictes se llamen.


void setMatrix(){
  for (int j = 0; j < columnas; j++){
    for (int i = 0; i < filas; i++){
      matriz[i][j] = 0;
    }
  }
}

//Imprime la matriz de datos
//Se empleará posteriormente para 
//actualizar posiciones de las unidades

void printMatrix(){
  for (int j = 0; j < columnas; j++){
    print("\n");
    for (int i = 0; i < filas; i++){
      
      switch(bravo.locateUnit(i,j)){
        case 1:
          matriz[i][j] = king;
          break;
        case 2:
          matriz[i][j] = knight;
          break;
      }
      print(matriz[i][j]+" ");
      
    }
  }
}


//Dibuja el tablero de juego
//Distingue si hay una unidad en un cuadro, 
//de que tipo, o bien, si está vacío.

void printTiles(){
  for (int j = 0; j < columnas; j++){
    for (int i = 0; i < filas; i++){
      Block B = new Block((i*20),(20*j),20,20); // Block(x_i, y_i, w, h)
      switch(matriz[i][j]){
        case 0:
        stroke(0);
        fill(0,255,0);
        B.drawBlock();
        break;
      case 1:
        stroke(0);
        fill(255,0,0);
        B.drawBlock();
        break; 
      case 2:
        stroke(0);
        fill(0,255,255);
        B.drawBlock();
        break;
      } 
      
    }
  }
}

//Imprime el cursor en pantalla
void printCursor(){
  fill(0,0,250);
  ellipse(mouseX, mouseY, radius, radius);
}

//Clases. Del cha cha chá.

class Unit{
  int ccol;
  int crow;
  int ctype;
  boolean alive = true;
  boolean cside; 
  
  //propiedades de la unidad: Posición (x,y)=(col,row), Tipo y Bando)
  //quizá se necesite agregar un isActive para elegir unidades de manera unívoca.
  Unit(int col,int row,int type,boolean side) { 
  ccol = col;
  crow = row;
  ctype = type;
  cside = side; 
  }
  
   int getRow(){
   return(crow);
 }

 int getColumn(){ 
   return(ccol); 
 }

 int getType(){ 
   return(ctype); 
 }

 boolean getSide(){
   return(cside);
 }

 void setColumn(int col){ 
   if( alive ){
     ccol = col;
   }
 }

 void setRow(int row){ 
   if( alive ){
     crow = row;
   }
 }

 void setType(int type){ 
   if( alive ){
     ctype = type; 
   }
 }

 void kill(){
   alive = false;
   crow = -1;
   ccol = -1;
   ctype = 0;
 }
}


//Esta clase construye un batallón a partir de la clase Unit.

class Batallion{
  
  Unit[] units;
  
  //Batallón para 1v1
  Batallion(){
  units = new Unit[2];
  units[0] = new Unit( 0, 7, king, true );
  units[1] = new Unit( 2, 6, knight, true );
  }
  
  /* - Batallón para 4v4
  Batallion(){
  units = new Unit[8];
  units[0] = new Unit( 0, 7, 1, true );
  units[1] = new Unit( 2, 6, 1, true );
  units[2] = new Unit( 4, 7, 1, true );
  units[3] = new Unit( 6, 6, 1, true );
  units[4] = new Unit( 0, 2, 1, false );
  units[5] = new Unit( 2, 1, 1, false );
  units[6] = new Unit( 4, 2, 1, false );
  units[7] = new Unit( 6, 1, 1, false );
  }
  */
  
  //Determina si hay una unidad en la posición (col,row) y si la hay, regresa que unidad es.
  int locateUnit(int col, int row){
    for( int i = 0; i< units.length; i++) {
     if ( ( units[i].getColumn() == col ) && ( units[i].getRow() == row ) ) {
       return( units[i].getType() );
     }
   }
   return(0);
  }
  //Detecta el bando de la unidad
   boolean locateUnitSide(int col, int row ){
   if( !isEmpty( col, row ) ) {
     for( int i = 0; i< units.length; i++) {
       if ( ( units[i].getColumn() == col ) && ( units[i].getRow() == row ) ) {
         return( units[i].getSide() );
       }
     }
   }
   return(false);
  }
  
  //Detecta si el espacio está vacío
   boolean isEmpty(int col, int row ){
   return( locateUnit(col, row) == 0 );
 }
}

//Esta clase dibuja un bloque a partir de las posiciones
//de la matriz de datos.
class Block{
  
  float x;
  float y;
  float w;
  float h;
  
  Block(){
    
  float x=10;
  float y=10;
  float w=20;
  float h=20;
  }

  Block(float x, float y, float w,float h){
  this.x=x;
  this.y=y;
  this.w=w;
  this.h=h;
  }
  
  Block(Block O){
    this.x = O.x;
    this.y = O.y;
    this.w = O.w;
    this.h = O.h;
  }
  
void drawBlock(){
    rect(x,y,w,h);
}  

int getPosx(){
  return int(x);
}
int getPosy(){
  return int(y);
}

void setPosx(int x){
  this.x = x;
}

void setPosy(int y){
  this.y = y;
}

}

//Así como Batallion es una clase que genera un batallón a partir de unidades,
//la clase Board genera todo el tablero a partir de lozetas definidas por la clase Block 
class Board{
  
  Block[][] tiles;
    
  Board(){
  tiles = new Block[filas][columnas];
  }

}