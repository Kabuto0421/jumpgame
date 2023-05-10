void drawButton() {
  strokeWeight(3);
  stroke(255);
  // ボタンがマウスオーバーされているかどうかを確認します。
  if (mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight && scene == 0) {
    // マウスオーバー時の色（ここでは明るい赤）でボタンを描画します。
    fill(#737673);
    if (mousePressed) {
      // ボタンがクリックされたら、sceneを1に設定します。
      scene = 1;
      enemyX = width-100;
    }
  } else {
    // マウスオーバーしていないときは、通常の色（ここでは暗い赤）でボタンを描画します。
    fill(#010502);
  }

  rect(buttonX, buttonY, buttonWidth, buttonHeight);

  // ボタンの上にテキストを描画します。
  fill(255); // テキストの色を白に設定します。
  textSize(50); // テキストのサイズを設定します。
  text("GAME START", buttonX,buttonY); // ボタンの中央にテキストを配置します。
  strokeWeight(1);
}
