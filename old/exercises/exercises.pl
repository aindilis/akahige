#!/usr/bin/perl -w

# this is a program to interactively walk the user through exercises

# use  camera recognition  tool to  determine whether  he  is actually
# doing the exercises.   This will of course be  useful for cases like
# Justin.  Tool checks for a certain pattern of repetetive motion.

# Say the next exercise outloud.

# make student and  teacher modes - that is, the  teacher will want to
# comment  on what  the student  did  wrong, whereas  the student  may
# comment on what they think they can improve?

use Data::Dumper;

my $patient = "Andrew J. Dougherty"; #"David D. Glassmire";
my $nurse = "Andrew J. Dougherty";

my $currentdate = `date "+%Y%m%d"`;
$currentdate =~ s/\n//g;

# determine if it is am or pm
my $amorpm = `date "+%P"`;
$amorpm =~ s/\n//g;

my $logfile = "logs/$currentdate.$amorpm.perl.exercise.log";
my $OUT;
open(OUT, ">$logfile") or die "ouch\n";

my $commands = {
		"next" => "next exercise",
		"previous" => "previous exercise",
		"[integer]" => "register having done that count - must count from 1 to 30",
	       };

my $f = "data.pl";
my $c = `cat "$f"`;
my $exercises = eval $c;
my ($time,$lasttime);

sub ParseCommand {
  my $com = shift;
  # add feature for going backwards.   Add ability to take notes.  Add
  # interactivity allowing for commenting on mistakes.
}

sub NextExercise {
  my (%args) = (@_);
  ++$i;
  my $date = `date`;
  $time = `date "+%s"`;
  if (defined $lasttime) {
    MyPrint( "Duration:\t".($time - $lasttime)."\n");
    MyPrint( "--------------------------------------------------------------------\n" );
  }
  $lasttime = $time;
  MyPrint("\n");
  MyPrint( "Date:\t".$date."\n");
  MyPrint( "ID:\t".$exercises->[$i]->{ID}."\n");
  MyPrint( "Name:\t".$exercises->[$i]->{Name}."\n");
  MyPrint( "Desc:\t".$exercises->[$i]->{Description}."\n");
  my $com = <STDIN>;
  ParseCommand($com);
}

MyPrint( "####################################################################\n" );
MyPrint( "EXERCISE LOG FOR $currentdate: ".uc($amorpm)." SESSION\n" );
MyPrint( "PATIENT: $patient\n" );
MyPrint( "NURSE: $nurse\n" );
MyPrint( "####################################################################\n" );

$i = -1;
my $starttime = `date "+%s"`;
my $lastorder = "A";
while (defined $exercises->[$i + 1]->{Name}) {
  $lasttime = $time;
  my $order = $exercises->[$i + 1]->{ID};
  if ($order =~ /^(.)/) {
    $order = $1;
    if ($order ne $lastorder) {
      my $endtime = `date "+%s"`;
      my $totaltime = $endtime - $starttime;
      $totaltime =~ s/\n//g;
      my ($hours, $minutes, $seconds) = (int($totaltime / 3600.0),int(($totaltime % 3600) / 60),int($totaltime % 60));
      MyPrint( "\n####################################################################\n" );
      MyPrint( "Midpoint time time is: $totaltime\n" );
      MyPrint( "$hours:$minutes:$seconds\n" );
      MyPrint( "This equals: $hours hour(s), $minutes minute(s), and $seconds second(s)\n" );
    }
    $lastorder = $order;
  }
  NextExercise();
}
my $endtime = `date "+%s"`;
my $totaltime = $endtime - $starttime;
$totaltime =~ s/\n//g;
my ($hours, $minutes, $seconds) = (int($totaltime / 3600.0),int(($totaltime % 3600) / 60),int($totaltime % 60));
MyPrint( "\n####################################################################\n" );
MyPrint( "Total time was: $totaltime\n" );
MyPrint( "$hours:$minutes:$seconds\n" );
MyPrint( "This equals: $hours hour(s), $minutes minute(s), and $seconds second(s)\n" );
MyPrint( "I have logged everything in today's log file.\n" );
MyPrint( "Logfile is $logfile.\n" );
close(OUT);

sub MyPrint {
  my $line = shift;
  print $line;
  print OUT $line;
}
