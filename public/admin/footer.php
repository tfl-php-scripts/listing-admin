<?php
require_once('inc/Robotess/Fetcher.php');
$rssEntries = Robotess\Fetcher::instance()->fetchUrl('https://scripts.robotess.net/projects/listing-admin/atom.xml');
if (count($rssEntries) > 0) {
    ?>
    <div id="feeds">
        <div id="lafeeds">
            <h4>
                <ins><?= $laoptions->version ?></ins>
                Feed
            </h4>
            <?php
            echo "  <menu>\n";
            $currentIndex = 1;
            foreach ($rssEntries as $item) {
                echo '   <li class="block"><strong>' . $item->get_title() . '</strong> [' . $item->get_date() . "]<br>\n";
                echo '   <p>' . substr($item->get_description(), 0, 200) . "</p>\n";
                echo '   <a href="' . $item->get_permalink() . '" title="External Link: ' . $item->get_permalink() . "\" target=\"_blank\">Read More &#187;</a></li>\n";
                if ($currentIndex++ >= 3) {
                    break;
                }
            }
            echo "  </menu>\n";
            ?>
        </div>
        <section class="clear"></section>
    </div>
<?php } ?>
</section>

</div>

<footer>
    <p><strong>Listing Admin</strong> &#169; <?php echo $leopards->isYear('2007'); ?> <a
                href="http://scripts.wyngs.net/scripts/listingadmin/" target="_blank">Tess</a>
        <br><br><a href="https://scripts.robotess.net" target="_blank"
                   title="PHP Scripts: Enthusiast, Siteskin, Codesort, Listing Admin, FanUpdate - ported to PHP 7"><?php echo $laoptions->version; ?>
            for PHP 7</a>
        - support since 2020 by <a href="https://robotess.net" target="_blank" title="PHP Developer">Ekaterina</a>
    </p>
</footer>

</div>

<script src="js.js" type="text/javascript"></script>
<script src="jquery.js" type="text/javascript"></script>
<script src="jquery-custom.js" type="text/javascript"></script>

</body>
</html>
