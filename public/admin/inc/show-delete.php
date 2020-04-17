<div id="show-delete">
<?php
/** 
 * @copyright  2007 
 * @license    GPL Version 3; BSD Modified 
 * @author     Tess <treibend@gmail.com> 
 * @file       <show-delete.php> 
 * @since      September 2nd, 2010  
 * @version    2.1+   
 */ 
require("b.inc.php");
require(MAINDIR . "rats.inc.php");
require_once("class-antispam.inc.php");
require_once("fun.inc.php");
require_once("fun-external.inc.php");
require_once("fun-listings.inc.php");
require_once("fun-members.inc.php");
require_once("fun-misc.inc.php");
require(MAINDIR . "vars.inc.php");

/** 
 * Get variables and options~! 
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

if($getItem->markup == 'xhtml') {
 $options->markup = " /";
} else {
 $options->markup = "";
}

/** 
 * The form has been set, so let's check the variables~  
 */ 
if(isset($_POST['action']) && $_POST['action'] == 'Delete Me') {
 $email = $tigers->cleanMys($_POST['email']);
 if(empty($email)) {
  $tigers->displayError('Form Error', 'The <samp>email</samp> field has not been' . 
  ' filled out.', false);
 } elseif (!preg_match("/([A-Za-z0-9-_\.]+)@(([A-Za-z0-9-_]+\.)+)([a-zA-Z]{2,4})$/i", $email)) {
  $tigers->displayError('Form Error', 'The characters specified in the <samp>' . 
  'e-mail</samp> field are not allowed.', false); 
 }
 $password = $tigers->cleanMys($_POST['password']);
 if($snakes->checkReset($email, $options->listingID) == false) {
  $tigers->displayError('Script Error', 'It appears your email is not' . 
	' listed at this listing. This might be because you are not a member, or you' . 
	' have chosen the wrong e-mail address.', false);
 }

 /** 
  * Grab user information so we can log messages 
  */ 
 $userinfo = (object) array(
  'url'  => $tigers->cleanMys(
   'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['PHP_SELF']
  ),
  'text' => "E-Mail Address: $email"
 );

 /** 
  * Initiate the checks! 
  */ 
 foreach($laantispam->spamarray() as $b) {
  if(strpos($_POST, $b) !== false) {
	 $octopus->writeError(
    'SPAM Error: SPAM Language', $userinfo->url, $userinfo->text, $spInfo
   );
	 $tigers->displayError('SPAM Error', 'SPAM language is not allowed.', false);
  }
 }

 if(
  preg_match($badheaders, $_SERVER['HTTP_USER_AGENT']) || 
  empty($_SERVER['HTTP_USER_AGENT'])
 ) {
  $tigers->displayError('SPAM Error', 'SPAM bots are not allowed.', false);
 }

 if($seahorses->getOption('javascript_opt') == 'y') {
  if(
   !isset($_POST[$octopus->cheatJavascript]) || 
   $_POST[$octopus->cheatJavascript] != sha1($seahorses->getOption('javascript_key'))
  ) {
   $tigers->displayError('Script Error', 'It appears you have JavaScript' . 
	 ' turned off. As it is required to have JavaScript enabled, I suggest you go' . 
	 ' back and enable it.', false);
  }
 }

 /** 
  * Since everything's A-OK, let's delete the member :D 
  */ 
 $select = "SELECT * FROM `$_ST[members]` WHERE `fNiq` = '" . $options->listingID . 
 "' AND `mEmail` = '$email' AND `mPassword` = MD5('$password')";
 $true = $scorpions->query($select);
 if($true == true && $scorpions->total($true) == 1) {
  $getMember = $scorpions->obj($true);
  $delete    = "DELETE FROM `$_ST[members]` WHERE `mID` = '" . $getMember->mID . "' LIMIT 1";
	$result    = $scorpions->query($delete);
	if($result == true) {
	 echo "<p class=\"successButton\"><span class=\"success\">Success!</span> You" . 
   " have been successfully deleted from the listing!</p>\n";
	}
 } else {
  $tigers->displayError('Database Error', 'The script was unable to pull your' . 
  ' information from the database. Please make sure your information is correct.', 
  false);
 }
}

else {
 $mark = $getItem->markup == 'xhtml' ? " /" : '';
 $d2   = $octopus->formURL('delete', $getItem);
?>
<p>Please use the form below for deletion only. The e-mail and password you 
provide are checked against the database to ensure you are not wrongly deleted 
from the listing. If the form does not work for you, or you have lost access to 
your current e-mail account, you can e-mail me <?php echo $hide_address; ?> and 
ask me to delete you from the listing.</p>

<form action="<?php echo $d2; ?>" method="post">
<?php 
if($seahorses->getOption('javascript_opt') == 'y') {
 echo $octopus->javascriptCheat(sha1($seahorses->getOption('javascript_key'))); 
} 
?>
<fieldset>
 <legend>Delete</legend>
 <p><label>* <strong>E-mail:</strong></label> 
 <input name="email" class="input1" type="text"<?php echo $mark; ?>></p>
 <p><label>* <strong>Password:</strong></label> 
 <input name="password" class="input1" type="password"<?php echo $mark; ?>></p>
 <p class="tc">
  <input name="action" class="input2" type="submit" value="Delete Me"<?php echo $mark; ?>> 
  <input class="input2" type="reset" value="Reset"<?php echo $mark; ?>>
 </p>
</fieldset>
</form>

<p class="showCredit" style="text-align: center;">
 Powered by <?php echo $octopus->formatCredit(); ?>
</p>
<?php 
}
?>
</div>
