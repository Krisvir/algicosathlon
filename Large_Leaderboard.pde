int[] start = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
int[] toadd = {11,3,6,25,17,27,19,4,23,1,9,16,26,24,14,2,12,10,15,4,21,7,8,13,29,20,28,22,30,18};
String[] names ={"Magenta","Purple","Tan","Orange","Lime","Red","Blue","Lavender","Yellow","Brown","Gray","Navy","Olive","Pink","Cyan","Green","Teal","White","Black","Maroon","Turquoise"
,"Mint","Rainbow","Krisvir Singh","Crisp","Pantone","Forest","Sky","Gold","Lemon"};
int[] waias = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29};
int[] waiae = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29};
boolean[] taken = {false,false,false,false,
false,false,false,false,false,false,false,false,
false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false};
int totalPlayers=30;
int timer, maxScore, x, y;
int[][] colors = {{255,0,255},{120,0,255},{210,180,140},{255,120,0},{0,255,0},{255,0,0},{0,120,255},{202,145,222},{255,255,0},{130,65,0},{120,120,120},
{0,30,145},{120,120,0},{255,100,255},{0,255,255},{0,145,0},{0,128,128},{255,255,255},{20,20,20},{128,0,0},{64,224,208},{60,100,600},{100,14,0},{80,50,20},{139,0,0},{165,42,42},{34,139,34},{135,206,235},{255,223,0},{100,97,0}};
String[] after = {"st","nd","rd","th","th","th",
"th","th","th","th","th","th","th","th","th","th","th","th","th","th","st","nd","rd","th","th","th","th","th","th","th"};
PFont font;
PFont font26;

int margin = 100;

//Change rectangle height and font size to adjust your view
int rectHeight = 30;
int fontSize = 30;

float perc = 0;

void setup(){
  font = loadFont("Verdana-48.vlw");
  font = loadFont("Verdana-BoldItalic-48.vlw");
  size(1280,1900);
  for(int i = 0; i < totalPlayers; i++){
    int record = 0;
    int recordHolder = 0;
    for(int j = totalPlayers-1; j >= 0; j--){
      if(start[j] >= record && !taken[j]){
        record = start[j];
        recordHolder = j;
      }
    }
    taken[recordHolder] = true;
    waias[recordHolder] = i;
  }
  for(int i = 0; i < totalPlayers; i++){
    taken[i] = false;
  }
  for(int i = 0; i < totalPlayers; i++){
    int record = 0;
    int recordHolder = 0;
    for(int j = totalPlayers-1; j >= 0; j--){
      if(start[j]+toadd[j] >= record && !taken[j]){
        record = start[j]+toadd[j];
        recordHolder = j;
      }
    }
    taken[recordHolder] = true;
    waiae[recordHolder] = i;
    if(i == 0) maxScore = record;
  }
  textFont(font,15);
  noStroke();
  frameRate(60);
}

void draw(){
  background(0);
  //fill(255);
  //text("1st", margin-93,100);
  if(timer < 1200){
    fill(80);
    rect(0,0,margin,1);
    timer++;
    textAlign(LEFT);
    fill(255);
    for(int i = 0; i < totalPlayers; i++){
      text((i+1)+after[i],margin-93,rectHeight+fontSize*i);
    }
    if(timer < 480){
      perc = max((float(timer)-180)/300,0);
    }else{
      perc = min(max((float(timer)-480)/300,0),1);
      perc = -cos(perc*PI)/2+0.5;
    }
    for(int j = 0; j < totalPlayers; j++){
      fill(colors[j][0],colors[j][1],colors[j][2]);
      if(timer < 480){
        x = int(1020*(start[j]+float(toadd[j])*perc)/maxScore);
        y = rectHeight*waias[j];
      }else{
        x = int(1020*(start[j]+toadd[j])/maxScore);
        y = int((waias[j]+(float(waiae[j])-float(waias[j]))*perc)*rectHeight);
      }
      //print("x= "+x +" and y = "+y);
      rect(margin,5+y,x,rectHeight);
      textAlign(LEFT);
      text(names[j],margin+x+5,rectHeight+y);
      fill(0);
      textAlign(RIGHT);
      if(timer < 480){
  text(addCommas(round((start[j]+toadd[j]*perc))),margin+x,rectHeight+y);
      }else{
        text(addCommas(start[j]+toadd[j]),margin+x,rectHeight+y);
      }
      if(waiae[j] >= totalPlayers){ 
        fill(255,25,0);
        textFont(font,fontSize+4);
        textAlign(LEFT);
        text("ELIMINATED",names[j].length()*20+130+x,rectHeight+2+y);
        textFont(font,fontSize);
      }
    }
    //saveFrame("images\\####.png");
  }
}

String addCommas(int n){
  String s = n+"";
  String output = "";
  for(int i = 0; i < s.length(); i++){
    if(i >= 1 && (s.length()-i)%3 == 0){
      output = output+",";
    }
    output = output+s.charAt(i);
  }
  return output;
}
