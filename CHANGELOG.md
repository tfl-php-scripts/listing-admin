# Changes:

Robotess Fork v1.0.0

* Fixed #5 - it's possible now to connect via mysqli or pdo_mysql. In future, it will be possible to use other DBs as well. Please, make sure your config files are consistent with the sample ones (more details in [README.md](README.md)).
* Slightly reworked joined page pagination (in admin console).
* Fixed #1, #3 - I went through all the pages of admin panel/forms pages to make sure emails with pluses are allowed. Also all emails are being converted to lowercase before comparing/inserting into DB.
* Fixed #2, #3 - I went through all the pages of admin panel/forms pages to make sure URLs starting with https are allowed. Also all URLs are being converted to lowercase before comparing/inserting into DB.
