<?php declare(strict_types=1);
use Grinder\PhpMinify\Server;

// Start the application.
require_once __DIR__."/server.php";
(new Server)->run($_GET);
