/**  
 * We could - theoretically - create this in our jQuery file, but 
 * as this can be constructed through plain ole JavaScript, why 
 * the hell not? :D Wrapping this in an object, o' course! 
 */ 

var tess = {
 /** 
  * @method  tess.clean() 
	* @param   e, text 
  */ 
 clean: function(e) {
	var pattern, execute, string, q = '';
	
	/** 
	 * Do main clean; if nothing is cleaned, return original string 
	 */ 
	pattern = /([[\.\+\?\:\;\*\(\)\/\]\[#'"!_-]+)/g;
	execute = e.replace(pattern, '');
	string  = execute == '' || execute == null ? e : execute;
	
	/** 
	 * Strip white space \o/ 
	 */ 
	o = /([\s]+)/g;
	p = string.replace(o, '');
	q = this.trim(p);
  return q.toLowerCase();
 },
 
 /** 
  * @method  tess.getQuery() 
  */ 
 getQuery: function() {
  var s = window.location.search, n = '', r = '', m = '', h = '', p = '', 
	c = '', a = '';
	
  n = s.split('=');
	m = /&([A-Za-z0-9=?]+)/;
	e = m.exec(n[1]);
	 
	/**   
	 * Is there a & character in our query? If so, let's do some regex-replacing 
	 * jazz~  
	 */ 
	if(e == null) {
	 r = n[1];
	} else {
	 h = s;
	 p = /(\?[a-z=]+)(&[a-z0-9=]+)/;
	 c = h.replace(p, "$1");
	 a = c.split('=');
	 r = a[1];
	}
	 
  return r;
 },

 /** 
  * @method  tess.getURL() 
  */ 
 getURL: function() {
	var url = window.location.href;
 	var u   = url, r = '', e = '', n = '';
	 
	r = /[a-zA-Z]+.php/;
	e = r.exec(u);
	n = e[0];
	return n;
 },
 
 /** 
  * @method  tess.inArray() 
	* @param   a, array 
	* @param   p, var 
  */ 
 inArray: function(a, p) {
  var n = a.length;
  var v = 0;
  for(var i = 0; i < n; i++) {
   if(n[i] == p) {
    v = 1;
   }
  }

  return v;
 },

 /** 
  * @method  tess.joinedID() 
	* @param   e, text 
  */ 
 joinedID: function(e) {
	var m = '', c = '';
	m = /([0-9]+)$/;
	c = m.exec(e);
  return c[0];
 },
 
 /** 
  * @method  tess.trim() 
	* @param   s, text 
  */ 
 trim: function(s) {
	return s.replace(/^\s*|\s*$/g, '');
 }
};
