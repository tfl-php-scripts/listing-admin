<?php
declare(strict_types=1);
/**
 * @project          Listing Admin
 * @copyright        2020
 * @license          GPL Version 3; BSD Modified
 * @author           Ekaterina <scripts@robotess.net> http://scripts.robotess.net
 * @file             <StringUtils.php>
 * @version          Robotess Fork
 */

namespace Robotess;

use function preg_match;
use function strtolower;
use function trim;

/**
 * Class StringUtils
 * @package Robotess
 */
final class StringUtils
{
    private static ?StringUtils $instance = null;

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
     * @param string $data
     * @return string
     * @deprecated
     */
    public function normalize(?string $data): string
    {
        return $this->normalizeUrl($data ?? '');
    }

    public function normalizeUrl(?string $data): string
    {
        return trim($data ?? '');
    }

    public function normalizeEmail(?string $data): string
    {
        return trim(strtolower($data ?? ''));
    }

    public function isEmailValid(string $email): bool
    {
        return (bool)preg_match("/^([A-Za-z0-9-_.+]+)@(([A-Za-z0-9-_]+\.)+)([a-zA-Z]{2,})$/i", $email ?? '');
    }

    public function isUrlValid(string $url): bool
    {
        return (bool)preg_match('@^(https?://)([A-Za-z0-9-_./?]+)@i', $url);
    }
}
