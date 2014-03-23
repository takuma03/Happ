<?php
require('../dbconnect.php');

//データベースのデータを取得
$recordSet = mysql_query('select * from task');
while($data = mysql_fetch_assoc($recordSet)){
        echo $data['task_id'];
        echo '<br />';
}

//レコード数を取得
$recordCount = mysql_query('select count(task_id) from task');
$record = mysql_fetch_assoc($recordCount);

?>