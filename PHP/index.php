<?php
require('dbconnect.php');
$mysql_id = array();
$csv_id = array();
$n = 0;
//�f�[�^�x�[�X�̃f�[�^���擾
$recordSet = mysql_query('select * from task');
while($data = mysql_fetch_assoc($recordSet)){
        $mysql_id[$n] = $data['task_id'];
        $n++;
}
$n = 0;
//CSV�̃f�[�^�擾
if (($handle = fopen("test.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
            $csv_id[$n] = $data[0];
            $n++; 
    }
    fclose($handle);
}
//CSV�̐���MySQL�̃��R�[�h���̏ꍇ
if(count($csv_id) > count($mysql_id)){
	echo "CSV�̐���MySQL�̃��R�[�h���̏ꍇ";
	$insert_start_id = 
//CSV�̐�<MySQL�̃��R�[�h���̏ꍇ	
}elseif(count($csv_id) < count($mysql_id)){
	echo "CSV�̐�<MySQL�̃��R�[�h���̏ꍇ";
}

?>
