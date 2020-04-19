<?php
/**
 * @project          Listing Admin
 * @copyright        2020
 * @license          GPL Version 3; BSD Modified
 * @author           Ekaterina <scripts@robotess.net> http://scripts.robotess.net
 * @file             <Utils.php>
 * @version          Robotess Fork
 */

namespace Robotess;

use function preg_match;

class StringUtils
{
    /**
     * @var self
     */
    private static $instance;

    private function __construct()
    { /***/
    }

    public static function instance(): self
    {
        if (empty(self::$instance)) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    /**
     * @param $data
     * @return string
     */
    public function normalize(string $data): string
    {
        return strtolower($data);
    }

    /**
     * @param string $email
     * @return bool
     */
    public function isEmailValid(string $email): bool
    {
        return (bool)preg_match("/^([A-Za-z0-9-_\.+]+)@(([A-Za-z0-9-_]+\.)+)([a-zA-Z]{2,})$/i", $email);
    }

    /**
     * @param string $url
     * @return bool
     */
    public function isUrlValid(string $url): bool
    {
        return (bool)preg_match('@^(https?://)([A-Za-z0-9-_./?]+)\.([A-Za-z.]{2,})/?$@i', $url);
    }
}
