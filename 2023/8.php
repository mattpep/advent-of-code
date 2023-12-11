<?php
class Rider
{
    public $distance;
    private $paths;
    private $directions;
    private $location;

    public function __construct($paths, $directions, $location) {
        $this->paths = $paths;
        $this->directions = $directions;
        $this->location = $location;
        $this->distance = 0;
    }

    public function step() {
        $direction = $this->directions[$this->distance % strlen($this->directions)];
        if ($direction == 'L')
            $this->location = $this->paths[$this->location][0];
        else
            $this->location = $this->paths[$this->location][1];
        $this->distance++;
    }

    public function go_home() {
        while ( substr($this->location, -1) != 'Z' )
            $this->step();
    }
}

function get_start_nodes($path_info) {
    $locations = array();
    foreach ($path_info as $loc=>$dests)
        if (substr($loc, -1) == 'A')
            array_push($locations, $loc);
    return $locations;
}

function gcd($a, $b) {
    while ($b != 0) {
        $r = $b;
        $b = $a % $b;
        $a = $r;
    }
    return $a;
}

function lcm($a, $b) {
    if ($a == 0 || $b == 0) return 0;
    $result = ($a * $b) / gcd($a, $b);
    return abs($result);
}

function lcm_reduce($array) {
    if (count($array) == 1)
        return $array[0];
    if (count($array) == 2)
        return lcm($array[0], $array[1]);

    $a = array_pop($array);
    $b = array_pop($array);
    array_push($array, lcm($a, $b));
    return lcm_reduce($array);
}

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

$rider = new Rider($paths, $directions, $START);
$rider->go_home();

print("Part 1: $rider->distance\n");

$distances = array();
$riders = array();
foreach (get_start_nodes($paths) as $loc) {
    $rider = new Rider($paths, $directions, $loc);
    $rider->go_home();
    array_push($distances, $rider->distance);
}

printf("Part 2: %d\n", lcm_reduce($distances));
