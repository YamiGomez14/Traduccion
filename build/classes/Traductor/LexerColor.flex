import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int) start, size, color);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario} { return textColor(yychar, yylength(), new Color(146, 146, 146)); }
{EspacioEnBlanco} { /*Ignorar*/ }

/* Tipos de datos */
byte | int | char | long | float | double | string | void { return textColor(yychar, yylength(), new Color(148, 58, 173)); }

/* Cadenas */
"\"".*"\"" { return textColor(yychar, yylength(), new Color(255, 0, 0)); }

/* Comillas */
( "\"" ) { return textColor(yychar, yylength(), new Color(255, 0, 0)); }

/*Operadores Booleanos*/
(true | false) { return textColor(yychar, yylength(), new Color(148, 58, 173)); }

/* Marcador de inicio de algoritmo */
( "main" ) { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Palabra reservada If */
( if ) { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Palabra reservada Else */
( else ) { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Palabra reservada Do */
( do ) { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Palabra reservada While */
( while ) { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Palabra reservada For */
( for ) { return textColor(yychar, yylength(), new Color(121, 107, 255)); }

/* Operador Igual */
( "=" ) { return textColor(yychar, yylength(), new Color(169, 155, 179)); }

/* Operador Suma */
( "+" ) { /* Ignorar */ }

/* Operador Resta */
( "-" ) { /* Ignorar */ }

/* Operador Multiplicacion */
( "*" ) { /* Ignorar */ }

/* Operador Division */
( "/" ) { /* Ignorar */ }

/* Operadores logicos */
( "&&" | "||" | "!" | "&" | "|" ) { return textColor(yychar, yylength(), new Color(48, 63, 159)); }

/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) { return textColor(yychar, yylength(), new Color(48, 63, 159)); }

/* Operadores Atribucion */
( "+=" | "-="  | "*=" | "/=" | "%=" ) { return textColor(yychar, yylength(), new Color(48, 63, 159)); }

/* Operadores Incremento y decremento */
( "++" | "--" ) { return textColor(yychar, yylength(), new Color(48, 63, 159)); }

/* Operadores de agrupacion */
"(" | ")" | "{" | "}" | "[" | "]" { return textColor(yychar, yylength(), new Color(169, 155, 179)); } 

/* Signos de puntuacion */
"," | ";" { return textColor(yychar, yylength(), new Color(169, 155, 179)); }

/* identificador */
{Identificador} { /* Ignorar */ }

/* Numero */
{Numero} { return textColor(yychar, yylength(), new Color(35, 120, 147)); }

. { /* Ignorar */ }