#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);

my $cgi = CGI->new;
my $expresion = $cgi->param('expression');
my $resultado = evaluar_expresion($expresion);

print $cgi->header('text/html; charset=UTF-8');

sub calcular {
    my $expresion = shift;

    while ($expresion =~ /(-?\d+\.?\d*)\s*([\*\/])\s*(-?\d+\.?\d*)/) {
        my $operando1 = $1;
        my $operador = $2;
        my $operando2 = $3;
        my $resultado;

        if ($operador eq '*') {
            $resultado = $operando1 * $operando2;
        } elsif ($operador eq '/') {
            $resultado = $operando1 / $operando2;
        }

        $expresion =~ s/\Q$operando1$operador$operando2\E/$resultado/;
    }

    while ($expresion =~ /(-?\d+\.?\d*)\s*([\+\-])\s*(-?\d+\.?\d*)/) {
        my $operando1 = $1;
        my $operador = $2;
        my $operando2 = $3;
        my $resultado;

        if ($operador eq '+') {
            $resultado = $operando1 + $operando2;
        } elsif ($operador eq '-') {
            $resultado = $operando1 - $operando2;
        }

        $expresion =~ s/\Q$operando1$operador$operando2\E/$resultado/;
    }

    return $expresion;
}