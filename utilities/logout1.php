<?php
	include "../config.php";
	session_start();
	unset($_SESSION["user"]);
	 if(session_destroy()) {
	header("location:../mainpage1.php");
	}
?>