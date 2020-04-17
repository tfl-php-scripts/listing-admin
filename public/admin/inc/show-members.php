<div id="show-members">
<?php
/** 
 * @copyright  2007 
 * @license    GPL Version 3; BSD Modified 
 * @author     Tess <treibend@gmail.com> 
 * @file       <show-members.php> 
 * @since      September 2nd, 2010 
 * @version    1.0   
 */ 
require("b.inc.php");
require(MAINDIR . "rats.inc.php");
require_once("fun.inc.php");
require_once("fun-external.inc.php");
require_once("fun-listings.inc.php");
require_once("fun-members.inc.php");
require_once("fun-misc.inc.php");
require(MAINDIR . "vars.inc.php");

/** 
 * Set variables for further use~! 
 */ 
$options = (object) array();

if(
 !isset($fKey) || 
 ($fKey != '0' && $fKey != 0 && !in_array($fKey, $wolves->listingsList()))
) {
 $tigers->displayError('Script Error', 'The fanlisting ID is not set!', false);
} else {
 $options->listingID = $tigers->cleanMys($fKey);
 $getItem            = $wolves->getListings($options->listingID, 'object');
}

if(!isset($_GET['page']) || empty($_GET['page']) || !is_numeric($_GET['page'])) {
 $page = 1;
} else {
 $page = $tigers->cleanMys((int)$_GET['page']);
}
$start = $scorpions->escape((($page * $per_page) - $per_page));

if(!isset($pretty_urls) || !in_array($pretty_urls, array('y', 'n'))) {
 $options->prettyURL = false;
 if(isset($_SERVER['QUERY_STRING']) && !empty($_SERVER['QUERY_STRING'])) {
  if(isset($_GET['page'])) {
   $options->url = '?' . str_replace('&', '&#38;', str_replace($_GET['page'], '', 
	 str_replace('&page=', '', $_SERVER['QUERY_STRING']))) . '&#38;';
  } else {
   $options->url = '?' . str_replace('&', '&#38;', $_SERVER['QUERY_STRING']) . '&#38;';
  }
 } else {
  $options->url = '?';
 }
} else {
 $options->prettyURL = true;
 if(isset($set_query) && preg_match("/^[A-Za-z0-9\/-_]+$/", $set_query)) {
  $options->url = $set_query;
  if(isset($_GET['name'])) {
	 $queryname     = str_replace(" ", '+', $_GET['name']);
	 $options->url .= 'country/' . $tigers->cleanMys($queryname) . '/';
	}
 } else {
  $options->url = '';
 }
}
 
$sortbyArray = array('all', 'country', 'list', 'name');
if(isset($sort_by) && in_array($sort_by, $sortbyArray)) {
 $options->sort = $sort_by;
} else {
 $options->sort = 'country';
}

if($getItem->markup == 'xhtml') {
 $options->markup = " /";
} else {
 $options->markup = "";
}

/** 
 * Is the listing crosslisted? Check and perform necessary actions~ 
 */ 
if($getItem->dblist == 1) {
 if(!empty($getItem->dbhost) && !empty($getItem->dbuser) && !empty($getItems->dbname)) {
  $scorpions->breach(0);
  $scorpions->scorpions(
   $getItem->dbhost, $getItem->dbuser, $getItem->dbpass, $getItem->dbname
  );
 }
 $dbtable = $getItem->dbtabl;
 if($getItem->dbtype == 'enth') {
  $select = "SELECT * FROM `$dbtable` WHERE `pending` = '0'";
 } elseif ($getItem->dbtype == 'listingadmin') {
  $flid = $getItem->dbflid;
	$select = "SELECT * FROM `$dbtable` WHERE `fNiq` = '$flid' AND `mPending` = '0'";
 } else {
	$select = "SELECT * FROM `$dbtable` WHERE `apr` = 'y'";
 }
 $true = $scorpions->counts($select, 1);
 if($true->status == false) {
  $tigers->displayError('Script Error', 'The script was unable to select the' . 
	' members from the specified listing.', false);
 }
 $count = $true->rows;
 
 if(!empty($getItem->dbhost) && !empty($getItem->dbuser) && !empty($getItems->dbname)) {
  $scorpions->breach(0);
  $scorpions->breach(1);
 }
} 

else {
 $select = "SELECT * FROM `$_ST[members]` WHERE `fNiq` = '" . $options->listingID . 
 "' AND `mPending` = '0'";
 $true = $scorpions->counts($select, 1);
 if($true->status == false) {
  $tigers->displayError('Script Error', 'Unable to select the members' . 
	' from the specified listing.', false);
 }
 $count = $true->rows;
}

 if($count > 0) {
  if(isset($_GET['sort']) && $_GET['sort'] == 'all') {
   echo $snakes->membersSort('all', $getItem->dblist, $getItem->dbtype);
	 echo $snakes->membersPagination('all', $getItem->dblist, $getItem->dbtype);
  }
 
  elseif (isset($_GET['sort']) && $_GET['sort'] == 'name') {
   echo $snakes->membersSort('name', $getItem->dblist, $getItem->dbtype);
	 echo $snakes->membersPagination('name', $getItem->dblist, $getItem->dbtype);
  } 
 
  elseif (isset($_GET['sort']) && $_GET['sort'] == 'country') {
   echo $snakes->membersSort('country', $getItem->dblist, $getItem->dbtype);
	 if(isset($_GET['name'])) {
	  echo $snakes->membersPagination('country', str_replace('+', ' ', $_GET['name']), $getItem->dblist, $getItem->dbtype);
	 }
  } 
 
  else {
   echo $snakes->membersDefault($options->sort, $getItem->dblist, $getItem->dbtype);
	 if($options->sort != 'all') {
	  echo $snakes->membersPagination($options->sort, $getItem->dblist, $getItem->dbtype);
	 }
  }
 } else {
  echo "<p class=\"tc\">Currently no members!</p>\n";
 }
?>

<p class="showCredit" style="text-align: center;">
 Powered by <?php echo $octopus->formatCredit(); ?>
</p>
</div>
