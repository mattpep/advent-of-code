<?php

$file = file('data/8.txt', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

$directions = $file[0];
$paths = array();
foreach(array_slice($file, 1) as $pathline) {
    $parts = explode(' = ', $pathline);
    $loc = $parts[0];
    $dests = explode(', ', trim($parts[1], '()'));

    $paths[$loc] = $dests;
}

$START = 'AAA';
$TARGET = 'ZZZ';

$distance = 0;
$location = $START;
while ($location != $TARGET)
{
    $offset = $distance % strlen($directions);
    $next_step = $directions[$distance % strlen($directions)];
    if ($next_step == 'L')
    {
        $location = $paths[$location][0];
    }
    else {
        $location = $paths[$location][1];
    }
    $distance++;
}

print("Part 1: $distance\n");
