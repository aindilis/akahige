package Akahige::Exercise;

use Manager::Dialog qw(Choose);

# this is a program to interactively walk the user through exercises

# use camera recognition tool to determine whether he is actually
# doing the exercises.  Tool checks for a certain pattern of
# repetetive motion.

# Say the next exercise outloud.

# make student and  teacher modes - that is, the  teacher will want to
# comment  on what  the student  did  wrong, whereas  the student  may
# comment on what they think they can improve?

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Patient Nurse RoutineDir RoutineFile Exercises /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Patient($args{Patient} || $ENV{USER});
  $self->Nurse($args{Nurse} || $ENV{USER});
  $self->RoutineDir
    ($args{RoutineDir} ||
     $UNIVERSAL::systemdir."/data/exercise/routines");
}

sub Execute {
  my ($self,%args) = @_;
  $self->ChooseExercise;
  $self->DoRoutine;
}

sub ChooseExercise {
  my ($self,%args) = @_;
  my $routinedir = $self->RoutineDir;
  my @files = split /\n/,`ls $routinedir`;
  my $routinefile = Choose(@files);
  $self->RoutineFile
    ($routinefile);
}

sub DoRoutine {
  my ($self,%args) = @_;
  my $currentdate = `date "+%Y%m%d"`;
  $currentdate =~ s/\n//g;

  # determine if it is am or pm
  my $amorpm = `date "+%P"`;
  $amorpm =~ s/\n//g;

  my $logfile = $UNIVERSAL::systemdir."/data/exercise/logs/$currentdate.$amorpm.perl.exercise.log";

  my $OUT;
  open(OUT, ">$logfile") or die "ouch\n";
  my $commands = {
		  "next" => "next exercise",
		  "previous" => "previous exercise",
		  "[integer]" => "register having done that count - must count from 1 to 30",
		 };
  my $f = $self->RoutineDir."/".$self->RoutineFile;
  my $c = `cat "$f"`;
  $self->Exercises(eval $c);
  my ($time,$lasttime);

  $self->MyPrint( "####################################################################\n" );
  $self->MyPrint( "EXERCISE LOG FOR $currentdate: ".uc($amorpm)." SESSION\n" );
  $self->MyPrint( "PATIENT: ".$self->Patient."\n" );
  $self->MyPrint( "NURSE: ".$self->Nurse."\n" );
  $self->MyPrint( "####################################################################\n" );

  $i = -1;
  my $starttime = `date "+%s"`;
  my $lastorder = "A";
  while (defined $self->Exercises->[$i + 1]->{Name}) {
    $lasttime = $time;
    my $order = $self->Exercises->[$i + 1]->{ID};
    if ($order =~ /^(.)/) {
      $order = $1;
      if ($order ne $lastorder) {
	my $endtime = `date "+%s"`;
	my $totaltime = $endtime - $starttime;
	$totaltime =~ s/\n//g;
	my ($hours, $minutes, $seconds) = (int($totaltime / 3600.0),int(($totaltime % 3600) / 60),int($totaltime % 60));
	$self->MyPrint( "\n####################################################################\n" );
	$self->MyPrint( "Midpoint time time is: $totaltime\n" );
	$self->MyPrint( "$hours:$minutes:$seconds\n" );
	$self->MyPrint( "This equals: $hours hour(s), $minutes minute(s), and $seconds second(s)\n" );
      }
      $lastorder = $order;
    }
    $self->NextExercise();
  }
  my $endtime = `date "+%s"`;
  my $totaltime = $endtime - $starttime;
  $totaltime =~ s/\n//g;
  my ($hours, $minutes, $seconds) = (int($totaltime / 3600.0),int(($totaltime % 3600) / 60),int($totaltime % 60));
  $self->MyPrint( "\n####################################################################\n" );
  $self->MyPrint( "Total time was: $totaltime\n" );
  $self->MyPrint( "$hours:$minutes:$seconds\n" );
  $self->MyPrint( "This equals: $hours hour(s), $minutes minute(s), and $seconds second(s)\n" );
  $self->MyPrint( "I have logged everything in today's log file.\n" );
  $self->MyPrint( "Logfile is $logfile.\n" );
  close(OUT);
}

sub ParseCommand {
  my ($self,$com) = @_;
  # add feature for going backwards.   Add ability to take notes.  Add
  # interactivity allowing for commenting on mistakes.
  $com;
}

sub NextExercise {
  my ($self,%args) = @_;
  ++$i;
  my $date = `date`;
  $time = `date "+%s"`;
  if (defined $lasttime) {
    $self->MyPrint( "Duration:\t".($time - $lasttime)."\n");
    $self->MyPrint( "--------------------------------------------------------------------\n" );
  }
  $lasttime = $time;
  $self->MyPrint("\n");
  $self->MyPrint( "Date:\t".$date."\n");
  $self->MyPrint( "ID:\t".$self->Exercises->[$i]->{ID}."\n");
  $self->MyPrint( "Name:\t".$self->Exercises->[$i]->{Name}."\n");
  $self->MyPrint( "Desc:\t".$self->Exercises->[$i]->{Description}."\n");
  my $com = <STDIN>;
  $self->ParseCommand($com);
}

sub MyPrint {
  my ($self,$line) = @_;
  print $line;
  print OUT $line;
}

1;
