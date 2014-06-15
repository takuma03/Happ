<?php
    // PHPの変数akbに値48を代入する
    $akb = "test";
?>
<html>
<head>
<title>PHPの変数に代入した値をJavaScriptで利用する</title>
<script>
    // javascriptの変数akbにPHPの変数$akbの値48を代入する
    var akb = "<?php echo $akb; ?>"
    // 値をアラート出力する関数
    function func(str){
        alert(str);
    }
    location.href='api-yoheim://someAlert{'+ akb +'}';
</script>
</head>
<body>
    <form action="" method="post">
        <input type="button" value="ボタン" onClick="func(akb)">
    </form>
</body>
</html>
