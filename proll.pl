#!/usr/bin/perl
#
#       proll.pl
#       
#       Copyright 2012-2013 Francesco Ruvolo <ruvolof@gmail.com>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.
#       
#       

use strict;
use warnings;
use Getopt::Long;

my $PROGNAME = 'PRoll';
my $VERSION = '1.0';
my $AUTHOR = 'Francesco Ruvolo <ruvolof@gmail.com>';

my $version = sub {
	print "$PROGNAME $VERSION - $AUTHOR\n";
	exit 0;
};

my $usage = sub {
	print "Usage: proll <options> XdY[+/- MOD]\n";
	print "Available options:\n";
	print "	-h, --help	Print this help and exit.\n";
	print "	-q, --quiet	Print only the total result.\n";
	print "	-v, --verbose	Print the result of each roll.\n";
	print "	--version	Print version.\n";
	print "	XdY		Roll X dice with Y faces.\n";
	print "	XdY+/-M		Same as above, but add/subtract M to result.\n";
	print "	XdY++/--M	Same as above, but add/subtract M to each roll.\n";
	exit 0;
};

my $run_test = sub {
    my @dsize = (4, 6, 8, 10, 12, 20);
    my $tcount = 1000000;
    my $t_s = "$tcount" . "d";
    for my $s (@dsize) {
        my $cts = $t_s . $s;
        my @launches = split /\n/, `$0 --verbose --quiet $cts`;
        pop(@launches);
        my %values;
        for my $l (@launches) {
            $values{$l}++;
        }
        print "Testing for d$s:\n";
        my @k = sort {$a <=> $b} keys %values;
        my $avgp = (1 + $s) / 2;
        my $ravgp = 0;
        for my $v (@k) {
            print $v, ": ", $values{$v}, " (";
            my $p = sprintf("%.2f", ($values{$v} / $tcount * 100));
            print $p, "%)\t";
            if ($v % 4 == 0 or $v == $k[-1]) {
                print "\n";
            }
            $ravgp += $values{$v} * $v;
        }
        $ravgp /= $tcount;
        my $avgdiff = abs ($ravgp - $avgp);
        print "Expected mean: ", sprintf("%.2f", $avgp), "\tMean difference: ", sprintf("%.2f", $avgdiff / $avgp * 100), "% ($ravgp)\n";
        print "\n"x2;
    }
    exit 0;
};

my $quiet = undef;
my $verbose = undef;

my $nod = 1;
my $face = 20;
my $result = 0;
my $launch = undef;
my $launch_regexp = '^(\d*)d?(\d*)(?:(\+{1,2}|\-{1,2})(\d*))?$';
my ($dice, $fc, $op, $mod) = (undef, undef, undef, undef);

my $ret = GetOptions ( "version" => $version,
                        "test" => $run_test,
						"h|help" => $usage,
						"q|quiet" => \$quiet,
						"v|verbose" => \$verbose );
						
$usage->() unless $ret or scalar @ARGV > 1;

sub do_launch {
    my $launch = $_[0];
    
    if ($launch =~ $launch_regexp) {
		($dice, $fc, $op, $mod) = ($launch =~ m/$launch_regexp/);
		if (defined $dice and $dice ne ''){
			$nod = $dice;
		}
		if (defined $fc and $fc ne '') {
			$face = $fc;
		}
		my $single;
		for (my $i = 0; $i < $nod; $i++) {
			$single = $face - int(rand($face));
			$result += $single;
			if (defined $op) {
				if ($op eq '++'){
					$result += $mod;
				}
				elsif ($op eq '--') {
					$result -= $mod;
				}
			}
			
			if ($verbose) {
				if (not defined $op or $op eq '' or (defined $op and ($op eq '+' or $op eq '-'))) {
					print '#' . ($i + 1) . " -> " if not $quiet;
                    print "$single\n";
				}
				else {
					if ($op eq '++') {
						print '#' . ($i + 1) . " -> $single + $mod = " if not $quiet;
                        print(($single + $mod) . "\n");
					}
					elsif ($op eq '--') {
						print '#' . ($i + 1) . " -> $single - $mod = " if not $quiet;
                        print(($single - $mod) . "\n");
					}
				}
			}
		}
	}
	else {
		&$usage;
	}
}

if ( defined $ARGV[0] ) {
	$launch = $ARGV[0];
}

if (defined $launch) {
	do_launch($launch);
}
else {
	$result = $face - int(rand($face));
}

if (defined($op)) {
	if ($op eq '+'){
		$result += $mod;
	}
	elsif ($op eq '-') {
		$result -= $mod;
	}
}

print "Total: " unless $quiet;
print $result, "\n";

exit 0;
