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

my $nod = 1;
my $face = 20;
my $result = 0;

if (defined $ARGV[0]) {
	my @ndx = split /d/, $ARGV[0];
	my $nod = $ndx[0] ? $ndx[0] : 1;
	my $face = $ndx[1] if defined $ndx[1];
	for (my $i = 0; $i < $nod; $i++) {
		$result += $face - int(rand($face));
	}
}
else {
	$result = $face - int(rand($face));
}

print $result . "\n";

exit 0;
