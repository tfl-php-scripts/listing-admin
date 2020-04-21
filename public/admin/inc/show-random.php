<?php
/** 
 * Dude, such a horrible file. It was originally created when Kya 
 * <http://kya.nu/> poked me, and I was like, "SURE THIS CAN'T BE HARD 
 * RIGHT??", and like, self, this isn't Enthusiast or vs.hive or 
 * something just... so much better than what you're coding. >>;  
 * 
 * @copyright   2007 
 * @license     GPL Version 3; BSD Modified 
 * @author      Tess <kensei@love.com> 
 * @file        <show-random.php> 
 * @since       April 1st, 2011  
 * @version     2.2   
 */ 
require('b.inc.php');
require(MAINDIR . 'rats.inc.php');
require_once('fun.inc.php');
require_once('fun-misc.inc.php');

/** 
 * Get variables and options~! 
 */ 
$options = false;

if(isset($show_joined) && !empty($show_joined)) {
 if($show_joined == 'y') {
  $options->showJoined = 'y';
 } elseif ($show_joined == 'n') {
  $options->showJoined = 'n';
 } else {
  $options->showJoined = 'y';
 }
} else {
 $options->showJoined = 'y';
}

if(isset($show_joined_number) && is_numeric($show_joined_number)) {
 $options->showJoinedNumber = $show_joined_number;
} else {
 $options->showJoinedNumber = 2;
}

if(isset($show_owned) && !empty($show_owned)) {
 if($show_owned == 'y') {
  $options->showOwned = 'y';
 } elseif ($show_owned == 'n') {
  $options->showOwned = 'n';
 } else {
  $options->showOwned = 'n';
 }
} else {
 $options->showOwned = 'n';
}
 
if(isset($show_owned_number) && is_numeric($show_owned_number)) {
 $options->showOwnedNumber = $show_owned_number;
} else {
 $options->showOwnedNumber = 2;
}

if(isset($show_owned_rotate) && !empty($show_owned_rotate)) {
 if($show_owned_rotate == 'y') {
  $options->showOwnedRotate = 'y';
 } elseif ($show_owned_rotate == 'n') {
  $options->showOwnedRotate = 'n';
 } else {
  $options->showOwnedRotate = 'n';
 }
} else {
 $options->showOwnedRotate = 'n';
}

$markup = $seahorses->getOption('markup');
if($markup == 'xhtml') {
 $mark = ' /';
} else {
 $mark = '';
}

/** 
 * Get the index: owned and joined listings \o/ 
 */ 
if($options->showOwned == 'y') {
 $select = "SELECT * FROM `$_ST[main]` WHERE `show` = '0' AND `status` = '0'" .
     ' ORDER BY `since` DESC LIMIT ' . $options->showOwnedNumber;
 $true = $scorpions->query($select);
 if($true == false) {
  $tigers->displayError('Database Error', 'The script was unable to select' . 
	' the newest listing(s)!', false);
 } else {
  while($getItem = $scorpions->obj($true)) {
   echo '<a href="' . $getItem->url . '"><img src="' . $seahorses->getOption('img_http') . $getItem->image .
       '" alt="' . $getItem->subject . '" title="' . $getItem->subject . "\"$mark></a>\n";
  }
 }

 $query = "SELECT * FROM `$_ST[main]` WHERE `show` = '0' AND `status` = '0'" .
     ' ORDER BY RAND() LIMIT ' . $options->showOwnedNumber;
 $sql = $scorpions->query($query);
 if($sql == false) {
  $tigers->displayError('Database Error', 'The script was unable to select' . 
  ' the newest listing(s)!', false);
 } else {
  while($item = $scorpions->obj($sql)) {
   echo '<a href="' . $item->url . '"><img src="' . $seahorses->getOption('img_http') . $item->image .
       '" alt="' . $item->subject . '" title="' . $item->subject . "\"$mark></a>\n";
  }
 }
}

if($options->showJoined == 'y') {
 $select = "SELECT * FROM `$_ST[joined]` ORDER BY `jAdd` DESC LIMIT " . $options->showJoinedNumber;
 $true = $scorpions->query($select);
 if($true == false) {
  $tigers->displayError('Database Error', 'The script was unable to select' . 
	' the random joined listing(s)!', false);
 } else {
  while($getItem = $scorpions->obj($true)) {
   if(file_exists($seahorses->getOption('jnd_path') . $getItem->jImage) && !empty($getItem->jImage)) {
	  echo '<a href="' . $getItem->jURL . '"><img src="' . $seahorses->getOption('jnd_http') . $getItem->jImage .
          '" alt="' . $getItem->jSubject . '" title="' . $getItem->jSubject . "\" class=\"joinedRandom\"$mark></a>\n";
	 } else {
    echo '<a href="' . $getItem->jURL . '"><img src="' . $seahorses->getOption('jnd_http') . 'no_image.png' .
        '" alt="' . $getItem->jSubject . '" title="' . $getItem->jSubject . "\" class=\"joinedRandom\"$mark></a>\n";
	 }
  }
 }

 $query = "SELECT * FROM `$_ST[joined]` ORDER BY RAND() LIMIT " . $options->showJoinedNumber;
 $sql = $scorpions->query($query);
 if($sql == false) {
  $tigers->displayError('Database Error', 'The script was unable to select' . 
  ' the random joined listing(s)!', false);
 } else {
  while($item = $scorpions->obj($sql)) {
   if(file_exists($seahorses->getOption('jnd_path') . $item->jImage) && !empty($item->jImage)) {
	  echo '<a href="' . $item->jURL . '"><img src="' . $seahorses->getOption('jnd_http') . $item->jImage .
          '" alt="' . $item->jSubject . '" title="' . $item->jSubject . "\" class=\"joinedRandom\"$mark></a>\n";
	 } else {
    echo '<a href="' . $item->jURL . '"><img src="' . $seahorses->getOption('jnd_http') . 'no_image.png' .
        '" alt="' . $item->jSubject . '" title="' . $item->jSubject . "\" class=\"joinedRandom\"$mark></a>\n";
	 }
  }
 }
}
