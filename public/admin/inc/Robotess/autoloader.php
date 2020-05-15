<?php
/**
 * @project          Listing Admin
 * @copyright        2020
 * @license          GPL Version 3; BSD Modified
 * @author           Ekaterina <scripts@robotess.net> http://scripts.robotess.net
 * @file             <autoloader.php>
 * @version          Robotess Fork
 */

namespace Robotess;

spl_autoload_register([new Autoloader(), 'autoload']);

if (!class_exists(AutoloadChecker::class))
{
	trigger_error('Robotess Autoloader not registered properly', E_USER_ERROR);
}

/**
 * Class Autoloader
 * @package Robotess
 */
final class Autoloader
{
	/**
	 * Constructor
	 */
	public function __construct()
	{
		$this->path = __DIR__ . DIRECTORY_SEPARATOR;
	}

	/**
	 * @param string $class
	 */
	public function autoload(string $class): void
    {
		if (strpos($class, 'Robotess\\') !== 0)
		{
			return;
		}

		$filename = $this->path . DIRECTORY_SEPARATOR . str_replace('Robotess\\', '', $class) . '.php';
		include $filename;
	}
}
