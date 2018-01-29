#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

$specification = q(
	-s <sites>		List of sites
	-f <file>		File containing sites

);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $sites = "";
if (exists $conf->{'-f'} and -f $conf->{'-f'}) {
  $sites .= read_file($conf->{'-f'});
}
if (exists $conf->{'-s'}) {
  $sites .= $conf->{'-s'};
}

foreach my $url (split /\n/, $sites) {
  print "<$url>\n";
  my $c = "firefox -new-tab -url ".shell_quote($url);
  print "$c\n";
  system $c;
}
