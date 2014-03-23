<?php

$row = 1;
if (($handle = fopen("test.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle)) !== FALSE) {
        $num = count($data);
        echo "<p> $num fields in line $row: <br /></p>\n";
        $row++;
        for ($c=0; $c < $num; $c++) {
            echo $data[0] . "<br />\n";
        }
    }
    fclose($handle);
}

//$sql = sprintf("insert into task values(1,'test','test','test','test','test','test')");
//mysql_query($sql) or die(mysql_error());
?>
