<?php 
/**  
 * KIM Admin (c) 2008 Tess <treibend@gmail.com> 
 *  
 * @script  KIM Admin  
 * @author  Tess <treibend@gmail.com> 
 * @license GPL Version 3, Modified BSD License  
 * @file    <class-kimadmin.inc.php> 
 * @since   May 4th, 2011 
 * @version 1.2  
 * 
 * Copyright (C) 2008 Tess <http://scripts.wyngs.net/> 
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */  

if(class_exists('kimadmin') == false) {
 class kimadmin {

  /** 
   * @function  $kimadmin->membersList() 
   * @param     $i, int; listing ID; optional 
   * @param     $p, int; 0 for approved, 1 for all members; optional 
   */ 
  public function membersList($i = '', $p = '') {
   global $_ST, $get_type_id_array, $scorpions, $tigers, $wolves;

	 $select = "SELECT * FROM `$_ST[kim]`";
   if(in_array($i, $wolves->listingsList())) {
    $select .= " WHERE `fNiq` = '$i'";
    if($p == 0 || $p == '0') {
     $select .= " AND `mPending` = '0'";
    } elseif ($p == 1) {
     $select .= " AND `mPending` = '1'";
    }
   } else {
    if($p == 0 || $p == '0') {
     $select .= " WHERE `mPending` = '0'";
    } elseif ($p == 1) {
     $select .= " WHERE `mPending` = '1'";
    }
   }
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script was unable to select' . 
    ' the members.', false);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->mID;
   }

   return $all;
  } 

  /** 
   * @function  $kimadmin->getMember() 
   * 
   * @param     $i, int; member ID 
   * @param     $p, string; get member by ID or e-mail 
   * @param     $e, int; listing ID 
   */ 
  public function getMember($i, $p = 'id', $e = '') {
   global $_ST, $scorpions, $tigers, $wolves;

   $select = "SELECT * FROM `$_ST[kim]`";
   if($p == 'id') { 
    $select .= " WHERE `mID` = '$i'";
   } elseif ($p == 'email' && in_array($e, $wolves->listingsList())) {
    $select .= " WHERE `mEmail` = '$i' AND `fNiq` = '$e'";
   }
   $select .= " LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script was unable to select' . 
    ' the specified member.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem;
  }

  /** 
   * @function  $kimadmin->kimName() 
   * @param     $i, int; member ID 
   */ 
  public function kimName($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `mName` FROM `$_ST[kim]` WHERE `mID` = '$i' LIMIT 1";
   $true   = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' member name from the database.', true, $select);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->mName; 
  }

  /** 
   * @function  $kimadmin->kimCount() 
   * @param     $s, boolean; 0 for approved, 1 for pending 
   */ 
  public function kimCount($s = 0) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[kim]`";
   if($s == 0) {
    $select .= " WHERE `mPending` = '0'";
   } elseif ($s == 1) {
    $select .= " WHERE `mPending` = '1'";
   }
	 $true = $scorpions->query($select);
	 if($true == false) {
    $tigers->displayError('Database Error', 'The script cannot select the' . 
    ' member count from the database.', false);
   }
   $count = $scorpions->total($true);

   return $count;
  }

  /** 
   * Get latest update date from members 
   * 
   * @function  $kimadmin->kimUpdate() 
   */ 
  public function kimUpdate() {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `mAdd` FROM `$_ST[kim]` WHERE `mPending` = '0' ORDER BY" . 
   " `mAdd` DESC LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script cannot select the' . 
    ' date of last updated KIM member', false);
   }
   $getItem = $scorpions->obj($true);

   $r = empty($getItem->mAdd) || $getItem->mAdd == '0000-00-00' ? 
	 'Date Unavailable' : date('F jS, Y', strtotime($getItem->mAdd));

   return $r;
  }

  /** 
   * @function  $kimadmin->checkPassword() 
   *  
   * @param     $e, string; member e-mail 
   * @param     $p, string; member password 
   * @param     $s, int; listing ID 
   */ 
  public function checkPassword($e, $p, $s) {
   global $_ST, $scorpions;

	 $valid = (object) array(
	  'email' => false,
		'password' => false
	 );
	 
   $select = "SELECT * FROM `$_ST[kim]` WHERE `mEmail` = '$e' AND `fNiq`" . 
	 " = '$s'";
   $count = $scorpions->counts($select);
   if($count->rows == 1) {
    $valid->email = true;
   }

   $m     = md5($p);
   $query = "SELECT * FROM `$_ST[kim]` WHERE `mEmail` = '$e' AND `fNiq` =" . 
	 " '$s' AND `mPassword` = '$m'";
   $results = $scorpions->counts($query);
   if($results->rows == 1) {
    $valid->password = true;
   } 
 
   return $valid;
  }

  /** 
   * @function  $kimadmin->checkKIM() 
   * @param     $i, int; member ID 
   */ 
  public function checkKIM($i) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[kim]` WHERE `fNiq` = '$i' AND `mPending` = '0'";
   $count  = $scorpions->counts($select);
   if($count->status == false) {
    $tigers->displayError('Database Error', 'The script could not select the' . 
    ' listings from the database.', false);
   }

	 $valid = true;
   if($count->rows == 0) {
    $valid = false;
   } 
 
   return $valid;
  }

  /** 
   * @function  $kimadmin->checkReset() 
   * @param     $e, string; member e-mail 
   * @param     $s, int; listing ID 
   */ 
  public function checkReset($e, $s) {
   global $_ST, $scorpions;

   $select = "SELECT * FROM `$_ST[kim]` WHERE `mEmail` = '$e' AND `fNiq` = '$s'";
   $count  = $scorpions->counts($select);

	 $valid = false;
   if($count->rows == 1) {
    $valid = true;
   } 
	
   return $valid;
  }
	
	/** 
   * Format a member for the members list 
   * 
   * @function  $kimadmin->format() 
   * 
   * @param     $i, int; listing ID 
   * @param     $t, string; template slug 
   * @param     $m, int; member ID 
   * @param     $e, string; pull member by ID or e-mail 
   */ 
  public function format($i, $t, $m = '', $e = 'id') {
   global $_ST, $octopus, $options, $scorpions, $seahorses, $tigers, $wolves;

	 $listing  = $wolves->getListings($i, 'object');
   $mark     = $listing->markup == 'xhtml' ? " /" : '';
	 $template = '';
   switch($t) {
    case 'members':
     $template = "<li>{name}<br$mark>\n{email} &amp;#8212; {url}<br$mark>\n" . 
		 "Previous Owner: {previous}</li>\n";
    break;
    case 'members_header':
     $template = $octopus->alternate('menu', $seahorses->getOption('markup'));
    break;
    case 'members_footer':
     $template = $octopus->alternate('menu', $seahorses->getOption('markup'), 1);
    break;
   }

	 $format = $template;
   if($m != '') {
    $member = $this->getMember($m);
    if($member->mVisible == 0) {
     $email = $octopus->javascriptEmail($member->mEmail);
    } else {
     $email = "<del>E-mail</del>";
		}
 
    if(!empty($member->mURL)) {
     $url = "<a href=\"" . $member->mURL . "\" title=\"External Link: " . 
		 $octopus->shortURL($member->mURL) . "\">URL &#187;</a>";
    } else {
     $url = "<del>URL</del>";
    }
		
		$prev   = $member->mPrevious == 1 || $member->mPrevious == '1' ? "Yes" : "No";
    $format = str_replace('{name}', $member->mName, str_replace('&amp;', '&', $format));
    $format = str_replace('{email}', $email, $format);
    $format = str_replace('{url}', $url, $format);
		$format = str_replace('{previous}', $prev, $format);
	 }

   return $format;
  }
	
	/** 
   * @function  $kimadmin->membersPagination() 
   * @param     $i, int; listing ID 
   */ 
  public function membersPagination($i) {
   global $options, $page, $per_page, $scorpions, $start, $tiger, $wolves;
	 
   echo "<p id=\"pagination\">\n";
	 $true  = $this->membersList($i, 0);
   $pages = ceil(count($members) / $per_page);
	 $next  = $options->page + 1;
	 $prev  = $options->page - 1;
 
   if($page > 1) {
	  if($options->prettyURL == true) {
		 echo '<a href="' . $options->url . 'page/' . $prev . '">&#171; Previous</a> ';
		} else {
     echo '<a href="' . $options->url . 'page=' . $prev . '">&#171; Previous</a> ';
		}
   } else {
    echo '&#171; Previous ';
   }

   for($i = 1; $i <= $pages; $i++) {
    if($page == $i) {
     echo $i . " ";
    } else {
		 if($options->prettyURL == true) {
		  echo '<a href="' . $options->url . 'page/' . $i . '">' . $i . '</a> ';
		 } else {
      echo '<a href="' . $options->url . 'page=' . $i . '">' . $i . '</a> ';
		 }
    } 
   }
		
   if($page < $pages) {
	  if($options->prettyURL == true) {
		 echo '<a href="' . $options->url . 'page/' . $next . '">Next &#187;</a>';
		} else {
     echo '<a href="' . $options->url . 'page=' . $next . '">Next &#187;</a>';
		}
   } else {
    echo 'Next &#187;';
   }
   echo "\n</p>\n";
  }

  /**  
   * Sort members by country, name, or both 
   * 
   * @function  $snakes->membersSort() 
   */ 
  public function membersSort($i) {
   global $_ST, $options, $per_page, $scorpions, $start, $tigers, 
   $wolves;
 
   $countfls = count($this->membersList($i, '0'));
   $listing  = $wolves->getListings($i, 'object');

   $select = "SELECT * FROM `$_ST[kim]` WHERE `fNiq` = '$i' AND `mPending` =" . 
	 " '0' ORDER BY `mName` ASC LIMIT " . $options->start . ", $countfls";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Script Error', 'The script was unable to select' . 
		' the KIM members from the specified listing.', false);
   }
	
   echo "<p class=\"tc\">You are viewing KIM members from the listing," . 
	 " <strong>" . $listing->subject . 
	 "</strong>.</p>\n" . $this->format($options->listingID, 'members_header');
	 while($getItem = $scorpions->obj($true)) {
	  echo $this->format($options->listingID, 'members', $getItem->mID);
	 }
	 echo $this->format($options->listingID, 'members_footer');
  }

  /** 
   * Display KIM members :D 
   * 
   * @function  $kimadmin->kimDefault() 
   */ 
  public function kimDefault($s = 'listing') {
   global $_ST, $octopus, $options, $scorpions, $seahorses, $tigers, $wolves;
 
   if($s == 'listing') {
    $_a = $wolves->listingsList('subject');
 
    echo $octopus->alternate('menu', $seahorses->getOption('markup'));
    foreach($_a as $a) {
     if($this->checkKim($a) == true) {
	    echo '<li><a href="' . $options->url . 'sort=' . $a . '">' . $wolves->getSubject($a) . 
      "</a></li>\n";
     }
    } 
    echo '<li style="list-style-type: none;"><a href="' . $options->url . 
    'sort=byListing' . ($seahorses->getOption('markup') == 'html5' ? '&#38;' : 
    '&amp;') . 'id=all">All Listings</a>' . "</li>\n";
    echo $octopus->alternate('menu', $seahorses->getOption('markup'), 1);
   }
  }
	
	# End functions list :D 
 }
}

$kimadmin = new kimadmin();
?>
