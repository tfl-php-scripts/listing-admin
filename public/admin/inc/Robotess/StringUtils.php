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

    public function isEmailValid(string $email): bool
    {
        return preg_match("/^([A-Za-z0-9-_\.+]+)@(([A-Za-z0-9-_]+\.)+)([a-zA-Z]{2,})$/i", $email);
    }
}
