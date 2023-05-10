void gameScreen(){
image(background, width/2, height/2);
  fill(0, 255, 0);
  rectMode(CENTER);
  rect(width/2, rectY, 800, 50);//緑
  fill(255, 255, 0);
  rect(width/2, rectY, 300, 50);//黄色
  fill(255, 0, 0);
  rect(width/2, rectY, 50, 50);//赤
  fill(255);
  pushMatrix();
  translate(width/2, height/2);
  scale(-1, 1);
  image(charaImg, 0, y-height/2);
  popMatrix();

  image(enemy, enemyX, height/2+150); // 敵の画像を表示

  float distanceBetweenCharacterAndEnemy = dist(width/2, y, enemyX, height/2+150);

  // キャラクターと敵が接触したかどうかを確認します。
  // ここでは、キャラクターと敵の画像の大きさを考慮に入れた適切な閾値を設定する必要があります。
  if (distanceBetweenCharacterAndEnemy < 75) {
    // 接触した場合、ゲームオーバー状態に移行します。
    judge = 4;
  }

  enemyX -= enemySpeed;
  if (x>840 || x<60) {
    dx*=-1;
  }
  judgeFunction();
  if (colorCount %60<=40) {
    rect(x, rectY, 10, 50);//棒
  }
  if (y > height/2+100) {
    y = height/2+100;
    charaImg = img[0];
  }
}
