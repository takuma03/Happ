<?php
require_once('config.php');
session_start();
$_SESSION = array();
//debug
//var_dump($_SESSION);
//echo "</br>";
$a = $_COOKIE;
if(isset($_COOKIE[session_name()])){
	$b = setcookie(session_name(), '', time()-86400, '/');
	//var_dump($t);
}
session_destroy();

header('Location:' . SITE_URL);
?>