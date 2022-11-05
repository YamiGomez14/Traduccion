import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
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
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/* Tipos de datos */
byte | int | char | long | float | double | string | void { return token(yytext(), "Tipo_Dato", yyline, yycolumn); }

/* Cadenas */
"\"".*"\"" { return token(yytext(), "Cadena", yyline, yycolumn); }

/* Comillas */
( "\"" ) { return token(yytext(), "Comillas", yyline, yycolumn); }

/*Operadores Booleanos*/
(true | false) { return token(yytext(), "Op_Booleano", yyline, yycolumn); }

/* Marcador de inicio de algoritmo */
( "main" ) { return token(yytext(), "Main", yyline, yycolumn); }

/* Palabra reservada If */
( if ) { return token(yytext(), "If", yyline, yycolumn); }

/* Palabra reservada Else */
( else ) { return token(yytext(), "Else", yyline, yycolumn); }

/* Palabra reservada Do */
( do ) { return token(yytext(), "Do", yyline, yycolumn); }

/* Palabra reservada While */
( while ) { return token(yytext(), "While", yyline, yycolumn); }

/* Palabra reservada For */
( for ) { return token(yytext(), "For", yyline, yycolumn); }

/* Operador Igual */
( "=" ) { return token(yytext(), "Igual", yyline, yycolumn); }

/* Operador Suma */
( "+" ) { return token(yytext(), "Op_Suma", yyline, yycolumn); }

/* Operador Resta */
( "-" ) { return token(yytext(), "Op_Resta", yyline, yycolumn); }

/* Operador Multiplicacion */
( "*" ) { return token(yytext(), "Op_Multiplicacion", yyline, yycolumn); }

/* Operador Division */
( "/" ) { return token(yytext(), "Op_Division", yyline, yycolumn); }

/* Operadores logicos */
( "&&" | "||" | "!" | "&" | "|" ) { return token(yytext(), "Op_Logico", yyline, yycolumn); }

/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) { return token(yytext(), "Op_Relacional", yyline, yycolumn); }

/* Operadores Atribucion */
( "+=" | "-="  | "*=" | "/=" | "%=" ) { return token(yytext(), "Op_Atribucion", yyline, yycolumn); }

/* Operadores Incremento y decremento */
( "++" | "--" ) { return token(yytext(), "Op_Incremento_Decremento", yyline, yycolumn); } 

/* Operadores de agrupacion */
"(" { return token(yytext(), "Parentesis_A", yyline, yycolumn); }
")" { return token(yytext(), "Parentesis_C", yyline, yycolumn); }
"{" { return token(yytext(), "Llave_A", yyline, yycolumn); }
"}" { return token(yytext(), "Llave_C", yyline, yycolumn); }
"[" { return token(yytext(), "Corchete_A", yyline, yycolumn); }
"]" { return token(yytext(), "Corchete_C", yyline, yycolumn); }

/* Signos de puntuacion */
"," { return token(yytext(), "Coma", yyline, yycolumn); }
";" { return token(yytext(), "Punto_Coma", yyline, yycolumn); }

/* identificador */
{Identificador} { return token(yytext(), "Identificador", yyline, yycolumn); }

/* Numero */
{Numero} { return token(yytext(), "Numero", yyline, yycolumn); }

. { return token(yytext(), "Error", yyline, yycolumn); }