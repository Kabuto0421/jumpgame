int x =100;
int y;
int dx = 10;
int judge = 0;
int count = 0;
int charaCount = 0;
int rectY;
int chara = 1;
int colorCount = 0;
int scene = 0;
int buttonX = 450;
int buttonY = 200;
int buttonWidth = 300;
int buttonHeight = 80;//
int downTime = 0;//ダウンしてる時間を測る
int score = 0;
int highScore = 0;
float gravity = 0.5; // 重力を追加
float velocity = 0; // キャラクターの速度を追加
float jumpPower = 15; // ジャンプ力を追加
boolean isJumping = false; // ジャンプ状態を追加
boolean isDown = false;//ダウン状態を追加

PImage[] img = new PImage[12];
PImage charaImg;
PImage enemy;
PImage background;
void setup() {
  size(900, 600);
  y =height/2+100;
  rectY = height/2-200;
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  blendMode(BLEND);
  img[0] = loadImage("chara1.png");
  img[1] = loadImage("chara2.png");
  img[2] = loadImage("chara3.png");
  img[3] = loadImage("chara4.png");
  img[4] = loadImage("chara5.png");
  img[5] = loadImage("chara6.png");
  img[6] = loadImage("Jump.png");
  img[7] = loadImage("downChara1.png");
  img[8] = loadImage("downChara2.png");
  img[9] = loadImage("downChara3.png");
  img[10] = loadImage("downChara4.png");
  img[11] = loadImage("downChara5.png");
  enemy = loadImage("spike.png");
  background= loadImage("backgroundRoad.jpeg");
  background.resize(1280, 600);
  imageMode(CENTER);
  rectMode(CENTER);
  charaImg = img[0];
  for (int i =0; i<12; i++) {
    img[i].resize(100, 120);
  }
  enemy.resize(100, 100);
}
int enemyX = width; // 敵の初期位置を画面の右端に設定
float enemySpeed = 5; // 敵の速度を設定

void draw() {
  switch(scene) {
  case 0:
  y = height/2+100;
    image(background, width/2, height/2);
    pushMatrix();
    translate(width/2, height/2);
    scale(-1, 1);
    image(charaImg, 0, y-height/2);
    popMatrix();
    // ボタンを描画します。
    drawButton();
    break;
  case 1:
  textSize(100);
    gameScreen();
    textSize(48);
    text("score:"+score,800,35);
    break;
  case 2:
  image(background, width/2, height/2);
    pushMatrix();
    translate(width/2, height/2);
    scale(-1, 1);
    image(charaImg, 0, y-height/2);
    popMatrix();
    fill(0,100);
    rect(width/2,height/2,width,height);
    fill(255);
    down();
    break;
    case 3:
    displayGameOverScreen();
    break;
  }
}

void animation() {
  charaCount++;
  if (chara<5) {
    if (charaCount % 6 == 0) {
      chara++;
    }
  } else {
    chara = 1;
  }
  charaImg = img[chara];
}

void judgeFunction() {
  switch(judge) {
  case 0:
    animation();
    float targetPosition = 450; // ターゲットの位置（x座標が425と475の中間）
    float distance = abs(enemyX - targetPosition); // 現在の位置とターゲットの位置との距離
    enemySpeed = map(distance, 0, width, 1, 10); // 距離に基づいて速度を調整
    if (enemyX < -30) {
      enemyX = width;
    }
    x +=dx;
    break;
  case 1:
    countCheck("BAD");
    break;
  case 2:
    countCheck("GOOD");
    break;
  case 3:
    countCheck("EXCELLENT");
    jump();
    break;
  case 4:
    countCheck("Oops!!");
    scene = 2;
    break;
  default:
    exit();
    break;
  }
}


void jump() {
  if (!isJumping) { // ジャンプ開始
    velocity = -jumpPower;
    isJumping = true;
  }
  if (isJumping && count <= 89) { // ジャンプ中
    velocity += gravity;
    y += velocity;
  }
  if (count >= 89) { // ジャンプ終了
    isJumping = false;
    if (judge != 4) {
      y = height/2+100; // キャラクターを地面に戻す
    }
    if(!isDown){
      score += 100;
    }
  }
}

void down() {
  downTime++;
  if (!isDown) {
    isDown = true;
  }
  if (isDown && downTime <=60) {
    charaImg = img[7];
    charaCount = 7;
  }
  if (downTime >60 && downTime<=150) {
    jump();
    if (downTime % 6 == 0) {
      if (charaCount <11) {
        charaCount++;
      } else {
        charaCount = 8;
      }
    }
    charaImg = img[charaCount];
  }
  if(downTime >150){
    count = 0;
    isJumping = false;
    downTime = 0;
    isDown = false;
    scene = 3;
    charaImg = img[0];
  }
}

void countCheck(String name) {
  colorCount+=3;
  enemySpeed = 5;
  count++;
  if (count >= 1) {
    fill(255);
    textSize(100);
    text(name, width/2, height/2-100);
  }
  if (count >= 90) {
    if (judge != 4) {
      judge = 0;
    }
    count = 0;
    enemyX = width;
  }
}

void mousePressed() {
  if (scene == 1) {
    if ((x>= 50 && x<300)||(x<=850 && x>=600)) {
      judge = 1;
    }
    if ((x>=300 && x < 425) || (x>=475&&x<600)) {
      judge = 2;
    }
    if (x>=425 && x< 475) {
      charaImg = img[6];
      judge = 3;
    }
  }  if (scene == 3) {
    gameInit();
  }
}
void displayGameOverScreen() {
  background(0); // 画面を黒に設定します。
  fill(255); // テキストの色を白に設定します。
  textSize(50); // テキストのサイズを設定します。
  if(score > highScore){
    highScore = score;
  }
  text("Game Over", width/2, height/2); // "Game Over"というテキストを画面の中央に表示します。
  text("Your Score:"+score,width/2,height/2+100);
  text("High Score:"+highScore,width/2,height/2+150);
}
void gameInit() {
  score = 0;
  colorCount = 0;
  scene = 0;
  judge = 0;
  count = 0;
  enemyX = width;
}
