<?php
require('dbconnect.php');
//$mysql_id = array();
$csv_id = array();
//$n = 0;
/*
//�f�[�^�x�[�X�̃f�[�^���擾
$recordSet = mysql_query('select * from task');
while($data = mysql_fetch_assoc($recordSet)){
        $mysql_id[$n] = $data['task_id'];
        $n++;
}
*/

$n = 1;
//CSV�̃f�[�^�擾
if (($handle = fopen("test.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
            //$csv_id[$n] = $data[7];
            if($data[7] == "'0'"){
                        $sql = sprintf('insert into task values(' . $data[0] . ',' . $data[1] . ',' . $data[2] . ',' . $data[3] . ',' . $data[4] . ',' . $data[5] . ',' . $data[6] . ', 1 )' );
                        //echo   $sql . "<br />";
                        mysql_query($sql) or die (mysql_error());
                        //echo '�f�[�^��}�����܂���';       
                        //echo "<br />";
            }elseif($data[7] == "'1'"){
                        //MySQL����update_time���擾����
                        $result  =  mysql_query('select update_time from task where task_id = ' . $n);
                        while($row = mysql_fetch_assoc($result)){
                                $mysql_update_time = $row['update_time'];
                        }
                        //CSV�f�[�^��update_time($data[6])�Ɣ�r����
                        echo "MySQL�̃f�[�^�F" . $mysql_update_time . "<br />";
                        $csv_update_time = str_replace("'","",$data[6]);
                        echo "CSV�̃f�[�^�F" . $csv_update_time . "<br />";
                        if(strtotime($csv_update_time) > strtotime($mysql_update_time)){
                        //CSV�f�[�^�����V�������CSV���̃f�[�^��MySQL��insert����
                        		echo "iPhone���̕����V�����ł�<br />" ;
                        		$sql = sprintf('update task set category =' . $data[1] . ', task_name =' . $data[2] . ', memo =' .$data[3] . ', start_time =' . $data[4] . ', stop_time =' . $data[5] . ',update_time =' . $data[6] . 'where task_id =' . $n );
                        		mysql_query($sql) or die(mysql_error());
                        		echo "�f�[�^��}�����܂���<br />";
                        //MySQL�����V�������SQL�����쐬����
                        }elseif(strtotime($csv_update_time) < strtotime($mysql_update_time)){
                        		echo "MySQL���̕����V�����ł�<br />";
                        }else{
                        		echo "�X�V�Ȃ�<br />";
                        }
                        
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
