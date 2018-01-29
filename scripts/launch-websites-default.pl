#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $sites =<<OUT;
http://dev.freelifeplanner.org
https://alexa.amazon.com
https://gmail.com
https://mail.yahoo.com
https://facebook.com
https://facebook.com/frdcsa
https://facebook.com/aindilis
https://bensbargains.com/new
https://slickdeals.com/
https://slickdeals.com/deals/freebies/
http://techbargains.net
https://slashdot.org
https://www.ebay.com
https://flint.craigslist.org
https://flint.craigslist.org/search/zip
https://flint.craigslist.org/search/vga
https://meetup.com
https://linkedin.com
https://amazon.com
https://gearbest.com
https://geekbuying.com
https://newegg.com
http://tigerdirect.com
https://dx.com
https://banggood.com
http://steampowered.com
https://cdkeys.com
https://scdkeys.com
https://bhphotovideo.com
https://paypal.com
https://serve.com
https://bankofamerica.com/moneynetwork
https://ebt-link.illinois.gov/ilebtclient/login.recip
https://ziprecruiter.com
https://gofundme.com
https://patreon.com
OUT

# that site for having sponsors

my $moresites =<<OUT;
https://geeks.com
OUT

foreach my $url (split /\n/, $sites) {
  print "<$url>\n";
  my $c = "firefox -new-tab -url ".shell_quote($url);
  print "$c\n";
  system $c;
}
