<?php

declare(strict_types=1);

use Rector\Core\Configuration\Option;
use Rector\Php74\Rector\Property\TypedPropertyRector;
use Rector\Set\ValueObject\DowngradeSetList;
use Symfony\Component\DependencyInjection\Loader\Configurator\ContainerConfigurator;

return static function (ContainerConfigurator $containerConfigurator): void {
    $parameters = $containerConfigurator->parameters();

    // paths to refactor; solid alternative to CLI arguments
    $parameters->set(Option::PATHS, [
        __DIR__ . '/public/admin',
    ]);

    $parameters->set(Option::AUTOLOAD_PATHS, [
        __DIR__ . '/public/admin/inc/class-antispam.inc.php',
        __DIR__ . '/public/admin/inc/class-kimadmin.inc.php',
        __DIR__ . '/public/admin/inc/fun-addons.inc.php',
        __DIR__ . '/public/admin/inc/fun-admin.inc.php',
        __DIR__ . '/public/admin/inc/fun-affiliates.inc.php',
        __DIR__ . '/public/admin/inc/fun-categories.inc.php',
        __DIR__ . '/public/admin/inc/fun-db.inc.php',
        __DIR__ . '/public/admin/inc/fun-emails.inc.php',
        __DIR__ . '/public/admin/inc/fun-external.inc.php',
        __DIR__ . '/public/admin/inc/fun-joined.inc.php',
        __DIR__ . '/public/admin/inc/fun-listings.inc.php',
        __DIR__ . '/public/admin/inc/fun-members.inc.php',
        __DIR__ . '/public/admin/inc/fun-misc.inc.php',
        __DIR__ . '/public/admin/inc/fun-updates.inc.php',
        __DIR__ . '/public/admin/inc/fun-utility.inc.php',
        __DIR__ . '/public/admin/inc/fun-wishlist.inc.php',
        __DIR__ . '/public/admin/inc/fun.inc.php',
        __DIR__ . '/public/admin/inc/vendors/class-crosspost.inc.php',
        __DIR__ . '/public/admin',
    ]);

    // is there a file you need to skip?
    $parameters->set(Option::SKIP, [
        // single file
        __DIR__ . '/public/admin/cache',
    ]);

    $parameters->set(Option::SETS, [
        DowngradeSetList::PHP_74,
        DowngradeSetList::PHP_73,
    ]);
};
