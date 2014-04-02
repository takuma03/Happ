<?php
require('dbconnect.php');
//$mysql_id = array();
$csv_id = array();
//$n = 0;
/*
//データベースのデータを取得
$recordSet = mysql_query('select * from task');
while($data = mysql_fetch_assoc($recordSet)){
        $mysql_id[$n] = $data['task_id'];
        $n++;
}
*/

$n = 1;
//CSVのデータ取得
if (($handle = fopen("test.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
            //$csv_id[$n] = $data[7];
            if($data[7] == "'0'"){
                        $sql = sprintf('insert into task values(' . $data[0] . ',' . $data[1] . ',' . $data[2] . ',' . $data[3] . ',' . $data[4] . ',' . $data[5] . ',' . $data[6] . ', 1 )' );
                        //echo   $sql . "<br />";
                        mysql_query($sql) or die (mysql_error());
                        //echo 'データを挿入しました';       
                        //echo "<br />";
            }elseif($data[7] == "'1'"){
                        //MySQLからupdate_timeを取得する
                        $result  =  mysql_query('select update_time from task where task_id = ' . $n);
                        while($row = mysql_fetch_assoc($result)){
                                $mysql_update_time = $row['update_time'];
                        }
                        //CSVデータのupdate_time($data[6])と比較する
                        echo $mysql_update_time . "<br />";         
                        
                        //CSVデータ側が新しければCSV側のデータをMySQLへinsertする
                                
                        //MySQL側が新しければSQL文を作成する
            }
            $n++;
    }
    fclose($handle);
}
/*
var_dump($csv_id);

for($i = 0; $i < count($csv_id); $i++){
        if($csv_id[$i] == "'0'"){ 
                echo "<br />";
                echo $i . "|" . $csv_id[$i] ."<br />";
        }
}
*/


?>
