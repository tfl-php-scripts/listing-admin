# Changes:

Robotess Fork v1.0.2

* Changing default date from 0000-00-00 to 1970-01-01 in order for the script to be working with the latest MySQL versions 
* Fixed #10 - URLs are not lowered anymore while saving
* Fixed #8 - bug which didn't allow to edit listing's URL via admin panel
* Security fix: no password is being logged into _success or _logs tables
* Fixing minor JS errors for control panel, for example, for adding previous owners for the listings
* Various fixes for favorite fields - they were not properly working in previous versions
* Fixing date pickers in add/edit listing - now if you're trying to specify incorrect date, for example, 30th of February any year, you will be getting transparent error message
* RSS retrieval is now working via JavaScript
* Various other fixes

Robotess Fork v1.0.1

* Various code fixes + pagination fixes

Robotess Fork v1.0.0

* Fixed #5 - it's possible now to connect via mysqli or pdo_mysql. In future, it will be possible to use other DBs as well. Please, make sure your config files are consistent with the sample ones (more details in [README.md](README.md)).
* Slightly reworked joined page pagination (in admin console).
* Fixed #1, #3 - I went through all the pages of admin panel/forms pages to make sure emails with pluses are allowed. Also all emails are being converted to lowercase before comparing/inserting into DB.
* Fixed #2, #3 - I went through all the pages of admin panel/forms pages to make sure URLs starting with https are allowed. Also all URLs are being converted to lowercase before comparing/inserting into DB.
* Other changes, including fixing of a huge amount of the found bugs. Thanks to [Joy](http://fan.greenhype.net) for reporting a lot of them.
