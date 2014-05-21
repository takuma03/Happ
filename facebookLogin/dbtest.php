<?php

require_once('config.php');
try{ 
		$dbh = new PDO('mysql:host=' . DB_HOST . '; dbname=' . DB_NAME ,DB_USER , DB_PASSWORD);
} catch (PDOException $e){
		echo $e->getMessage();
		exit;
}

?>