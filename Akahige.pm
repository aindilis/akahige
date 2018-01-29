package Akahige;

use Akahige::Exercise;
use BOSS::Config;
use MyFRDCSA;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Config MyExercise / ];

sub init {
  my ($self,%args) = @_;
  $specification = "
	-e			Exercise
";
  $UNIVERSAL::systemdir = ConcatDir(Dir("internal codebases"),"akahige");
  $self->Config(BOSS::Config->new
		(Spec => $specification,
		 ConfFile => ""));
  my $conf = $self->Config->CLIConfig;
  if (exists $conf->{'-u'}) {
    $UNIVERSAL::agent->Register
      (Host => defined $conf->{-u}->{'<host>'} ?
       $conf->{-u}->{'<host>'} : "localhost",
       Port => defined $conf->{-u}->{'<port>'} ?
       $conf->{-u}->{'<port>'} : "9000");
  }
}

sub Execute {
  my ($self,%args) = @_;
  my $conf = $self->Config->CLIConfig;
  if (exists $conf->{'-e'}) {
    $self->MyExercise(Akahige::Exercise->new);
    $self->MyExercise->Execute;
  }
}

1;
