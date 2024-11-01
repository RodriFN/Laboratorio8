#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);

my $cgi = CGI->new;
my $expresion = $cgi->param('expression');
my $resultado = evaluar_expresion($expresion);

print $cgi->header('text/html; charset=UTF-8');
