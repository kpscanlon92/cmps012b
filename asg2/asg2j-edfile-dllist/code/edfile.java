// $Id: edfile.java,v 1.9 2014-04-15 19:24:24-07 - - $

import java.util.Scanner;
import static java.lang.System.*;

class edfile{

   public static void main (String[] args) {
      boolean want_echo = true;
      dllist lines = new dllist ();
      auxlib.STUB ("Check for -e option");
      auxlib.STUB ("Load file from args filename, if any.");
      Scanner stdin = new Scanner (in);
      for (;;) {
         out.printf ("%s: ", auxlib.program_name());
         if (! stdin.hasNextLine()) break;
         String inputline = stdin.nextLine();
         if (want_echo) out.printf ("%s%n", inputline);
         if (inputline.matches ("^\\s*$")) continue;
         char command = inputline.charAt(0);
         switch (command) {
            case '#': break;
            case '$': auxlib.STUB ("Call $ command function."); break;
            case '*': auxlib.STUB ("Call * command function."); break;
            case '.': auxlib.STUB ("Call . command function."); break;
            case '0': auxlib.STUB ("Call 0 command function."); break;
            case '<': auxlib.STUB ("Call < command function."); break;
            case '>': auxlib.STUB ("Call > command function."); break;
            case 'a': auxlib.STUB ("Call a command function."); break;
            case 'd': auxlib.STUB ("Call d command function."); break;
            case 'i': auxlib.STUB ("Call i command function."); break;
            case 'r': auxlib.STUB ("Call r command function."); break;
            case 'w': auxlib.STUB ("Call w command function."); break;
            default : auxlib.STUB ("Print invalid command."); break;
         }
      }
      auxlib.STUB ("(eof)");
   }

}

