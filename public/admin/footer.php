<?php
$feedurl = 'http://scripts.robotess.net/projects/listing-admin/atom.xml';
require_once('inc/fetch/rss_fetch.inc');
$rssEntries = fetch_rss($feedurl);
if ($rssEntries !== false) {
    ?>
    <div id="feeds">
        <div id="lafeeds">
            <h4>
                <ins><?= $laoptions->version ?></ins>
                Feed
            </h4>
            <?php
            echo "  <menu>\n";
            $items = array_reverse($rssEntries->items);
            $startnumero = 1;
            $maxEntries = 3;
            foreach ($items as $item) {
                $n = $startnumero === $maxEntries ? ' id="last"' : '';
                echo '   <li class="block" ' . $n . '><strong>' . $item['title'] . "</strong><br>\n";
                // echo "   <p>" . substr($item['description'], 0, 200) . "</p>\n";
                echo '   <a href="' . $item['guid'] . '" title="External Link: ' . $item['guid'] . "\">Read More &#187;</a></li>\n";
                if ($startnumero === $maxEntries) {
                    break;
                }
                $startnumero++;
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
