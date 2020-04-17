<div id="show-joined">
<?php
/** 
 * @copyright  2007 
 * @license    GPL Version 3; BSD Modified 
 * @author     Tess <treibend@gmail.com> 
 * @file       <show-joined.php> 
 * @since      September 2nd, 2010 
 * @version    1.2    
 */ 
require("b.inc.php");
require(MAINDIR . "rats.inc.php");
require_once("class-antispam.inc.php");
require_once("fun.inc.php");
require_once("fun-categories.inc.php");
require_once("fun-external.inc.php");
require_once("fun-joined.inc.php");
require_once("fun-misc.inc.php");
require(MAINDIR . "vars.inc.php");

/**  
 * Get variables and common errors before we run anything :D  
 */ 
$options = (object) array(
 'lister' => '',
 'madeby' => '',
 'markup' => '',
 'query' => '',
 'search' => '',
 'sort' => ''
);

if(isset($show_search)) {
 if(empty($show_search)) {
  $options->search = 'no_search';
 } elseif ($show_search == 'y') {
  $options->search = 'search';
 } elseif ($show_search == 'n') {
  $options->search = 'no_search';
 }
} else {
 $options->search = 'no_search';
}

if(isset($show_lister)) {
 if(empty($show_lister)) {
  $options->lister = 'no_lister';
 } elseif ($show_lister == 'y') {
  $options->lister = 'lister';
 } elseif ($show_lister == 'n') {
  $options->lister = 'no_lister';
 }
} else {
 $options->lister = 'no_lister';
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

if(isset($show_madeby)) {
 if(empty($show_madeby)) {
  $options->madeby = 'madeby';
 } elseif ($show_madeby == 'y') {
  $options->madeby = 'madeby';
 } elseif ($show_madeby == 'n') {
  $options->madeby = 'no_madeby';
 } else {
  $options->madeby = 'madeby';
 }
} else {
 $options->madeby = 'madeby';
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
	$query = str_replace($replace, '', $query);
	$query = $octopus->ampersand($query);
	$options->query = '?' . $query;
 } else {
  $options->query = '?' . $octopus->ampersand($query, 1);
 }
} else {
 $options->query = '?';
}

if($seahorses->getOption('markup') == 'xhtml') {
 $options->markup = " /";
} else {
 $options->markup = "";
}

/** 
 * @subpackage Joined Headers and Footers 
 */ 
function _h($p, $a = 0, $c = '', $i = '') {
 global $octopus, $options;

 $b = $c == '' ? 'joinedImages' : $c;
 $d = $i == '' ? '' : " id=\"$i\"";
 $r = '';

 if($a == 0) {
  if(preg_match("/(<li>)/", $p)) {
   $r .= $octopus->alternate('menu', $options->markup);
  } elseif (preg_match("/(<tbody>|<tr>|<td>)/", $p)) {
   $r .= $octopus->alternate('table', $options->markup);
  } else {
   $r .= "<div class=\"$b\"$d>\n";
  }
 } elseif ($a == 1) {
  if(preg_match("/(<li>)/", $p)) {
   $r .= $octopus->alternate('menu', $options->markup, 1);
  } elseif (preg_match("/(<tbody>|<tr>|<td>)/", $p)) {
   $r .= $octopus->alternate('table', $options->markup, 1);
  } else {
   $r .= "</div>\n";
  }
 }

 return $r;
}

/** 
 * @section Get Joined Listing(s) 
 */ 
