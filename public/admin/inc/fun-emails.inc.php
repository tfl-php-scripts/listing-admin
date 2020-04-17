<?php
/** 
 * @copyright  2007 
 * @license    GPL Version 3; BSD Modified 
 * @author     Tess <treibend@gmail.com> 
 * @file       <fun-emails.inc.php> 
 * @since      September 2nd, 2010 
 * @version    2.1  
 */ 

if(class_exists('jaguars') == false) {
 class jaguars {
 
  /** 
   * @function  $jaguars->emailList() 
   */ 
  public function emailList() {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT * FROM `$_ST[templates_emails]` ORDER BY `name` ASC";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'Could not select the email' . 
		' templates from the database.', true, $select);
   }

   $all = array();
   while($getItem = $scorpions->obj($true)) {
    $all[] = $getItem->name;
   }

   return $all; 
  }

  # -- Approve KIM Member (Mass-Approving) Function -----------
  # -----------------------------------------------------------
  public function approveKIM($i) {
   global $my_email, $qowns, $kimadmin, $wolves, $seahorses, $tigers;

   $memberfl = $kimadmin->getMember($i, 'id', 'object');
   $glisting = $wolves->getListings($memberfl->fNiq, 'object');
   $template = $this->getEmailTemplate('kim_approve');

   $subject = $seahorses->getOption('collective_name'). " KIM: Added";

   $format = str_replace('{name}', $memberfl->mName, $template);
   $format = str_replace('{listing}', $glisting->subject, $format);
   $format = str_replace('{listing_title}', $tigers->replaceSpec($glisting->title), $format);
   $format = str_replace('{listing_url}', $glisting->url, $format);
   $format = str_replace('{title}', $tigers->replaceSpec($glisting->title), $format);
   $format = str_replace('{owner}', $seahorses->getOption('my_name'), $format);
   $format = str_replace('{collective_name}', $seahorses->getOption('collective_name'), $format);
   $format = str_replace('{collective_url}', $seahorses->getOption('my_website'), $format);
   $format = str_replace('{kim_join}', $seahorses->getOption('kim_join'), $format);
   $format = str_replace('{kim_list}', $seahorses->getOption('kim_list'), $format);
   $format = str_replace('{kim_reset}', $seahorses->getOption('kim_reset'), $format);
   $format = str_replace('{kim_update}', $seahorses->getOption('kim_update'), $format);
   $body = $format;

   $headers = "From: $qowns <$my_email>\n";
   $headers .= "Reply-To: <$my_email>";

   if(@mail($memberfl->mEmail, $subject, $body, $headers)) {
    $r = true;
   } else {
    $r = false;
   }

   return $r;
  }

  # -- Approve Member (Mass-Approving) Function ---------------
	/** 
	 $i = Member ID 
	 $d = Listing ID (optional) 
	 $c = Are we crosslisting? (optional) 
	 $p = Script type (optional) 
	*/
  # -----------------------------------------------------------
  public function approveMember($i, $d = '', $c = '', $p = '') {
   global $my_email, $qowns, $wolves, $snakes, $seahorses, $tigers;

	 $m = $c != '' && $c == 1 && $p == 'enth' ? 'email' : 'id';
	 $s = $d != '' && is_numeric($d) && in_array($d, $wolves->listingsList()) ? $d : '';
	 if($d != '') {
	  $glisting = $wolves->getListings($d, 'object');
		$memberfl = $snakes->getMembers($i, $m, 'object', $s);
	 } else {
	  $memberfl = $snakes->getMembers($i, $m, 'object', $s);
	  $glisting = $wolves->getListings($memberfl->fNiq, 'object');
	 }
   $template = $this->getEmailTemplate('members_approve');

   $subject = $glisting->subject. ": Added";

   $format = str_replace('{name}', $memberfl->mName, $template);
   $format = str_replace('{listing}', $glisting->subject, $format);
   $format = str_replace('{listing_title}', $tigers->replaceSpec($glisting->title), $format);
   $format = str_replace('{listing_url}', $glisting->url, $format);
   $format = str_replace('{title}', $tigers->replaceSpec($glisting->title), $format);
   $format = str_replace('{owner}', $seahorses->getOption('my_name'), $format);
   $format = str_replace('{collective_name}', $seahorses->getOption('collective_name'), $format);
   $format = str_replace('{collective_url}', $seahorses->getOption('my_website'), $format);
   $body = $format;

   $headers = "From: $qowns <$my_email>\n";
   $headers .= "Reply-To: <$my_email>";

   if(mail($memberfl->mEmail, $subject, $body, $headers)) {
    $r = true;
   } else {
    $r = false;
   }

   return $r;
  }

  /** 
   * @function  $jaguars->getEmailTemplate() 
   * @param     $p, string; template slug 
   */ 
  public function getEmailTemplate($p) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `template` FROM `$_ST[templates_emails]` WHERE `name` =" . 
   " '$p' LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select' . 
		' the specified template from the database.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->template;
  }

  /** 
   * @function  $jaguars->getEmailTitle() 
   * @param     $p, string; template slug 
   */ 
  public function getEmailTitle($p) {
   global $_ST, $scorpions, $tigers;

   $select = "SELECT `title` FROM `$_ST[templates_emails]` WHERE `name` = '$p' LIMIT 1";
   $true = $scorpions->query($select);
   if($true == false) {
    $tigers->displayError('Database Error', 'The script could not select' . 
		' the specified title template from the database.', false);
   }
   $getItem = $scorpions->obj($true);

   return $getItem->title;
  }

	/** 
   * @function  $jaguars->sendEmail() 
   * 
   * @param     $t, string; template slug 
   * @param     $f, string; collective or listing 
   * @param     $i, int; affiliate ID 
   * @param     $b, string; message subject line  
   * @param     $o, text; message body; optional 
   * @param     $l, int; listing ID; optional 
   * @param     $s, string; message subject; optional  
   * @param     $u, string; message URL; optional 
   * @param     $e, text; message e-mail; optional 
   * @param     $c, string; grab member from ID or e-mail 
	 */ 
  public function sendEmail(
	 $t, 
	 $f = 'listing', 
	 $i = 'n', 
	 $b, 
	 $o = 'n', 
	 $l = 'n', 
	 $s = 'n', 
	 $u = 'n', 
	 $e = 'n',
	 $c = 'id'
	) {
   global $_ST, $wolves, $snakes, $seahorses, $tigers, $my_email, 
	 $qname, $qowns, $qwebs;

   /** 
	  If we're dealing with collective, we're not pulling affiliate or listing 
		objects 
	 */ 
	 if($l != 'n') {
    if($i != 'n') {
		 $d = $tigers->cleanMys($i, 'y', 'y', 'n');
	   $glistings = $wolves->getListings($l, 'object');
     $memberfl = $snakes->getMembers($d, $c, 'object', $l);
		} else {
		 $glistings = $wolves->getListings($l, 'object');
		}
   }

   $template = $t != 'n' ? $this->getEmailTemplate($t) : trim($o);
	 
	 $h = $b == 'n' ? ($t == 'n' ? '' : ": " . $this->getEmailTitle($t)) : ": " . $b;
	 $subject = $f == 'collective' ? $qname . ": " . $b : $glistings->subject . $h;
   $w = $f == 'collective' ? $qname . " collective" : $glistings->subject . " listing";
   $url = $f == 'collective' ? $qwebs : $glistings->url;
   $title = $f == 'collective' ? $qname : $glistings->title;
   $listing = $f == 'collective' ? $qname : $glistings->subject;
   $r = !empty($memberfl->mURL) ? "<" . $memberfl->mURL . ">" : "";
	 
   $format = str_replace(
    '{name}', $memberfl->mName, html_entity_decode($template, ENT_QUOTES, 'ISO-8859-15')
   );
   $format = str_replace('{email}', $memberfl->mEmail, $format);
   $format = str_replace('{url}', $r, $format);
   $format = str_replace('{which}', $w, $format);
   $format = str_replace('{type}', $f, $format); 
   $format = str_replace('{listing}', $listing, $format);
   $format = str_replace('{listing_title}', $title, $format);
   $format = str_replace('{listing_url}', $url, $format);
   $format = str_replace('{owner}', $seahorses->getOption('my_name'), $format);
   $body = $format;

   $headers = "From: $qowns <$my_email>\n";
   $headers .= "Reply-To: <$my_email>";
	 
	 $email = $e != 'n' ? $memberfl->mEmail : $e;
   if(mail($email, $subject, $body, $headers)) {
    $n = true;
   } else {
    $n = false;
   }

   return $n;
  }

  /** 
	 * This differs from sendEmail() due to different database structures 
	 * for affiliates and members; markup created for table-wide use, or for 
	 * individual use. 
   * 
   * @param  $t = Template 
   * @param  $f = Form (collective, listing)
   * @param  $i = Affiliate ID 
   * @param  $b = Subject Line 
   * @param  $o = Body 
   * @param  $l = Listing 
   * @param  $s = Subject 
   * @param  $u = URL 
   * @param  $e = E-Mail 
	 */ 
  public function sendAffEmail($t, $f = 'listing', $i = 'n', $b, $o = 'n', 
	$l = 'n', $s = 'n', $u = 'n', $e = 'n') {
   global $_ST, $rabbits, $wolves, $seahorses, $qname, $my_email, $qowns;

	 /** 
	  * If we're dealing with collective, we're not pulling affiliate or 
		* listing objects 
	  */ 
	 if($l != 'n') {
    if($i != 'n' && ctype_digit($i)) {
	   $glistings = $wolves->getListings($l, 'object');
     $affiliate = $rabbits->getAffiliate($i, 'id', $l);
		} else {
		 $glistings = $wolves->getListings($l, 'object');
		}
   }

   if($t != 'n') {
    $template = $this->getEmailTemplate($t);
   } else {
    $template = trim($o);
   }
   
	 $h = $b == 'n' ? ($t == 'n' ? '' : ": " . $this->getEmailTitle($t)) : ": " . $b;
	 $subject = $f == 'collective' ? $qname . ": " . $b : $glistings->subject . $h;
   $w = $f == 'collective' ? $qname . " collective" : $glistings->subject . " listing";

   $r = $u != 'n' ? '<' . $u . '>' : '<' . $affiliate->aURL . '>'; 
   $k = $f == 'collective' ? $qname : $glistings->subject;
   $c = $f == 'collective' ? $seahorses->getOption('my_website') : $glistings->url;

   $format = str_replace(
    '{subject}', $affiliate->aSubject, html_entity_decode($template, ENT_QUOTES, 'ISO-8859-15')
   );
   $format = str_replace('{email}', $a, $format);
   $format = str_replace('{url}', $r, $format);
   $format = str_replace('{which}', $w, $format);
   $format = str_replace('{type}', $f, $format); 
   $format = str_replace('{listing}', $glistings->subject, $format);
   $format = str_replace('{listing_title}', $k, $format);
   $format = str_replace('{listing_url}', $c, $format);
   $format = str_replace('{owner}', $seahorses->getOption('my_name'), $format);
   $body = $format;

   $headers = "From: $qowns <$my_email>\n";
   $headers .= "Reply-To: <$my_email>";

   $email = $e != 'n' ? $e : $affiliate->aEmail;
   if(mail($email, $subject, $body, $headers)) {
    $n = true;
   } else {
    $n = false;
   }

   return $n;
  }

  /** 
	 * Pointless function is pointless. 
	 * 
	 * @function  $jaguars->sendMeMail() 
	 */ 
  public function sendMeMail($m, $s, $h) {
   global $my_email;

   if(mail($my_email, $s, $m, $h)) {
    $r = true;
   } else {
    $r = true;
   }

   return $r;
  }

  /** 
	 * @function  $jaguars->updateKIM() 
	 */ 
  public function updateKIM($i) {
   global $kimadmin, $wolves, $seahorses, $my_email, $qowns;

   $memberfl = $kimadmin->getMember($i, 'id', 'object');
   $glisting = $wolves->getListings($memberfl->fNiq, 'object');
   $template = $this->getEmailTemplate('kim_update');

   $subject = $seahorses->getOption('collective_name'). " KIM: Updated";

   $u = !empty($memberfl->mURL) ? "<" . $memberfl->mURL . ">" : "";
   $format = str_replace('{name}', $memberfl->mName, $template);
   $format = str_replace('{email}', $memberfl->mEmail, $format);
   $format = str_replace('{url}', $u, $format);
   $format = str_replace('{listing}', $glisting->subject, $format);
   $format = str_replace('{listing_title}', $glisting->title, $format);
   $format = str_replace('{listing_url}', $glisting->url, $format);
   $format = str_replace('{owner}', $seahorses->getOption('my_name'), $format);
   $format = str_replace('{collective_name}', $seahorses->getOption('collective_name'), $format);
   $format = str_replace('{collective_url}', $seahorses->getOption('my_website'), $format);
   $body = $format;

   $headers = "From: $qowns <$my_email>\n";
   $headers .= "Reply-To: <$my_email>";

   if(@mail($memberfl->mEmail, $subject, $body, $headers)) {
    $r = true;
   } else {
    $r = true;
   }

   return $r;
  }

  # -- Update Member Function ---------------------------------
  # -----------------------------------------------------------
  public function updateMember($i, $d = '') {
   global $connect, $wolves, $seahorses, $snakes, $tigers, 
	 $my_email, $qowns;

	 if($d != '' && is_numeric($d)) {
	  $glisting = $wolves->getListings($d, 'object');
    $memberfl = $snakes->getMembers($i, 'id', 'object', $d);
	 } else {
    $memberfl = $snakes->getMembers($i, 'id', 'object');
		$glisting = $wolves->getListings($memberfl->fNiq, 'object');
	 }
   $template = $this->getEmailTemplate('members_update');

   $subject = $glisting->subject. ": Updated";

   $u = !empty($memberfl->mURL) ? "<" . $memberfl->mURL . ">" : "";
   $format = str_replace('{name}', $memberfl->mName, $template);
   $format = str_replace('{email}', $memberfl->mEmail, $format);
   $format = str_replace('{url}', $u, $format);
   $format = str_replace('{country}', $memberfl->mCountry, $format);
   $format = str_replace('{listing}', $glisting->subject, $format);
   $format = str_replace('{listing_title}', $glisting->title, $format);
   $format = str_replace('{listing_url}', $glisting->url, $format);
   $format = str_replace('{owner}', $seahorses->getOption('my_name'), $format);
   $body = $format;

   $headers = "From: $qowns <$my_email>\n";
   $headers .= "Reply-To: <$my_email>";

   if(mail($memberfl->mEmail, $subject, $body, $headers)) {
    $r = true;
   } else {
    $r = true;
   }

   return $r;
  }
	
	# Functions end harrrr~ 
 }
}

$jaguars = new jaguars();
?>
