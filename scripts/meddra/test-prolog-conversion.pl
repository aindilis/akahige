#!/usr/bin/perl -w

use KBS2::ImportExport;
use KBS2::Util;
use PerlLib::SwissArmyKnife;

my $importexport = KBS2::ImportExport->new();
my $res1 = $importexport->Convert
  (
   Input => [['a','ALL',Var('?ALL')]],
   InputType => 'Interlingua',
   OutputType => 'Prolog',
  );
print Dumper($res1);
