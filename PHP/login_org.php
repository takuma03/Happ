<?php
require('dbconnect.php');

session_start();

if($COOKIE['email'] !=''){
        $_POST['email'] = $_COOKIE['email'];
        $_POST['password'] = $_COOKIE['password'];
        $_POST['save'] = 'on';
}

if(!empty($_POST)){
        //ログインの処理
        if($_POST['email'] != '' && $_POST['password'] !=''){
                $sql = sprintf('SELECT * FROM user WHERE mail="%s" AND password="%s"',
                        mysql_real_escape_string($_POST['email']),
                         mysql_real_escape_string(sha1($_POST['password']))
                );
                $record = mysql_query($sql) or die(mysql_error());
                if($table = mysql_fetch_assoc($record)){
                        //ログイン成功
                        $_SESSION['id'] = $table['id'];
                        $_SESSION['time'] = time();
                        
                        //ログイン情報を記録する
                        if($_POST['save'] == 'on'){
                                setcookie('email', $_POST['email'], time()+60*60*24*14);
                                setcookie('password', $_POST['password'],time()+60*60*24*14);
                        }
                        
                                
                        header('Location: index.php');
                        exit();
                }else{
                        $error['login'] = 'failed';
                }
        }else{
                $error['login'] = 'blank';
        }
}
?>




<div id="lead">
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
                <p class="error">* ログインに失敗しました。正しくご記入ください。</p>
                <?php endif; ?>
                </dd>
                <dt>パスワード</dt>
                <dd>
                <input type="password" name="password" size="35" maxlength="255" value="<?php echo htmlspecialchars($_POST['password']); ?>"/>
                </dd>
        </dl>
        <div><input type="submit" value="ログインする" /></div>
</form>
