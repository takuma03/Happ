<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h1>Login</h1>
    <p><a href="redirect.php">Facebookでログイン</a></p>
<img src="./or.png">
<p>メールアドレスとパスワードを記入してログインしてください。</p>
</div>
<form action="" method="post">
        <dl>
                <dt>メールアドレス</dt>
                <dd>
                <input type="text" name="email" size="35" maxlength="255" value="<?php echo htmlspecialchars($_POST['email']); ?>" />
                <?php if($error['login'] == 'blank'): ?>
                <p class="error">* メールアドレスとパスワードをご記入ください</p>
                <?php endif; ?>
                <?php if($error['login'] == 'failed') : ?>
                <p class="error">* ログインに失敗しました。正しくご記入ください>。</p>
                <?php endif; ?>
                </dd>
                <dt>パスワード</dt>
                <dd>
                <input type="password" name="password" size="35" maxlength="255" value="<?php echo htmlspecialchars($_POST['password']); ?>"/>
                </dd>
        </dl>
        <div><input type="submit" value="ログインする" /></div>
</form>
</body>
</html>
