# Listing Admin for PHP7 [Robotess Fork]

The main repository with issue tracking is at gitlab: https://gitlab.com/tfl-php-scripts/listing-admin

Original author is [Tess](http://scripts.wyngs.net) / Original readme by Tess is [here](readme.txt).

#### I would highly recommend not to use this script for new installations, please only update it if you have already installed it before.

This version requires at least PHP 7.2 and MySQLi or PDO_MySQL extensions.

| PHP version | Supported until | Supported by Listing Admin |
|------------------------------------------|--------------------|-------------------------|
| 7.2 | 30 November 2020 | :white_check_mark: |
| 7.3 | 6 December 2021 | :grey_question: |
| 7.4 (recommended, LTS version) | December 2022 | :grey_question: |
| 8.0 (not released yet) | Q4 2023 or Q1 2024 | :grey_question: |

Changes are available in [changelog](CHANGELOG.md).

## Upgrading instructions

I'm not providing support for versions lower than 2.4, as well as for fresh installations.

If you are using Listing Admin 2.4 (old version by Tess) or Listing Admin [Robotess Fork] 1.*:

1. **Back up all your current Listing Admin configurations, files, and databases first.**
2. Take note of your database information in all your `config.php` files.
3. Download [an archive of the public folder of this repository](https://gitlab.com/tfl-php-scripts/listing-admin/-/archive/master/listing-admin-master.zip?path=public). Extract the archive.
4. Replace your current `admin/` files with the `public/admin/` files from this repository. Make sure that you have all files from the folder uploaded.
5. In every fanlisting folder, as well as in the collective folder, paste the `public/samplefl/jac.sample.inc.php` file; edit your database information and save it as `jac.inc.php` to overwrite your old one. Please note that additionally you have to add `public/samplefl/db-connection.inc.php` to every fanlisting/collective folder, this file should not be modified though. 
6. In the listing admin folder paste the `admin/rats.sample.inc.php` file; edit your database information and save it as `rats.inc.php` to overwrite your old one. 
7. There are `samplecollective` and `samplefl` folders added to the archive just for your convenience so that you could see how the folders for FL/collective might look like.  

Please follow the instructions carefully. A lot of issues were caused by users having incorrect config files.

That's it! Should you encounter any problems, please create an issue (here: https://gitlab.com/tfl-php-scripts/listing-admin/-/issues), and I will try and solve it if I can. You can also report an issue via contact form: http://contact.robotess.net
