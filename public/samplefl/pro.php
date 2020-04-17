<?php 
/** 
 * @author Tess <treibend@gmail.com>
 * @created February 19th, 2012 
 * @updated -- 
 */ 

if(class_exists('fanlisting') == false) {
 class fanlisting {
 
  /**  
	 * Get title from page 
	 */ 
  public function isTitle($e = '') {
   $s = trim(strip_tags(basename($_SERVER['PHP_SELF'])));
   $s = str_replace('.php', '', $s);
	 $s = str_replace("_", " ", $s);
	 $s = ucwords($s);
	 return " &#187; " . $s;
  }

	/** 
	 * Get opened year and current year if not the same 
	 */ 
  public function isYear($o) {
   $y = date("Y");
   if($o == $y) {
    echo $y;
   } else {
    echo $o . "-" . $y;
   }
  }

  /** 
   * Get base page for current page 
   */ 
  public function isPage() {
   return htmlspecialchars(trim(strip_tags(basename($_SERVER['PHP_SELF']))));
  }
	
	/** 
	 * Get base URL for our current website :D 
	 */ 
	public function isHome() {
	 
	 $u = 'http://' . $_SERVER['SERVER_NAME'] . preg_replace("/[a-z]+.php/", '', $_SERVER['PHP_SELF']);
	 return $u;
	}
	
	# End function list~! 
 }
}

$fanlisting = new fanlisting();
