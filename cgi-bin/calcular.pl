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

print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculadora</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="header-background">
        <h1>CALCULADORA DE EXPRESIONES</h1>
        <p class="author">Rodrigo Francisco Flores Nuñez</p>
    </div>
    <div class="input-section">
        <form action="calcular.pl" method="post">
            <div class="input-box">
                <label for="expression">Ingrese la operación a realizar:</label>
                <input type="text" id="expression" name="expression" value="$expresion" required>
                <input type="submit" value="Calcular expresión" class="btn-calcular">
            </div>
        </form>
        <div class="resultado">
            <p><strong>Resultado:</strong> $resultado</p>
        </div>
    </div>
</body>
</html>
HTML
