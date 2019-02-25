#!/usr/bin/perl -l
# we use -l to append \n to every printed line :p
use strict;

my $number=$ARGV[0];

if (!($number=~/^\d+$/)) {
  print "$0 <number> <def1> <def2> [filename]";
  print "  Create the patch test operation with <number> entries.";
  print "  Must pass in Def, /Def, *, etc:";
  print "  E.g.,";
  print "  $0 10000 Def /Def";
  print "  will test 10,000 times, with the Def before the /Def patches.";
  print "  [filename] defaults to PatchTest.xml";
  exit;
}
$number=0+$number;
my ($def1, $def2) = ($ARGV[1], $ARGV[2]);

my $filename = $ARGV[3] || 'PatchTest.xml';
open(my $f, '>', $filename) or die "Could not open $filename";
print "Printing ${number}(x2) tests to $filename, $def1/ThingDef and $def2/ThingDef:";
print $f '<?xml version="1.0" encoding="utf-8" ?>';
print $f '<!-- This is an automatically generated file to test whether';
print $f "     $def1/ThingDef... or $def2/ThingDef... are faster.  It repeats";
print $f '     each xpath operation '.$number.' times.  Enjoy? -->';
print $f '<Patch>';

###############  First set
print "  Printing $def1/ThingDef[defName=\"GeothermalGenerator\"]/...";
print $f <<EOF
<Operation Class=\"LWM.PatchTest.TimeMessage\">
  <message>LWM: Patch Speed Test: Patching via $def1/ThingDef... xpath $number times.</message>
  <command>Start</command>
</Operation>
EOF
;
for (my $i=1; $i<=$number; $i++) {
  print $f <<EOF
<Operation Class=\"PatchOperationReplace\">
  <xpath>$def1/ThingDef[defName=\"GeothermalGenerator\"]/comps/li[\@Class='CompProperties_Power']/basePowerConsumption</xpath>
  <value><basePowerConsumption>-$i</basePowerConsumption></value>
</Operation>
EOF
}
print $f <<EOF
<Operation Class=\"LWM.PatchTest.TimeMessage\">
  <message>LWM: Patch Speed Test: Done with $def1/ThingDef... xpath.</message>
  <command>Stop</command>
</Operation>
EOF
;
############## Second set
print "  Now printing $def2/ThingDef[defName=\"GeothermalGenerator\"]/...";
print $f <<EOF
<Operation Class=\"LWM.PatchTest.TimeMessage\">
  <message>LWM: Patch Speed Test: Patching via $def2/ThingDef... xpath $number times.</message>
  <command>Start</command>
</Operation>
EOF
;
for (my $i=1; $i<=$number; $i++) {
  print $f <<EOF
<Operation Class=\"PatchOperationReplace\">
  <xpath>$def2/ThingDef[defName=\"GeothermalGenerator\"]/comps/li[\@Class='CompProperties_Power']/basePowerConsumption</xpath>
  <value><basePowerConsumption>-$i</basePowerConsumption></value>
</Operation>
EOF
}
print $f <<EOF
<Operation Class=\"LWM.PatchTest.TimeMessage\">
  <message>LWM: Patch Speed Test: Done with $def2/ThingDef... xpath.</message>
  <command>Stop</command>
</Operation>
EOF
;
print $f '</Patch>';
close $f;
print "All done!\n  Have fun storming the castle!";


