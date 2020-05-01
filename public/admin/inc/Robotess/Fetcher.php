<?php
/**
 * @project          Listing Admin
 * @copyright        2007
 * @license          GPL Version 3; BSD Modified
 * @author           Ekaterina <scripts@robotess.net> http://scripts.robotess.net
 * @file             <class-fetcher.inc.php>
 * @version          Robotess Fork
 */

namespace Robotess;

use SimplePie;
use const DIRECTORY_SEPARATOR;

class Fetcher
{
    /**
     * @var string
     */
    private $cacheDirectory;

    /**
     * @var int
     */
    private $itemsLimit = 3;

    /**
     * @var self
     */
    private static $instance;

    /**
     * Fetcher constructor.
     */
    private function __construct()
    {
        $this->cacheDirectory = __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'cache';
    }

    /**
     * @return self
     */
    public static function instance(): self
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    /**
     * @deprecated
     * @see fetchUrl
     * @param string $feedUrl
     * @return array
     */
    public function fetchUrlMagpie(string $feedUrl): array
    {
        define('MAGPIE_CACHE_ON', false);
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'vendors' . DIRECTORY_SEPARATOR . 'fetch' . DIRECTORY_SEPARATOR . 'rss_fetch.inc');
        $result = fetch_rss($feedUrl);
        if ($result === false) {
            return [];
        }
        return $result->items;
    }

    /**
     * @param string $feedUrl
     * @return array
     */
    public function fetchUrl(string $feedUrl): array
    {
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'vendors' . DIRECTORY_SEPARATOR . 'simplepie' . DIRECTORY_SEPARATOR . 'autoloader.php');

        $feed = new SimplePie();
        $feed->set_feed_url($feedUrl);
        //@todo remove
        $feed->enable_cache(false);
        $feed->set_cache_location($this->cacheDirectory);
        $feed->set_item_limit($this->itemsLimit);
        $feed->init();
        $feed->handle_content_type();
        return $feed->get_items();
    }
}
