#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $c = read_file('<REDACTED>');

my $timesCalled = {};
my @results;
foreach my $line (split /\n/, $c) {
  chomp $line;
  next unless $line =~ /\S/;
  my @entries = split /\t+/, $line;
  my $res =
    {
     Name => $entries[0],
     Number => $entries[1],
     Time => $entries[2],
     Duration => $entries[3],
    };
  # print Dumper($res);
  if ($res->{Time} =~ /^(Today at|(December|January) (\d{1,2}) (\d{4})) (\d{1,2}):(\d{2}) (AM|PM)$/) {
    push @results, $res;
  } else {
    # print "<".$res->{Time}.">\n";
  }
  my $number = $res->{Number};
  if ($res->{Number} =~ /^\+?1?(.+)$/) {
    $number = $1;
  }
  next if length($number) < 10;
  # print "<$number>\n";
  $timesCalled->{$number}++;
}

foreach my $number (keys %$timesCalled) {
  my $url1 = 'www.google.com/\#q='.$number;
  my $url2 = 'https://www.google.com/\#q='.$number;
  # my $c = "firefox -remote \"openURL($url1, new-tab)\"";
  my $c = "firefox -new-tab -url ".shell_quote($url2);
  print "$c\n";
  system $c;
}

# print Dumper($timesCalled);
# print Dumper(\@results);

