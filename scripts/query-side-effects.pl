#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

use LWP::UserAgent;

$specification = q(
	-d <drugs>...		Drug names to search for
	-t <template>		Output HTML/TXT filename template
	-o			Overwrite
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $ua = LWP::UserAgent->new;

# my $server_endpoint = "http://sideeffects.embl.de/";
# my $server_endpoint = "http://sideeffects.embl.de/drugs/";
# my $server_endpoint = "http://sideeffects.embl.de/drugs/59708/";
my $server_endpoint = "http://sideeffects.embl.de/se/";

my @res;
foreach my $drug (@{$conf->{'-d'}}) {
  push @res, SearchDrugSideEffects
    (
     Drug => $drug,
     Template => ($conf->{'-t'} || '/tmp/side-effects-'),
    );
}
print Dumper(\@res);

sub SearchDrugSideEffects {
  my (%args) = @_;
  my $res = {};

  # set custom HTTP request header fields
  my $req = HTTP::Request->new(POST => $server_endpoint);

  # $req->header('content-type' => 'application/json');
  # $req->header('x-auth-token' => 'kfksj48sdfj4jd9d');

  # add POST data to HTTP request body
  my $post_data = '{ "search": '.$args{Drug}.' }';
  $req->content($post_data);

  my $tmphtmlfile = $args{Template}.cleanForFilename($args{Drug}).'.html';
  my $tmptxtfile = $args{Template}.cleanForFilename($args{Drug}).'.txt';

  if (! -f $tmphtmlfile and ! $conf->{'-o'}) {
    my $resp = $ua->request($req);
    if ($resp->is_success) {
      my $message = $resp->decoded_content;
      my $fh = IO::File->new();
      $fh->open(">$tmphtmlfile") or die "No!!!!!!!!!!\n";
      print $fh $message;
      $fh->close();
    } else {
      print "HTTP POST error code: ", $resp->code, "\n";
      print "HTTP POST error message: ", $resp->message, "\n";
    }
  }

  if (! -f $tmptxtfile or $conf->{'-o'}) {
    if (-f $tmphtmlfile ) {
      my $command = 'w3m -dump '.shell_quote($tmphtmlfile).' > '.shell_quote($tmptxtfile);
      system $command;
      $res->{htmlfile} = $tmphtmlfile;
    }
  }

  if (-f $tmptxtfile) {
    $res->{txtfile} = $tmptxtfile;
  }
  return $res;
}

sub cleanForFilename {
  my ($text) = @_;
  $text =~ s/[^a-zA-Z0-9-_]/_/sg;
  $text =~ s/_+/_/sg;
  $text =~ s/^_+//sg;
  $text =~ s/_+$//sg;
  return $text;
}
