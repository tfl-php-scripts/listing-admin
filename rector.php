<?php

declare(strict_types=1);

use Rector\Core\Configuration\Option;
use Rector\Php74\Rector\Property\TypedPropertyRector;
use Rector\Set\ValueObject\SetList;
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

    $parameters->set(Option::SKIP, [
        __DIR__ . '/public/admin/rats.inc.php',
        __DIR__ . '/public/admin/cache',
        __DIR__ . '/public/admin/inc/vendors',
    ]);

    $parameters->set(Option::SETS, [
        SetList::PHP_74,
    ]);
};
