#!/usr/bin/perl
#
#       proll.pl
#       
#       Copyright 2012 Francesco Ruvolo <ruvolof@gmail.com>
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

my $PROGNAME = "PRoll";
my $VERSION = "1.0";
my $AUTHOR = "Francesco Ruvolo <ruvolof\@gmail.com>";

my $version = sub {
	print "$PROGNAME $VERSION - $AUTHOR\n";
	exit 0;
};

my $usage = sub {
	print "Usage: proll <options>\n";
	print "Available options:\n";
	print "	-h, --help	Print this help and exit.\n";
	print "	--version	Print version.\n";
	print "	XdY		Launch X dice with Y faces.\n";
	exit 0;
};

my $ret = GetOptions ( "version" => $version,
					   "h|help" => $usage );

my $nod = 1;
my $face = 20;
my $result = 0;

if (defined $ARGV[0]) {
	if ($ARGV[0] =~ m/^\d*d{0,1}\d*$/) {
		my @ndx = split /d/, $ARGV[0];
		$nod = $ndx[0] ? $ndx[0] : $nod;
		$face = defined $ndx[1] ? $ndx[1] : $face;
		for (my $i = 0; $i < $nod; $i++) {
			$result += $face - int(rand($face));
		}
	}
	else {
		&$usage;
	}
}
else {
	$result = $face - int(rand($face));
}

print $result . "\n";

exit 0;
