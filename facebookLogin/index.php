<?php

require_once('config.php');

session_start();

function h($s) {
    return htmlspecialchars($s, ENT_QUOTES, "UTF-8");
}



//ログインチェック
if(empty($_SESSION['user'])){
    header('Location: login.php');
    exit;
}
 
//友達情報の取得
$url = "https://graph.facebook.com/me/friends?access_token="



?>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Facebook Friends</title>
</head>
<body>
    <h1>Facebook Friends</h1>
    <div>
    <img src="<?php echo h($_SESSION['user']['facebook_picture']); ?>">
    </div>
    <p><?php echo h($_SESSION['user']['facebook_name']); ?>としてログインしています。</p>
</body>
</html>