if(isset($_GET['sort']) && !empty($_GET['sort'])) {
 $sort_category = $tigers->cleanMys($_GET['sort']);
 if(
  $_GET['sort'] != 'all' && $_GET['sort'] != 'madeby' && $_GET['sort'] != 'pending'
 ) {
  if(!in_array($sort_category, $lions->categoryList())) {
   $tigers->displayError('Script Error', 'You chose an incorrect category!', false);
  }
 }
 $template = html_entity_decode(
  $seahorses->getTemplate('joined_template'), 
  ENT_QUOTES, 
  'ISO-8859-15'
 );

 $select = "SELECT * FROM `$_ST[joined]`";
 if(isset($_GET['sort']) && $_GET['sort'] == 'pending') {
  $select .= " WHERE `jStatus` = '1'";
 }
 else {
  $q = '';
  if(isset($_GET['sort']) && $_GET['sort'] != 'all' && $_GET['sort'] != 'madeby') {
   $q .= " `jCategory` LIKE '%|$sort_category|%' AND"; 
  } elseif (isset($_GET['sort']) && $_GET['sort'] == 'madeby') {
   $q .= " `jMade` = 'y' AND";
  } 
	$q       = trim($q, " AND");
	$query   = ($q == '' ? '' : " AND ");
  $select .= " WHERE " . $q . $query . " `jStatus` = '0'";
 }
 $select .= " ORDER BY `jSubject` ASC";
 $true    = $scorpions->query($select);
 $count   = $scorpions->total($true);
	
 $name = $lions->getCatName($_GET['sort']);	 
 if(isset($_GET['sort']) && $_GET['sort'] == 'all') {
  echo '<p class="tc">You are viewing all categories. There are currently' . 
  " <strong>$count</strong> joined listings listed.</p>\n";
  while($getItem = $scorpions->obj($true)) {
   echo $dragons->getTemplate_Joined($getItem->jID) . "\n";
  }
 }

 elseif (isset($_GET['sort']) && $_GET['sort'] == 'madeby') {
  echo '<p class="tc">You are viewing all joined listing I have made codes for.' . 
  " There are currently <strong>$count</strong> joined listings listed.</p>\n";
  
  $caties = $lions->categoryList('array');
  foreach($caties as $c) {
   $catid = $c['catid'];
   $select = $scorpions->query("SELECT * FROM `$_ST[joined]` WHERE `jCategory`" . 
   " LIKE '%|$catid|%' AND `jMade` = 'y' ORDER BY `jSubject` ASC");
   $count = $scorpions->total($select);
   if($count > 0) {
	  echo "<h3>" . $c['catname'] . "</h3>\n";
    echo _h($template, 0, 'joinedbyme tc', 'category-' . $catid);
    while($getItem = $scorpions->obj($select)) {
     echo $dragons->getTemplate_Joined($getItem->jID) . "\n";
    }
    echo _h($template, 1);
   }
  }
 }

 elseif (isset($_GET['sort']) && $_GET['sort'] == 'pending') {
  echo '<p class="tc">You are viewing all pending joined listings. There are' . 
  " currently <strong>$count</strong> pending joined listings listed.</p>\n";
  echo _h($template);
  while($getItem = $scorpions->obj($true)) {
   echo $dragons->getTemplate_Joined($getItem->jID) . "\n";
  }
  echo _h($template, 1);
 }

 elseif (
  isset($_GET['sort']) && 
  $_GET['sort'] != 'all' && 
  $_GET['sort'] != 'madeby' &&
  $_GET['sort'] != 'pending'
 ) {
  echo "<p class=\"tc\">You are viewing the <strong>$name</strong> category." . 
  " There are currently <strong>$count</strong> joined listings listed.</p>\n";
 
  $query = $scorpions->query("SELECT * FROM `$_ST[categories]` WHERE `parent`" . 
  " = '$sort_category' ORDER BY `catname` ASC");
  if($scorpions->total($query) > 0 && $lions->childrenJoined($sort_category) > 0) {
   echo "<h3>Subcategories</h3>";
   echo $octopus->alternate('menu', $options->markup);
   while($getItem = $scorpions->obj($query)) {
	  $sql = $scorpions->query("SELECT * FROM `$_ST[joined]` WHERE `jCategory`" . 
    " LIKE '%|" . $getItem->catid . "|%'");
	  if($scorpions->total($sql) > 0) {
     echo "<li><a href=\"" . $options->query . "sort=" . $getItem->catid . 
		 "\">" . $lions->getCatName($getItem->parent) . 
		 " &#187; " . $getItem->catname . "</a></li>\n";
	  } 
	 }
   echo $octopus->alternate('menu', $options->markup, 1);
   echo "\n<h3>Joined Listings</h3>\n";
  }
	
	$jimage = array();
	$jtext  = array();
	while($getItem = $scorpions->obj($true)) {
	 $path = $seahorses->getOption('jnd_path');
   if(!empty($getItem->jImage) && is_file($path . $getItem->jImage)) {
	  $jimage[] = $getItem->jID;
	 } else {
	  $jtext[] = $getItem->jID;
	 }
  }

  echo _h($template, 0, 'joinedListings', 'category-' . $sort_category);
  foreach($jimage as $image) {
   echo $dragons->getTemplate_Joined($image) . "\n";
  }
	echo _h($template, 1);
	
	echo "<menu>\n";
	foreach($jtext as $text) {
	 $joined = $dragons->getJoined($text);
   echo " <li><a href=\"" . $joined->jURL . "\">" . $joined->jSubject . 
	 "</a></li>\n";
  }
	echo "</menu>\n";
 } 
}

/** 
 * If the form has been set -- and can be accessed -- get it! 
 */
elseif (isset($_GET['search'])) {
 if($options->search == 'search') {
  echo $dragons->joinedForm();
 }
 
 else {
?>
<p class="tc">It appears the collective owner has set the joined form to 
<strong>off</strong>, leaving you unable to search for listings by form.</p>
<?php 
 }
}

/** 
 * Index 
 */ 
else { 
 echo $dragons->showJoined($options->lister);
}
?>
<p class="showCredit" style="text-align: center;">
 Powered by <?php echo $octopus->formatCredit(); ?>
</p>
</div>
