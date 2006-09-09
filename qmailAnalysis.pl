#!/usr/bin/perl -w

# This program is designed to read /var/log/maillog on an E-smith 4.1.2
# system ( = RedHat 7.0) and print out who received mail from where.

use strict;

my %smtpd_pids;
my $day;
my $time;
my $hostname;
my $pid;
my $recipient;

while (<>) {
   if (/smtpd\[(\d+)\]: mail from <(.*)>/) {
      $smtpd_pids{$1} = $2;
   } elsif (/^(.*) (.*) .* smtpd\[(\d+)\]: Recipient <(.*)>/) {
      $day=$1; $time=$2; $pid=$3; $recipient=$4;
      print "$day $time (GMT) $smtpd_pids{$pid} -> $recipient\n";
      delete $smtpd_pids{$pid};
   }
}

