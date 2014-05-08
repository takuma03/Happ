<script>

var i = Math.random()
function jump(){
    //OKならTOPページにジャンプさせる
    location.href = 'api-yoheim://someAlert{' + i + '}';
}


</script>
</head>
<body>

<?php
echo "</br>Hello World!";
?>


<form>
<input type="button" name="link" value="ネイティブ機能へ" onclick="jump()">
</form>
</body>
</html>
