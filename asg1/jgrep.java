//Name: Kelly Scanlon
//User: kpscanlo

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
                         Pattern pattern, options opts) {
      int line_count = 0;
      while (input.hasNextLine()) {
         line_count++;
         String line = input.nextLine();
         boolean matches = pattern.matcher(line).find();
         if(opts.reverse_match) {
            matches = !matches;
         }
         if (matches) {
            if(opts.filename_only) {
               messages.exit_status = messages.EXIT_SUCCESS;
               out.printf ("%s%n", filename);
               break;
            } else {
               if(opts.number_lines) {
                  messages.exit_status = messages.EXIT_SUCCESS;
                  out.printf ("%s:%s:%s%n", filename, line_count, line);
               } else {
                  messages.exit_status = messages.EXIT_SUCCESS;
                  out.printf ("%s:%s%n", filename, line);
               }
            }
         }
      }
   }

   public static void main (String[] args) {
      options opts = new options (args);
      try {
         Pattern pattern;
         if(opts.insensitive) {
            pattern = Pattern.compile (opts.regex, 
                                       Pattern.CASE_INSENSITIVE);
         } else {
            pattern = Pattern.compile (opts.regex);
         }
         if (opts.filenames.length == 0) {
            scanfile (new Scanner (in), "(standard input)", 
                        pattern, opts);
         }else {
            for (int argi = 0; argi < opts.filenames.length; ++argi) {
               try {
                  String filename = opts.filenames[argi];
                  Scanner input = new Scanner (new File (filename));
                  scanfile (input, filename, pattern, opts);
                  input.close();
               } catch (IOException error) {
                  messages.warn (error.getMessage());
               }
            }
         }
      } catch (PatternSyntaxException error) {
         messages.die (error.getMessage());
      }
      exit (messages.exit_status);
   }

}

