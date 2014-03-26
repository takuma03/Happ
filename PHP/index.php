<?php
require('dbconnect.php');
$mysql_id = array();
$csv_id = array();
$n = 0;
//データベースのデータを取得
$recordSet = mysql_query('select * from task');
while($data = mysql_fetch_assoc($recordSet)){
        $mysql_id[$n] = $data['task_id'];
        $n++;
}
$n = 0;
//CSVのデータ取得
if (($handle = fopen("test.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
            $csv_id[$n] = $data[0];
            $n++; 
    }
    fclose($handle);
}
//CSVの数＞MySQLのレコード数の場合
if(count($csv_id) > count($mysql_id)){
	echo "CSVの数＞MySQLのレコード数の場合";
	$insert_start_id = 
//CSVの数<MySQLのレコード数の場合	
}elseif(count($csv_id) < count($mysql_id)){
	echo "CSVの数<MySQLのレコード数の場合";
}

?>
