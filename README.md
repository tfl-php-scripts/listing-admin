# Listing Admin for PHP7 [Robotess Fork]

The main repository with issue tracking is at gitlab: https://gitlab.com/tfl-php-scripts/listing-admin

An original author is [Tess](http://scripts.wyngs.net) / readme by Tess can be found [here](readme.txt).

#### I would highly recommend not to use this script for new installations, please only update it if you have already installed it before.

This version requires at least PHP 7.3 and MySQLi or PDO_MySQL extensions (with MySQL = 5.7).

| PHP version | Supported until | Supported by Listing Admin |
|------------------------------------------|--------------------|-------------------------|
| 7.3 | 6 December 2021 | :white_check_mark: |
| 7.4 (recommended, LTS version) | December 2022 | :white_check_mark: |
| 8.0 | Q4 2023 or Q1 2024 | :grey_question: |

**If you have MySQL 8.0 or higher, proper script operation is not guaranteed. For now, I'm not planning to support MySQL
8.0.**

Changes are available in [changelog](CHANGELOG.md).

## Upgrading instructions

I'm not providing support for versions lower than 2.4, as well as for fresh installations.

If you are using Listing Admin 2.4 (old version by Tess) or Listing Admin [Robotess Fork] 1.*:

1. **Back up all your current Listing Admin configurations, files, and databases first.**
2. Take note of your database information in all your `config.php` files.
3.
Download [an archive of the public folder of this repository](https://gitlab.com/tfl-php-scripts/listing-admin/-/archive/master/listing-admin-master.zip?path=public)
. Extract the archive.
4. Replace your current `admin/` files with the `public/admin/` files from this repository. Make sure that you have all
   files from the folder uploaded.
5. In every fanlisting folder, as well as in the collective folder, paste the `public/samplefl/jac.sample.inc.php` file;
   edit your database information and save it as `jac.inc.php` to overwrite your old one. Please note that additionally
   you have to add `public/samplefl/db-connection.inc.php` to every fanlisting/collective folder, this file should not
   be modified though.
6. In the listing admin folder paste the `admin/rats.sample.inc.php` file; edit your database information and save it
   as `rats.inc.php` to overwrite your old one.
7. There are `samplecollective` and `samplefl` folders added to the archive just for your convenience so that you could
   see how the folders for FL/collective might look like.

Please follow the instructions carefully. A lot of issues were caused by users having incorrect config files.

That's it! Should you encounter any problems, please create an issue (
here: https://gitlab.com/tfl-php-scripts/listing-admin/-/issues), and I will try to solve it if I can. You can also
report an issue via contact form: http://contact.robotess.net?box=scripts&subject=Issue+with+Listing+Admin. Please note
that I don't support fresh installations, only those that were upgraded from old version.
