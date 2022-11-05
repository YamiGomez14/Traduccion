package compilador_final;


import jflex.exceptions.SilentExit;

/**
 *
 * @author Yamilka Gomez
 */
public class ExecuteJFlex {

    public static void main(String omega[]) {
        String lexerFile = System.getProperty("user.dir") + "\\src\\compilador_final\\Lexer.flex",
                lexerFileColor = System.getProperty("user.dir") + "\\src\\compilador_final\\LexerColor.flex";
        
        try {
            jflex.Main.generate(new String[]{lexerFile, lexerFileColor});
        } catch (SilentExit ex) {
            System.out.println("Error al compilar/generar el archivo flex: " + ex);
        }
    }
}
