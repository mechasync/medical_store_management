<?php
/**
 * Medical Store Management System
 * Main Entry Point
 */

// Start session
session_start();

// Include configuration
include 'config.php';

// Redirect to appropriate dashboard based on user role or show login
// For now, redirect to mainpage
header('Location: mainpage.php');
exit();
?>
