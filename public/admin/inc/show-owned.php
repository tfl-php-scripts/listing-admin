<div id="show-listings">
<?php
/** 
 * @copyright  2007 
 * @license    GPL Version 3; BSD Modified 
 * @author     Tess <theirrenegadexxx@gmail.com> 
 * @file       <show-owned.php> 
 * @since      September 2nd, 2010 
 * @version    1.0    
 */ 
require("b.inc.php");
require(MAINDIR . "rats.inc.php");
require_once("fun.inc.php");
require_once("fun-categories.inc.php");
require_once("fun-external.inc.php");
require_once("fun-listings.inc.php");
require_once("fun-members.inc.php");
require_once("fun-misc.inc.php");
require(MAINDIR . "vars.inc.php");

/* 
 *  Get our variables and perform common error checks~ 
 */ 
$options = (object) array(
 'list' => '',
 'query' => '',
 'show' => '',
 'sort' => ''
);

if(isset($show) && !empty($show)) {
 if($show == 'all') {
  $options->show = 'all';
 } elseif ($show == 'category') {
  if(isset($catid) && in_array($catid, $lions->categoryList())) {
	 $options->show    = 'category';
	 $options->showcat = $catid;
	} else {
	 $options->show = 'list';
	}
 } elseif ($show == 'dropdown') {
  $options->show = 'dropdown';
 } elseif ($show == 'list') {
  $options->show = 'list';
 } elseif ($show == 'table') {
  $options->show = 'table';
 } else {
  $show = 'list';
 }
} else {
 $options->show = 'list';
}

if(isset($show_sort) && !empty($show_sort)) {
 if($show_sort == 'y') {
  $options->list = 'y';
 } else {
  $options->list = 'n';
 }
} else {
 $options->list = 'n';
}
 
if(isset($list) || !empty($list)) {
 if($list == 'y') {
  $options->sort = 'y';
 } elseif ($list == 'n') {
  $options->sort = 'n';
 }
} else {
 $options->sort = 'n';
}
 
if(isset($_SERVER['QUERY_STRING']) && !empty($_SERVER['QUERY_STRING'])) {
 $query = $tigers->cleanMys($_SERVER['QUERY_STRING']);
 if(isset($_GET['sort'])) {
  $replace = array(
   $_GET['sort'],
   '&amp;sort=',
	 '&sort=',
	 'sort='
  );
	$query          = str_replace($replace, '', $query);
	$query          = $octopus->ampersand($query);
	$options->query = '?' . $query;
 } else {
  $options->query = '?' . $octopus->ampersand($query, 1);
 }
} else {
 $options->query = basename($tigers->cleanMys($_SERVER['PHP_SELF'])) . '?';
}

$statusArray = array('current', 'pending', 'upcoming');
if(!isset($status) || empty($status) || !in_array($status, $statusArray)) {
 $tigers->displayError(
  'Script Error', 
	'The <samp>status</samp> is not set or is incorrect!', 
  false
 );
}
$options->statusID = $status == 'current' ? '0' : ($status == 'upcoming' ? 1 : 2);

/** 
 * @section Get Listing 
 */ 
if(isset($_GET['sort']) && !empty($_GET['sort'])) {
 $sort_category = $tigers->cleanMys($_GET['sort']);
 if($_GET['sort'] != 'all') {
  if(!in_array($sort_category, $lions->categoryList())) {
   $tigers->displayError(
	  'Script Error', 
		'You chose an incorrect category!', 
		false
	 );
  }
 }

 $select = "SELECT * FROM `$_ST[main]` WHERE `show` = '0' AND" . 
 " `status` = '" . $options->statusID . "'";
 if(isset($_GET['sort']) && $_GET['sort'] != 'all') {
  $select .= " AND `category` LIKE '%!$sort_category!%'"; 
 }
 $select .= " ORDER BY `subject` ASC";
 $true    = $scorpions->query($select);
 $count   = $scorpions->total($true);
	
 $category  = $lions->getCategory($sort_category);
 $parentcat = $category->parent == 0 ? '' : $lions->getCatName($category->parent). 
 ($seahorses->getOption('markup') == 'html5' ? " &#187; " : " &raquo; ");
 $name = $parentcat . $lions->getCatName($sort_category);	 
 if(isset($_GET['sort']) && $_GET['sort'] == 'all') {
  echo '<p class="tc">You are viewing all categories. There are currently ' . 
	"<strong>$count</strong> listings listed.</p>\n";
  echo "<div class=\"sep\">\n";
  while($getItem = $scorpions->obj($true)) {
   echo $wolves->getTemplate_Listings($getItem->id);
  }
  echo "</div>\n";
 }
 
 elseif (
  isset($_GET['sort']) && $_GET['sort'] != 'all'
 ) {
  echo "<p class=\"tc\">You are viewing the <strong>$name</strong> category." . 
	" There are currently <strong>$count</strong> listings listed." . 
  "</p>\n";
	if($options->show == 'category' || $options->show == 'dropdown') {
	 echo $wolves->dropdown($status);
	}
 
  $query = $scorpions->query("SELECT * FROM `$_ST[categories]` WHERE `parent` =" . 
  " '$sort_category'");
  $total = $scorpions->total($query);
  if($total > 0 && $lions->childrenListings($sort_category) > 0) {
   echo "<h3>Subcategories</h3>\n";
   echo $octopus->alternate('menu', $seahorses->getOption('markup'), 0);
   while($getItem = $scorpions->obj($query)) {
	  $sql = $scorpions->query("SELECT * FROM `$_ST[main]` WHERE `category` LIKE" . 
    " '%!" . $getItem->catid . "!%' AND `show` = '0'");
    $num = $scorpions->total($sql);
	  if($num > 0) {
     echo "<li><a href=\"" . $options->query . "sort=" . $getItem->catid . 
     "\">" . $lions->getCatName($getItem->parent) . 
	   " &#187; " . $getItem->catname . "</a></li>\n";
	  }
	 }
   echo $octopus->alternate('menu', $seahorses->getOption('markup'), 1);
   echo "\n<h3>Listings</h3>\n";
  }

  echo "<div class=\"sep\">\n";
  while($getItem = $scorpions->obj($true)) {
      //var_dump($getItem);
   echo $wolves->getTemplate_Listings($getItem->id) . "\n";
  }
  echo "</div>\n";
	echo "<p class=\"showBack\"><a href=\"javascript:window.history.back();\">&#171; Go back?</p>\n";
 }
}

/** 
 * Get index of listings! 
 */ 
else { 
 echo $wolves->showListings($status, $options->show);
}
?>

<p class="showCredit" style="text-align: center;">
 Powered by <?php echo $octopus->formatCredit(); ?>
</p>
</div>
