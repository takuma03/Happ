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
$top_no_sync = 0;
//CSV�s���擾
$count_csv = sizeof(file("test.csv"));
//echo $count_csv;
//CSV�̃f�[�^�擾
if (($handle = fopen("test.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
<<<<<<< HEAD
        //$csv_id[$n] = $data[7];
        if($data[7] == "'0'"){
            $sql = sprintf('insert into task (category, task_name, memo, start_time, stop_time, update_time) values (' . $data[1] . ',' . $data[2] . ',' . $data[3] . ',' . $data[4] . ',' . $data[5] . ',' . $data[6] .')');
            //echo   $sql . "<br />";
            mysql_query($sql) or die (mysql_error());
            echo '�f�[�^��}�����܂���';       
            //echo "<br />";
            //CSV���̈�ԍŏ���sync_flag��0�̃��R�[�h��task_id���擾����
            if($top_no_sync == 0){
                $top_no_sync = $data[0];
                //echo $top_no_sync;
            }
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
                $mysql_result = mysql_query('select * from task where task_id =' .$n);
                while($row = mysql_fetch_assoc($mysql_result)){
                    $mysql_category = $row['category'];
                    $mysql_task_name = $row['task_name'];
                    $mysql_memo = $row['memo'];
                    $mysql_start_time = $row['start_time'];
                    $mysql_stop_time = $row['stop_time'];
                    echo 'update task set category = "' . $mysql_category . '", task_name = "' . $mysql_task_name . '", memo = "' .$mysql_memo . '", start_time = "' . $mysql_start_time . '", stop_time = "' . $mysql_stop_time . '",update_time = "' . $mysql_update_time . '" where task_id = ' . $n .';';
                }
            }else{
                echo "�X�V�Ȃ�<br />";
=======
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
                        	        $mysql_result = mysql_query('select * from task where task_id =' .$n);
                        	        while($row = mysql_fetch_assoc($mysql_result)){
                        	               $mysql_category = $row['category'];
                        	               $mysql_task_name = $row['task_name'];
                        	               $mysql_memo = $row['memo'];
                        	               $mysql_start_time = $row['start_time'];
                        	               $mysql_stop_time = $row['stop_time'];
                        	               //test
                        	        }
                        	        echo 'update task set category = "' . $mysql_category . '", task_name = "' . $mysql_task_name . '", memo = "' .$mysql_memo . '", start_time = "' . $mysql_start_time . '", stop_time = "' . $mysql_stop_time . '",update_time = "' . $mysql_update_time . '" where task_id = ' . $n .';';
                        }else{
                        		echo "�X�V�Ȃ�<br />";
                        }
                        
>>>>>>> ac538ddaee4c3146ffd6ddb4228e1480f64e8a69
            }
        }
        $n++;
    }
    //CSV�̃��R�[�h����MySQL�̃��R�[�h�����r����
    $mysql_count = mysql_query('select count(*) from task');
    $row = mysql_fetch_assoc($mysql_count);
    //echo 'MySQL�̃��R�[�g����' . $row['count(*)'];
    if($count_csv != $row['count(*)']){
        if($top_no_sync !=0){
            echo 'delete from task where task_id >= ' . $top_no_sync .'<br />';
        }
        
        $mysql_result = mysql_query('select * from task where task_id >= ' .$top_no_sync);
        while($row = mysql_fetch_assoc($mysql_result)){
            $mysql_task_id = $row['task_id'];
            $mysql_category = $row['category'];
            $mysql_task_name = $row['task_name'];
            $mysql_memo = $row['memo'];
            $mysql_start_time = $row['start_time'];
            $mysql_stop_time = $row['stop_time'];
            $mysql_update_time = $row['update_time'];
            echo 'insert into task values(' . $mysql_task_id . ',"' . $mysql_category . '","' . $mysql_task_name . '","' . $mysql_memo . '","' . $mysql_start_time . '","' . $mysql_stop_time . '","' . $mysql_update_time . '",1);<br />';
        }
        
    }
    fclose($handle);
}


?>
