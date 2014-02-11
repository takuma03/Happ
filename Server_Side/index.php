<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>test</title>
</head>
<body>
<p><?php
    
    if (is_uploaded_file($_FILES["upfile"]["tmp_name"])) {
        if (move_uploaded_file($_FILES["upfile"]["tmp_name"], "./" . $_FILES["upfile"]["name"])) {
            echo $_FILES["upfile"]["name"] . "をアップロードしました。";
        } else {
            echo "ファイルをアップロードできません。";
        }
    } else {
        echo "ファイルが選択されていません。";
    }
    
    ?></p>
</body>
</html>