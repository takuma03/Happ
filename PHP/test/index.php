<?php
require('../dbconnect.php');
$sql = sprintf('INSERT INTO user SET user_id=1, user_name="tkm03", mail="sebango3saitou@gmail.com",password="%s", job="SE"',
                mysql_real_escape_string(sha1('sebango3'))
        );
mysql_query($sql) or die(mysql_error());

?>
