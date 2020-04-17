<?php  
/* 
 /////////////////////////////////////////////////////////////
 Listing Admin (c) 2007 
 ///////////////////////////////////////////////////////////// 
*/ 
/** 
 * Our database class, dun, dun, dun! :D Basically, this just paves 
 * a smooth ride between using Mysqli and MySQL, which essentially 
 * saves a) me from going through 85848484848 files and b) the script 
 * clogging up from repetitve code that can be avoided through the 
 * use of this class. :D 
 * 
 * @copyright  2007 
 * @license    GPL Version 3; BSD Modified 
 * @author     Tess <theirrenegadexxx@gmail.com> 
 * @file       <fun-db.inc.php> 
 * @since      August 15th, 2011  
 * @version    2.3alpha   
 */ 

if(class_exists('scorpions') == false) {
 class scorpions {

  public $connect = '';
  /** @var mysqli */
  public $database = '';

  /**
   * @function  $scorpions->scorpions() 
   * @desc      Our initialising function, which connects us to the  
   * database through the user's defined method 
   */
  public function scorpions($h, $u, $p, $n) {
   global $laoptions;

   if($laoptions->dbEngine == 'mysqli') {
    if($this->database == null) {
     $this->database = new mysqli($h, $u, $p, $n, 3306)
     or die(
         '<p class="errorButton"><span class="error">ERROR:</span> You cannot' .
         ' currently connect to MySQL. Make sure all variables are correct in' .
         ' <samp>rats.inc.php</samp>; if it is a random error, wait it out and see' .
         ' if it\'ll magically disappear.</p>'
     );
    }
   } else {
    $this->connect = mysql_connect($h, $u, $p) 
    or die(
     '<p class="errorButton"><span class="error">ERROR:</span> You cannot' . 
     ' currently connect to MySQL. Make sure all variables are correct in' . 
     ' <samp>rats.inc.php</samp>; if it is a random error, wait it out and see' . 
     ' if it\'ll magically disappear.</p>'
    );
    $this->database = mysql_select_db($n) 
    or die(
     '<p class="errorButton"><span class="error">ERROR:</span> You cannot' . 
     ' currently connect to your MySQL database. Make sure all variables are' . 
     ' correct in <samp>rats.inc.php</samp>; if it is a random error, wait it' . 
     ' out and see if it\'ll magically disappear.</p>'
    );
   }
  }

  /** 
   * @function  $scorpions->error() 
   */ 
  public function error() {
   global $laoptions;
   return ($laoptions->dbEngine == 'mysql' ? mysql_error() : $this->database->error);
  }

  /** 
   * @function  $scorpions->breach() 
   * @param     $y, boolean; 0 if closing the connection, 1 if opening 
   * the connection natively 
   * @notes     Originally located in <fun.inc.php> 
   * @version   2.3beta 
   */ 
	public function breach($y = 1) {
	 global $database, $database_host, $database_name, $database_pass, 
	 $database_user, $laoptions;
	 
	 switch($y) {
	  case 0:
     if($laoptions->dbEngine == 'mysqli') {
      $this->database->close();
      unset($this->database);
     } else {
		  mysql_close($this->connect);
      unset($this->connect);
		  unset($this->database);
     }
		break;
		
		case 1:
		 $this->scorpions($database_host, $database_user, $database_pass, 
     $database_name);
		break;
	 } 
	}

  /** 
   * @function  $scorpions->escape() 
   * @param     $p, text 
   * @desc      Escape text via real_escape_string() and - 
   * optionally - magic quotes gpc D: 
   */ 
  public function escape($p) {
   global $laoptions;

   $e = trim($p);
   if(get_magic_quotes_gpc()) {
    $e = stripslashes($e);
   }
   $e = $laoptions->dbEngine == 'mysqli' ? $this->database->real_escape_string($e) : 
   mysql_real_escape_string($e);

   return $e;
  }

  /** 
   * @function  $scorpions->counts() 
   * 
   * @param     $q, text; query string 
   * @param     $e, boolean 
   * @param     $m, text; predefined error message; optional 
   */ 
  public function counts($q, $e = 1, $m =  '') {
   global $laoptions;

   $r = (object) array(
    'message' => '',
    'rows' => 0,
    'status' => false
   );

   $select = $q;
   if($laoptions->dbEngine == 'mysqli') {
    $true = $this->database->query($select);
   } else {
    $true = mysql_query($select);
   }
    
   /**  
    * Are we returning strictly the boolean return value, or values 
    * and messages? 
    */ 
   if($e == 1) {
    $r->status = $true == false ? false : true;
   } else {
    if($true == false) {
     $r->status = false;
     $r->message = $m;
    } else {
     $r->status = true;
    }
   }

   /*  
    *  Fetch our number of rows, depending on the database method~ 
    */
   $r->rows = $laoptions->dbEngine == 'mysqli' ? $true->num_rows : mysql_num_rows($true);

   return $r;
  }

  /** 
   * Instead of repeating the OOP and procedural coding 34859959 
   * times over, we've got a handy function \o/ 
   * 
   * @function  $scorpions->fetch() 
   * @param     $q, string; the query string 
   * @param     $m, string; a specified value to pull; optional 
   */ 
  public function fetch($q, $m = '', $e = '') {
   global $laoptions, $tigers;

   $select = $q;

   /**  
    * Are there actually an results to pull from? Find this out first 
    * and send us back if we don't~ 
    */ 
   $c = $this->counts($select, 1);
   if($c->rows == 0) {
    return '';
   }

   if($laoptions->dbEngine == 'mysqli') {
    $true = $this->database->query($select);
   } else {
    $true = mysql_query($select);
   }
   if($true == false) {
    $o = $e != '' ? $e : 'There was an error in selecting the specified data' . 
    ' from the database.';
    $tigers->displayError('Database Error', $o, false);
   }

   /*  
    *  Fetch our data, whether we're pulling full rows, or just one value~ :D 
    */
   $getItem = $laoptions->dbEngine == 'mysqli' ? $true->fetch_object() : mysql_fetch_object($true);
   $r = $m != '' ? ($m == '*' ? $getItem : $getItem->$m) : $true;

   return $r;
  }

  /** 
   * @function  $scorpions->insert() 
   * 
   * @param     $q, text; query string 
   * @param     $e, boolean; 0 for returing status, 1 for returning status 
   * on success, and error on failure 
   */ 
  public function insert($q, $e = 0) {
   global $tigers, $laoptions;

   $r = false;

   $insert = $q;
   if($laoptions->dbEngine == 'mysqli') {
    $this->database->query("SET NAMES 'utf8';");
    $true = $this->database->query($insert);
   } else {
    mysql_query("SET NAMES 'utf8';");
    $true = mysql_query($insert);
   }
    
   /**  
    * Are we returning strictly the boolean return value, or values 
    * and messages? 
    */ 
   if($e == 0) {
    $r = $true == false ? false : true;
   } else {
    if($true == false) {
     $tigers->displayError('Database Error', 'The script was unable to insert' . 
     'the data.', false);
    } else {
     $r = true;
    }
   }

   return $r;
  }
	
	/** 
   * @function  $scorpions->lastid() 
   * @param     $q, string; the query string 
   */ 
  public function lastid($q) {
   global $laoptions;

   if($laoptions->dbEngine == 'mysqli') {
    $true = $q->insert_id;
   } else {
    $true = mysql_insert_id($q);
   }

   return $true;
  }

  /** 
   * @function  $scorpions->obj() 
   * @param     $q, string; the query string 
   * @param     $m, boolean; 0 returns the object, 1 returns the array 
   */ 
  public function obj($q, $m = 0) {
   global $laoptions;

   if($m == 0) {
    $getItem = $laoptions->dbEngine == 'mysqli' ? $q->fetch_object() : mysql_fetch_object($q);
   } else {
    $getItem = $laoptions->dbEngine == 'mysqli' ? $q->fetch_array() : mysql_fetch_array($q);
   }

   return $getItem;
  }

  /** 
   * @function  $scorpions->query() 
   * @param     $q, string; the query string 
   */ 
  public function query($q) {
   global $laoptions;
	 
	 if($q == '') {
	  return;
	 }

   $select = $q;
   if($laoptions->dbEngine == 'mysqli') {
    $true = $this->database->query($select);
   } else {
    $true = mysql_query($select);
   }

   return $true;
  }

  /** 
   * $this->counts() returns the rows, status and an error message 
   * if one is given; $this->total() returns the rows only 
   * 
   * @function  $scorpions->total() 
   * @param     $q, string; resource 
   */ 
  public function total($q) {
   global $laoptions;

   $count = $laoptions->dbEngine == 'mysqli' ? $q->num_rows : mysql_num_rows($q);

   return $count;
  }

  /** 
   * @function  $scorpions->update() 
   * 
   * @param     $q, string; query 
   * @param     $e, boolean; 1 for displaying the error natively or 0 for 
   * handling the error outside of the method 
   * @param     $m, text; the success/error text to display; optional 
   */ 
  public function update($q, $e = 1, $m = '') {
   global $tigers, $laoptions;
   
   $update = $q;
   if($laoptions->dbEngine == 'mysqli') {
    $this->database->query("SET NAMES 'utf8';");
    $true = $this->database->query($update);
   } else {
    mysql_query("SET NAMES 'utf8';");
    $true = mysql_query($update);
   }

   if($e == 1) {
    return $true == false ? false : true;
   } else {
    $s = explode("__", $m);
    $s = $tigers->emptyarray($s);
    if($true == false) {
     $tigers->displayError('Database Error', $s[0], false);
    } else {
     echo "<p class=\"successButton\"><span class=\"success\">Success!</span>" . 
     $s[1] . "</p>\n";
    }
   }
  }
 
  # Functions end right here~! 
 }
}
