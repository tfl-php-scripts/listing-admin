<?php
require_once("pro.php");
require("header.php");
?>
<h3>Members List</h3>
<?php 
# -----------------------------------------------------------
require("jac.inc.php");
# -----------------------------------------------------------
$fKey = 1;
$sort_by = 'list';
# -----------------------------------------------------------
require(STPATH . "show-members.php");
# -----------------------------------------------------------
?> 
<?php 
require("footer.php");
?>
