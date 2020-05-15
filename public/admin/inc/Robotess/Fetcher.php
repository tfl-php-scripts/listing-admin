<?php
/**
 * @project          Listing Admin
 * @copyright        2020
 * @license          GPL Version 3; BSD Modified
 * @author           Ekaterina <scripts@robotess.net> http://scripts.robotess.net
 * @file             <Fetcher.php>
 * @version          Robotess Fork
 */

namespace Robotess;

use SimplePie;
use SimplePie_Item;
use const DIRECTORY_SEPARATOR;

/**
 * Class Fetcher
 * @package Robotess
 */
final class Fetcher
{
    /**
     * @var string
     */
    private $cacheDirectory;

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
     * @param string $feedUrl
     * @return SimplePie_Item[]
     */
    public function fetchUrl(string $feedUrl): array
    {
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'vendors' . DIRECTORY_SEPARATOR . 'simplepie' . DIRECTORY_SEPARATOR . 'autoloader.php');

        $feed = new SimplePie();
        $feed->set_feed_url($feedUrl);
        $feed->enable_cache(true);
        $feed->set_cache_location($this->cacheDirectory);
        $feed->strip_htmltags('a', true);
        $feed->init();
        $feed->handle_content_type();
        return $feed->get_items();
    }
}
