<?php

declare(strict_types=1);

use Steevanb\ParallelProcess\{
    Console\Application\ParallelProcessesApplication,
    Process\Process
};
use Symfony\Component\Console\Input\ArgvInput;

require $_SERVER['COMPOSER_HOME'] . '/vendor/autoload.php';
$projectDir = dirname(__DIR__, 2);

// Define processes to run
$composerProcess = (new Process([$projectDir . '/bin/composer', 'update', '--ansi']))
    ->setName('composer update');

// Run all processes
(new ParallelProcessesApplication())
    ->addProcess($composerProcess)
    ->run(new ArgvInput($argv));
