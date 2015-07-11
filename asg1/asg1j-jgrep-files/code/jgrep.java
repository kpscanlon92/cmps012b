// $Id: jgrep.java,v 1.2 2014-04-02 21:30:12-07 - - $

//
// This program is a stub showing how to create a pattern from a
// regular expression.  It does not handle options or files, and
// has some other bugs which you must discover and fix.
//

import java.io.*;
import java.util.Scanner;
import java.util.regex.*;
import static java.lang.System.*;

class jgrep {

   static void scanfile (Scanner input, String filename,
                         Pattern pattern) {
      while (input.hasNextLine()) {
         String line = input.nextLine();
         boolean matches = pattern.matcher (line).find();
         if (matches) {
            out.printf ("%s:%s%n", filename, line);
         }
      }
   }

   public static void main (String[] args) {
      options opts = new options (args);
      try {
         Pattern pattern = Pattern.compile (opts.regex);
         if (opts.filenames.length == 0) {
            scanfile (new Scanner (in), "<stdin>", pattern);
         }else {
            for (int argi = 1; argi < opts.filenames.length; ++argi) {
               try {
                  String filename = opts.filenames[argi];
                  Scanner input = new Scanner (new File (filename));
                  scanfile (input, filename, pattern);
                  input.close();
               }catch (IOException error) {
                  messages.warn (error.getMessage());
               }
            }
         }
      }catch (PatternSyntaxException error) {
         messages.die (error.getMessage());
      }
      exit (messages.exit_status);
   }

}

