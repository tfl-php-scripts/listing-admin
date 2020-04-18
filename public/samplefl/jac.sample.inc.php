<?php
/**
 * @project          Listing Admin
 * @copyright        2007
 * @license          GPL Version 3; BSD Modified
 * @author           Tess <theirrenegadexxx@gmail.com>
 * @contributor      Ekaterina <scripts@robotess.net> http://scripts.robotess.net
 * @file             <jac.sample.inc.php>
 * @version          Robotess Fork
 */

if (basename($_SERVER['PHP_SELF']) === 'jac.inc.php') {
    die('<p>ERROR: <em>Nobody ever told [her] it was the wrong way</em>...<br>' .
        "Sorry m'dear, you cannot access this file directly!</p>\n");
}

# ----------------------------------------------------------- 
/* 
 * Database Variables  
 * 
 * $database_host - MySQL Host (usually localhost) 
 * $database_user - MySQL username  
 * $database_pass - MySQL password  
 * $database_name - MySQL name 
 */
# ----------------------------------------------------------- 
$database_host = 'localhost';
$database_user = 'root';
$database_pass = 'root';
$database_name = 'bambino';

# ----------------------------------------------------------- 
/* 
 * Table Prefix 
 * 
 * Table prefix before your table names. Beware that if you 
 * have installed Listing Admin prior to version 2.1.9, 
 * your prefix is most likely "trex_" 
 */
# ----------------------------------------------------------- 
$_ST['prefix'] = 'trex_';

# ----------------------------------------------------------- 
/* 
 * STOP EDITING HERE! 
 * 
 * Below this line are sensitive lines that should NOT be 
 * messed with unless you want the script to blow up, and 
 * an ugly "WARNING: SYNTAX ERROR, LOL YOU'RE AN IDIOT" 
 * error to appear (but no, really, don't do it, dudes). 
 */
# ----------------------------------------------------------- 
if ((!isset($_ST['prefix']) || empty($_ST['prefix']))
    || (strpos($_ST['prefix'], '_') === false)) {
    $prefix = 'listingadmin_';
} else {
    $prefix = $_ST['prefix'];
}

/**
 * Table variable!
 */
$_ST['options'] = $prefix . 'options';

# -- STOP EDITING HERE! -------------------------------------
# -----------------------------------------------------------
# 
#  Below this line are sensitive lines that should NOT be 
#  messed with unless you know exactly what you're doing.
# 
# -----------------------------------------------------------
# -----------------------------------------------------------

/**
 * Get MySQLi link! - thanks to Martina http://inspirationally.net
 */
$connect = mysqli_connect($database_host, $database_user, $database_pass, $database_name)
or die('<p><span class="error">Error:</span> You cannot currently connect to MySQL.' .
    ' Make sure all variables are correct in <samp>rats.inc.php</samp>; if it is a random' .
    ' error, wait it out and see if it\'ll magically disappear.</p>');
$database = mysqli_select_db($connect, $database_name)
or die('<p><span class="error">Error:</span> You cannot currently connect to your database.' .
    ' Make sure all variables are correct in <samp>rats.inc.php</samp>; if it is a random' .
    ' error, wait it out and see if it\'ll magically disappear.</p>');

/**
 * Aaaaaa-aaa-and run query~!
 */
$select = "SELECT `text` FROM `$_ST[options]` WHERE `name` = 'adm_path' LIMIT 1";
$query = mysqli_query($connect, $select);
if ($query === false) {
    exit('<p class="errorButton"><span class="error">ERROR:</span> Unable to select the specified option.' .
        " Make sure your options table exists.</p>\n");
}
$getItem = mysqli_fetch_array($query);
define('STPATH', $getItem['text']);
