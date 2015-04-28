#!/usr/bin/perl
use strict;
use warnings;

use Cwd;

my $directory            = getcwd;
my @deb_files_to_install = ();

opendir (my $directory_handler, $directory) or 
    die "Couldn't open folder $directory: $!";

while ( my $file = readdir($directory_handler) ) {
    if ( $file =~ /^exim4_.*_all\.deb/    or
         $file =~ /^exim4-base.*\.deb$/   or
         $file =~ /^exim4-config.*\.deb$/ or
         $file =~ /^exim4-daemon-heavy_.*\.deb/ ) {
        push @deb_files_to_install, $file;
    }
}

my $deb_files = join(' ', @deb_files_to_install);

system("/usr/bin/dpkg -i $deb_files");
