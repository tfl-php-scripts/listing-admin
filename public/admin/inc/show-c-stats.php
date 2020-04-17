<?php
/** 
 *  @copyright   2007 
 *  @license     GPL Version 3; BSD Modified 
 *  @author      Tess <treibend@gmail.com> 
 *  @file        <show-c-stats.php> 
 *  @since       September 2nd, 2010   
 *  @version     1.0    
 */ 
if(!defined('MAINDIR')) {
 define('MAINDIR', str_replace('inc', '', dirname(__FILE__)));
}
require(MAINDIR . "rats.inc.php");
require_once("fun.inc.php");
require_once("fun-listings.inc.php");
require_once("fun-members.inc.php");
require_once("fun-misc.inc.php");
require(MAINDIR . "vars.inc.php");

$format = html_entity_decode($seahorses->getTemplate('collective_stats_template'));
$format = str_replace('{current}', $seahorses->getCount('current', 'y'), $format);
$format = str_replace('{upcoming}', $seahorses->getCount('upcoming', 'y'), $format);
$format = str_replace('{pending}', $seahorses->getCount('pending', 'y'), $format);
$format = str_replace('{mApproved}', $seahorses->memberCount(0), $format);
$format = str_replace('{mPending}', $seahorses->memberCount(1), $format);
$format = str_replace('{joined}', $seahorses->getCount('joined'), $format);
$format = str_replace('{newest}', $wolves->getNewest(), $format);

echo $format;
?>
