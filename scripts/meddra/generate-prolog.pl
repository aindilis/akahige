#!/usr/bin/perl -w

use KBS2::ImportExport;
use PerlLib::SwissArmyKnife;

my $meddradatadir = "/var/lib/myfrdcsa/codebases/internal/akahige/data-git/medical-resources/meddra";
my $outputfile = "/var/lib/myfrdcsa/codebases/internal/akahige/data-git/medical-resources/meddra-prolog/meddra-prolog.pl";
my $qlfprogram = "/var/lib/myfrdcsa/codebases/internal/akahige/data-git/medical-resources/meddra-prolog/meddra-prolog.qsave";

my $all = {};
my $i = 1;

if (! -f $outputfile) {
  my $fh = IO::File->new();
  $fh->open('>$outputfile') or die "Youza!\n";

  foreach my $file (split /\n/, `ls $meddradatadir`) {
    my $filename = "$meddradatadir/$file";
    print "<$filename>\n";
    $all->{$filename} = [];
    my $c = read_file($filename);
    foreach my $line (split /\n/, $c) {
      my @entries = split /\t/, $line;
      unshift @entries, $i;
      unshift @entries, 'rel';
      push @{$all->{$filename}}, \@entries;
    }
    my $importexport = KBS2::ImportExport->new();
    my $res1 = $importexport->Convert
      (
       Input => $all->{$filename},
       InputType => 'Interlingua',
       OutputType => 'Prolog',
      );
    die "No Success for $filename\n" unless $res1->{Success};
    print $fh $res1->{Output};
    ++$i;
  }
  $fh->close();
}

if (! -f $qlfprogram) {
  # now go ahead and load it and then qsave it
  my $command = 'swipl -s '.shell_quote($outputfile)." -g \"qsave_program('$qlfprogram').\"";
  print "$command\n";
  system $command;
}
