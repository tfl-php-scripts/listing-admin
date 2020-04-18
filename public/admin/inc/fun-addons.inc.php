<?php
/** 
 * @copyright 2007 
 * @license   GPL Version 3; BSD Modified 
 * @author    Tess <treibend@gmail.com> 
 * @file      <fun-addons.inc.php> 
 * @since     September 5th, 2011 
 * @version   2.3alpha  
 */ 

if(class_exists('cheetahs') == false) {
 class cheetahs {
 
  public function isActive($p) {
   global $seahorses;

   $r = 0;
   switch($p) {
    case 'codes':
     $r = $seahorses->getOption('codes_opt') == 'y' ? 1 : 0;
    break;
    case 'kim':
     $r = $seahorses->getOption('kim_opt') == 'y' ? 1 : 0;
    break;
    case 'lyrics':
     $r = $seahorses->getOption('lyrics_opt') == 'y' ? 1 : 0;
    break;
    case 'quotes':
     $r = $seahorses->getOption('quotes_opt') == 'y' ? 1 : 0;
    break;
    case 'updates':
     $r = $seahorses->getOption('updates_opt') == 'y' ? 1 : 0;
    break;
   }

   return $r;
  } 

  /** 
   * Check if an addon is installed (aka if the table is installed) 
   * 
   * @function  $cheetahs->isInstalled() 
   * @param     $c, string; addon slug 
   */ 
  public function isInstalled($c) {
   global $_ST, $scorpions;

   $r      = true;
   $select = "SHOW TABLES LIKE";
   switch($c) {
    case 'codes':
     $select .= " '$_ST[codes]';";
    break;
    case 'kim':
     $select .= " '$_ST[kim]';";
    break;
    case 'lyrics':
     $select .= " '$_ST[lyrics]';";
    break;
    case 'quotes':
     $select .= " '$_ST[quotes]';";
    break;
    case 'updates':
     $select .= " '$_ST[updates]';";
    break;
   }
   $true = $scorpions->query($select);
   if($true == false || $scorpions->total($true) == 0) {
    $r = false;
   }

   return $r;
  }

  /** 
   * Return the addon statistics from the specified addon slug. 
   * 
   * @function  $cheetahs->stats() 
   * @param     $p, string; addon slug 
   * @param     $e, boolean; return string or number 
   */ 
  public function stats($p, $e = 0) {
   global $seahorses, $turtles;

   $r = '';
   if($e == 1) {
    if($p == 'codes') {
     $r .= $this->codeCount() . 
     " codes, with " . $this->codeCount('0', 'id') . " collective codes";
    } elseif ($p == 'kim') {
     $r .= $seahorses->getCount('kim', 'n', 1) . 
     " KIM members, with " . $seahorses->getCount('kim', 'y') . " pending members";
    } elseif ($p == 'lyrics') {
     $r .= $seahorses->getCount('lyrics') . 
     " lyrics, with " . $seahorses->getCount('lyrics', 'a') . " albums";
    } elseif ($p == 'quotes') {
     $r .= $seahorses->getCount('quotes') . " quotes";
    } elseif ($p == 'lyrics') {
     $r .= $seahorses->getCount('updates') . 
     " updates, with " . $seahorses->getCount('updates', 'c') . " collective updates";
    } elseif ($p == 'updates') {
     $r .= count($turtles->updatesList()) . 
     " updates, with " . count($turtles->updatesList('0')) . " collective updates";
    }
   } else {

   }

   return $r;
  }

  /** 
   * @function  $cheetahs->codesList() 
   * @param     $b, string; pull by listing; optional 
   * @param     $i, int; listing ID 
   */ 
  public function codesList($b = 'id', $i = '') {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes]`";
	 if($b == 'listing' && ($i == '0' || $i != '')) {
	  $d = $tigers->cleanMys($i);
	  $select .= " WHERE `fNiq` = '$d'";
	 }
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' codes from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->cID;
   }

   return $all; 
  }

  /** 
   * @function  $cheetahs->donorsList() 
   * @param     $b, string; return array of donors 
   * @since     2.3alpha 
   */ 
  public function donorsList() {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes_donors]` ORDER BY `dName` ASC";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' code donors from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->dID;
   }

   return $all; 
  }

  /** 
   * @function  $cheetahs->sizesList() 
   * @param     $b, string; return array or multidimensional array  
   */ 
  public function sizesList($b = 'id') {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes_sizes]` ORDER BY `sOrder` ASC";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' codes from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    if($b == 'id') {
     $all[] = $getItem->sID;
    } elseif ($b == 'array') {
     $all[] = array('id' => $getItem->sID, 'name' => $getItem->sName);
    }
   }

   return $all; 
  }

  /** 
   * @function  $cheetahs->categoryCodes() 
   * @param     $b, string; return ID array or multidimensional array 
   * @param     $s, int; listing ID; optional 
   */ 
  public function categoryCodes($b = 'id', $s = '') {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes_categories]`";
   if($s != '' && is_numeric($s)) {
    $select .= " WHERE `fNiq` LIKE '%!$s!%'";
   }
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' codes from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    if($b == 'id') {
     $all[] = $getItem->catID;
    } elseif ($b == 'array') {
     $all[] = array('id' => $getItem->catID, 'name' => $getItem->catName);
    }
   }

   return $all; 
  }

  /** 
   * @function  $cheetahs->getCode() 
   * @param     $i, int; code ID 
   */ 
  public function getCode($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes]` WHERE `cID` = '$i' LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' code information from the specified ID.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem; 
  }

  /** 
   * @function    $cheetahs->codeFile() 
   * @param       $i, int; code ID 
   * @deprecated  $this->pullCode(); 2.3alpha 
   */ 
  public function codeFile($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `cFile` FROM `$_ST[codes]` WHERE `cID` = '$i' LIMIT 1";
   $true   = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script was unable to select' . 
    ' the code from the specific listing.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->cFile;
  }

  /** 
   * @function  $cheetahs->getCodeCategory() 
   * @param     $i, int; code category ID 
   */ 
  public function getCodeCategory($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes_categories]` WHERE `catID` = '$i' LIMIT 1";
   $true   = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' category information from the specified ID.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem; 
  }

  /** 
   * @function  $cheetahs->getCodesCatName() 
   * @param     $i, int; code category ID 
   */ 
  public function getCodesCatName($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `catName` FROM `$_ST[codes_categories]` WHERE `catID` =" . 
   " '$i' LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' category name from the database.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->catName; 
  }
	
	/** 
   * @function  $cheetahs->donor() 
   * @param     $i, int; donor ID 
   * @param     $b, string; fetch donor object 
   */ 
  public function donor($i, $b = 'id', $r = '') {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[codes_donors]`";
	 if($b == 'id') {
	  $select .= " WHERE `dID` = '$i'";
	 } elseif ($b == 'email') {
	  $select .= " WHERE `dEmail` = '$i'";
	 }
	 $select .= " LIMIT 1";
   $true   = $scorpions->query($select);
	 if($true == false) {
	  $tigers->displayError('Database Error', 'The script could not select the' . 
    ' donor from the ID specified.', false);
	 }
	 $getItem = $scorpions->obj($true);

   return ($r != '' && $getItem->$r != false ? $getItem->$r : $getItem); 
  }
	
	/** 
   * @function  $cheetahs->getDonor() 
   * @param     $i, int; donor ID 
   * @param     $b, string; fetch donor name or URL 
   */ 
  public function getDonor($i, $b = 'name') {
   global $_ST, $scorpions, $tigers;
	 
	 if($i == 0 || $i == '0') {
	  return "";
	 }
   $p = $b == 'name' ? 'dName' : 'dURL';

   $select = "SELECT `$p` FROM `$_ST[codes_donors]` WHERE `dID` = '$i' LIMIT 1";
   $r = $scorpions->fetch($select, $p);

   return $r; 
  }

  /** 
   * @function  $cheetahs->getSize() 
   * @param     $i, int; size ID 
   */ 
  public function getSize($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `sName` FROM `$_ST[codes_sizes]` WHERE `sID` = '$i' LIMIT 1";
   $true   = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' size name from the database.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->sName; 
  }

  /** 
   * @function  $cheetahs->countCount() 
   * @param     $i, int; listing ID; optional 
   */ 
  public function codeCount($i = '') {
   global $_ST, $scorpions;

   $select = "SELECT * FROM `$_ST[codes]`";
   if($i != '' && is_numeric($i)) {
    $select .= " WHERE `fNiq` = '$i'";
   }
   $r = $scorpions->counts($select, 1, 'The script could not select' . 
   ' the code information from the specified ID.');
   $c = $r->rows;

   return $c; 
  }

  /** 
   * @function  $cheetahs->codesDefault() 
   * 
   * $param     $i, int; listing ID 
   * @param     $t, string; display mode 
   * @param     $n, 
   * @param     $s, string; order by name or ID 
   */ 
  public function codesDefault($i, $t = 'cat', $n, $s) {
   global $_ST, $octopus, $options, $seahorses, $scorpions, $tigers, $wolves;

	 $listing = $wolves->getListings($i, 'object');

   if($t == 'all') {
    $sizes = $this->sizesList('array');
    foreach($sizes as $size) {
	   $query = "SELECT * FROM `$_ST[codes]` WHERE `fNiq` = '$i' AND `cSize`" . 
     " = '" . $size['id'] . "'";
	   if($s == 'name') {
	    $query .= " ORDER BY `cName` ASC";
	   } elseif ($s == 'id') {
	    $query .= " ORDER BY `cID` " . $seahorses->getOption('codes_order');
	   }
     $count  = $scorpions->counts($query);
	   $result = $scorpions->query($query);
	   
     if($result != false && $count->rows > 0) {
		  echo "<h3>" . $size['name'] . "</h3>\n";
	    echo "<div class=\"codesBlock tc\">\n";
	    while($getCodes = $scorpions->obj($result)) {
		   if($getCodes->cDonor == 0) {
		    echo "<img src=\"" . $seahorses->getOption('codes_img_http') . $getCodes->cFile . 
        "\" alt=\"\"$mark>\n"; 
		   } else {
			  if($options->link == 'y') {
		     echo "<a href=\"" . $this->getDonor($getCodes->cDonor, 'url') . "\"><img src=\"" . 
				 $seahorses->getOption('codes_img_http') . $getCodes->cFile . "\" alt=\"Made by: " . 
				 $this->getDonor($getCodes->cDonor) . 
			   " of " . $octopus->shortURL($this->getDonor($getCodes->cDonor, 'url')) . 
         "\" title=\"Made by: " . $this->getDonor($getCodes->cDonor) . 
         " of " . $octopus->shortURL($this->getDonor($getCodes->cDonor, 'url')) . 
				 "\"$mark></a>\n"; 
			  } elseif ($options->link == 'n') {
			   echo "<img src=\"" . $seahorses->getOption('codes_img_http') . $getCodes->cFile . 
         "\" alt=\"\"$mark>\n"; 
			  }
		   }
		  }
	    echo "</div>\n";
	   }
    }
   } 

   elseif ($t == 'list') {
    $select = "SELECT * FROM `$_ST[codes_sizes]` ORDER BY `sOrder` ASC";
    $true = $scorpions->query($select);
    if($true == false) {
     $tigers->displayError('Database Error', 'Unable to select the code' . 
		 ' sizes from the database.', false);
    }
 
    else {
     echo $octopus->alternate('menu', $listing->markup);
     while($getSize = $scorpions->obj($true)) {
	    $sizeid = $getSize->sID;
      $query = $scorpions->query("SELECT * FROM `$_ST[codes]` WHERE `fNiq` =" . 
      " '$i' AND `cSize` = '$sizeid'");
      $count = $scorpions->total($query);
	    if($count > 0) {
	     $v = $n == 'y' ? " ($count)" : "";
			 if($options->prettyURL == true) {
			  echo "<li><a href=\"" . $options->url . "s/" . $getSize->sID . 
        "\">" . $getSize->sName . "</a>$v</li>\n";
			 } else {
	      echo "<li><a href=\"" . $options->url . "s=" . $getSize->sID . 
        "\">" . $getSize->sName . "</a>$v</li>\n";
			 }
	    }
	   }
     $listall = $options->prettyURL == true ? 's/all' : 's=all';
     echo "<li style=\"list-style-type: none;\"><a href=\"" . $options->url . $listall . 
     "\">View All</a></li>\n";
     echo $octopus->alternate('menu', $listing->markup, 1);
    }
 
    /** 
		 * Just... don't ask how I worked this out, TWICE. 
		 */ 
    $select = "SELECT * FROM `$_ST[codes_categories]` WHERE `fNiq` LIKE '%!$i!%'" . 
    " AND `catParent` = '0' ORDER BY `catName` ASC";
    $true = $scorpions->query($select);
    if($true == false) {
     $tigers->displayError('Database Error', 'Unable to select the code' . 
		 ' categories from the database.', false);
    }
 
    else {
     $categories_no_parents = array();
	   $query = "SELECT * FROM `$_ST[codes_categories]` WHERE `fNiq` LIKE '%!$i!%'" . 
     " AND `catParent` = '0' ORDER BY `catName` ASC";
	   $sql = $scorpions->query($query);
	   while($getItem = $scorpions->obj($sql)) {
	    $categories_no_parents[$getItem->catID] = $getItem->catName;
	   }
	
	   if(count($categories_no_parents) > 0) {
	    echo "<h3>Categories</h3>\n";
	    echo $octopus->alternate('menu', $listing->markup);
	    foreach($categories_no_parents as $k => $v) {
	     $e = "SELECT * FROM `$_ST[codes]` WHERE `fNiq` = '$i' AND `cCategory` = '$k'";
		   $m = $scorpions->query($e);
	     if($scorpions->total($m) > 0) {
			  if($options->prettyURL == 'y') {
			   echo "<li><a href=\"" . $listing->url . $options->url . "c/" . $k . 
         "\">$v</a></li>\n";
			  } else {
	       echo "<li><a href=\"" . $options->url . "c=" . $k . "\">$v</a></li>\n";
				}
		   } else {
		    echo "<li>" . $v . "</li>\n";
		   }
	 
	     $q = "SELECT * FROM `$_ST[codes_categories]` WHERE `fNiq` LIKE '%!$i!%'" . 
		   " AND `catParent` = '$k' ORDER BY `catName` ASC";
	     $s = $scorpions->query($q);
	     if($scorpions->total($s) > 0) {
	      echo " <li style=\"list-style-type: none;\">\n";
		    echo "  " . $octopus->alternate('menu', $_LES['markup']);
		    while($item = $scorpions->obj($s)) {
				 if($options->prettyURL == 'y') {
			    echo "   <li><a href=\"" . $listing->url . $options->url . 
          "c/" . $item->catID . "\">" . $item->catName . "</a></li>\n";
			   } else {
		      echo "   <li><a href=\"" . $options->url . "c=" . $item->catID . 
          "\">" . $item->catName . "</a></li>\n";
				 }
		    }
		    echo "  " . $octopus->alternate('menu', $listing->markup, 1);
		    echo " </li>\n";
	     } 
	    }
	    echo $octopus->alternate('menu', $listing->markup, 1);
	   }
    }
   }
	}

  /** 
   * @function  $cheetahs->lyricsList() 
   * @param     $i, int; listing ID 
   */ 
  public function lyricsList($i = '', $b = 'lyrics') {
   global $_ST, $scorpions, $tigers, $wolves;

   $a = $b == 'lyrics' ? $_ST['lyrics'] : $_ST['lyrics_albums'];
   $s = $b == 'lyrics' ? "`lyName`" : "`aArtist`, `aName`";
   $select = "SELECT * FROM `$a`";
   if($i != '' && in_array($i, $wolves->listingsList())) {
    $select .= " WHERE `fNiq` = '$i'";
   }
   $select .= " ORDER BY $s ASC";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select' . 
		' the lyrics from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->lyID;
   }

   return $all;
  }
	
	/** 
   * @function  $cheetahs->albumsList() 
   * @param     $i, int; listing ID 
   */ 
  public function albumsList($i = '') {
   global $_ST, $scorpions, $tigers, $wolves;

   $select = "SELECT * FROM `$_ST[lyrics_albums]`";
   if($i != '' && in_array($i, $wolves->listingsList())) {
    $select .= " WHERE `fNiq` = '$i'";
   }
   $select .= " ORDER BY `aArtist` ASC";
   $true    = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select' . 
		' the albums from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->aID;
   }

   return $all;
  }

  /** 
   * @function  $cheetahs->getAlbum() 
   * @param     $i, int; album ID 
   */ 
  public function getAlbum($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `aName` FROM `$_ST[lyrics_albums]` WHERE `aID` = '$i'" . 
   " LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select' . 
		' the album name from the database.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->aName; 
  }

  /** 
   *  @function   $cheetahs->defaultLyrics() 
   *  @param      $i, int; listing ID 
   *  @param      $a, int; album ID 
   */ 
  public function defaultLyrics($i, $a = '') {
   global $_ST, $options, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[lyrics]` WHERE `fNiq` = '$i'"; 
   if($a != '' && in_array($a, $this->albumsList())) {
    $select .= " AND `aNiq` = '$a' ORDER BY `lyID` ASC";
   } else {
	  $select .= " ORDER BY `lyName` ASC";
	 }
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script was unable to' . 
		' select the lyrics from the specified listing.', false);
   }

   if($a != '' && in_array($a, $this->albumsList())) {
    echo "<ol>\n";
    while($getItem = $scorpions->obj($true)) {
     echo "<li><a href=\"" . $options->url . "ly=" . $getItem->lyID . 
     "\">" . $getItem->lyName . "</a></li>\n";
    }
	  echo "</ol>";
   } else {
    while($getItem = $scorpions->obj($true)) {
	   $albumid = $getItem->aID;
	   $q2 = "SELECT * FROM `$_ST[lyrics]` WHERE `fNiq` = '$i' AND `aNiq` =" . 
     " '$albumid' ORDER BY `lyID` ASC";
	   echo "<h4>" . $getItem->aName . "</h4>\n";
	   echo "<ol>\n";
	   while($getItem2 = $scorpions->obj($scorpions->query($q2))) {
	    echo "<li><a href=\"" . $options->url . "ly=" . $getItem2->lyID . 
      "\">" . $getItem2->lyName . "</a></li>\n";
	   }
	   echo "</ol>\n";
	  }
   }
  }

  /** 
   * @function  $cheetahs->quotesList() 
   * @param     $s, int; listing ID; optional 
   * @since     2.3alpha 
   */ 
  public function quotesList($s = '') {
   global $_ST, $scorpions, $tigers, $wolves;

   $select = "SELECT * FROM `$_ST[quotes]`";
   if($s != '' && in_array($s, $wolves->listingsList())) {
    $select .= " WHERE `fNiq` = '$s'";
   }
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' quotes from the database.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->qID; 
   }

   return $all; 
  }

  /** 
   * @function  $cheetahs->pullQuotes() 
   * 
   * @param     $i, int; listing ID 
   * @param     $r, boolean; 1 (true) for rotation, 0 (false) for 
   * non-rotation of quotes 
   * @param     $n, int; number of quotes to display 
   */ 
  public function pullQuotes($i, $r = 1, $n) {
   global $_ST, $scorpions, $tigers, $wolves;

   $select = "SELECT * FROM `$_ST[quotes]` WHERE `fNiq` = '$i'";
   if($r == 1) {
    $select .= " ORDER BY RAND()";
   }
   $select .= " LIMIT 0, $n";
   $true    = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script cannot select the' . 
    ' quotes from the specified listing.', false);
   }
	 
	 $template = html_entity_decode($wolves->getListingTemplate($i, 'quotes'));
	 $format   = '';
	 while($getItem = $scorpions->obj($true)) {
    $string  = str_replace('{quote}', $getItem->qQuote, $template);
    $format .= str_replace('{author}', $getItem->qAuthor, $string);
	 }

   return $format;
  }
 
  # End functiooooons~ 
 }
}

$cheetahs = new cheetahs();
