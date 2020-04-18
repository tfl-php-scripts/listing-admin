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

function getLAPath($settings, $dbHost, $dbUser, $dbPass, $dbName)
{
    $errorMsgNoConnect = '<p><span class="error">Error:</span> You cannot currently connect to MySQL.' .
        ' Make sure all variables are correct in <samp>rats.inc.php</samp>; if it is a random' .
        ' error, wait it out and see if it\'ll magically disappear.</p>';

    $errorMsgNoOptionsTable = '<p class="errorButton"><span class="error">ERROR:</span> Unable to select the specified option.' .
        ' Make sure your options table exists.</p>';

    /**
     * Get MySQLi/PDO_MySQL link!
     */
    if (extension_loaded('mysqli')) {
        $connect = mysqli_connect($dbHost, $dbUser, $dbPass, $dbName) or die($errorMsgNoConnect);
    } else if (extension_loaded('pdo_mysql')) {
        try {
            $connect = new PDO('mysql:host=' . $dbHost . ';dbname=' . $dbName . ';charset=utf8', $dbUser, $dbPass);
            $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die($errorMsgNoConnect . $e->getMessage());
        }
    } else {
        exit('<p class="errorButton"><span class="error">ERROR:</span> Please install either MySQLi or PDO_MySQL extension for PHP.</p>');
    }

    /**
     * Aaaaaa-aaa-and run query~!
     */
    $select = "SELECT `text` FROM `$settings[options]` WHERE `name` = 'adm_path' LIMIT 1";
    $optionsSqlResult = $connect->query($select);
    if ($optionsSqlResult === false) {
        exit($errorMsgNoOptionsTable);
    }
    $getItem = wrapFetchArray($optionsSqlResult);
    return $getItem['text'];
}

function wrapFetchArray($result)
{
    if ($result instanceof PDOStatement) {
        return $result->fetch(PDO::FETCH_ASSOC);
    }
    if ($result instanceof mysqli_result) {
        return $result->fetch_array();
    }
    die('Unsupported SQL extension');
}

define('STPATH', getLAPath($_ST, $database_host, $database_user, $database_pass, $database_name));
