// Name: Kelly Scanlon
// User: kpscanlo

// $Id: edfile.java,v 1.23 2014-04-28 20:04:41-07 - - $

import java.util.Scanner;
import static java.lang.System.*;
import static java.lang.Integer.*;
import java.io.*;

class edfile{

   public static int read_file(String file_name, dllist lines) {
      int num_read_lines = 0;
      try {
         FileInputStream fin;
         DataInputStream din;
         BufferedReader buffer;
         
         String curr_line;
         num_read_lines = 0;
         
         fin = new FileInputStream(file_name);
         din = new DataInputStream(fin);
         buffer = new BufferedReader(new InputStreamReader(din));

         while((curr_line = buffer.readLine()) != null) {
            num_read_lines++;
            lines.insert(curr_line, dllist.position.FOLLOWING);
         }
         din.close();
         lines = null;
      } catch (Exception error) {
         num_read_lines = 0;
         auxlib.warn(error.getMessage());
      }
      return num_read_lines;
   }
   
   public static void write_file(String file_name, dllist lines) {
      int num_write_lines = 0;
      try {
         FileWriter fout;
         BufferedWriter buffer;
         num_write_lines = 0;

         fout = new FileWriter(file_name);
         buffer = new BufferedWriter(fout);

         if(!lines.isempty()) {
            lines.setposition(dllist.position.LAST);
            int last = lines.getposition();
            lines.setposition(dllist.position.FIRST);

            for(int inx = 0; inx <= last; inx++) {
               num_write_lines++;
               buffer.write(lines.getitem() + '\n');
               lines.setposition(dllist.position.FOLLOWING);
            }
         }

         out.printf("%d lines written to %s%n",
                     num_write_lines, file_name);
         buffer.close();
         lines = null;
      } catch (Exception error) {
         num_write_lines = 0;
         auxlib.warn(error.getMessage());
      }

   }

   public static void print_line(int position, String line) {
      out.printf("%6d %s%n", position, line);
   }

   public static boolean empty_print(dllist lines_ref) {
      if(lines_ref.isempty()) {
         out.printf("No lines in file%n");
         lines_ref = null;
         return true;
      }
      lines_ref = null;
      return false;
   }

   public static void main (String[] args) {
      boolean want_echo = false;
      dllist lines = new dllist ();

      // Check for -e option
      // Load file from args filename, if any
      int read_lines = 0;
      for(int inx = 0; inx < args.length; inx++) {
         if(args[inx].equals("-e")) {
            want_echo = true;    
            continue;
         }

         read_lines += read_file(args[inx], lines);
      }
      
      if(read_lines != 0)
         out.printf("%d lines read %n", read_lines); 

      Scanner stdin = new Scanner (in);
      for (;;) {
         out.printf ("%s: ", auxlib.program_name());
         if (! stdin.hasNextLine()) break;
         String inputline = stdin.nextLine();
         if (want_echo) out.printf ("%s%n", inputline);
         if (inputline.matches ("^\\s*$")) continue;
         char command = inputline.charAt(0);
         String line_string = inputline.substring(1);
         switch (command) {
            case '#': break;
            case '$':
               if(empty_print(lines)) continue;
               lines.setposition(dllist.position.LAST);
               print_line(lines.getposition(), lines.getitem());
               break;
            case '*':
               lines.print_list();
               lines.setposition(dllist.position.LAST);
               break;
            case '.':
               if(empty_print(lines)) continue;
               print_line(lines.getposition(), lines.getitem());
               break;
            case '0': 
               if(empty_print(lines)) continue;
               lines.setposition(dllist.position.FIRST);
               print_line(lines.getposition(), lines.getitem());
               break;
            case '<':
               if(empty_print(lines)) continue;
               lines.setposition(dllist.position.PREVIOUS);
               print_line(lines.getposition(), lines.getitem());
               break;
            case '>': 
               if(empty_print(lines)) continue;
               lines.setposition(dllist.position.FOLLOWING);
               print_line(lines.getposition(), lines.getitem());
               break;
            case 'a': 
               lines.insert(line_string, dllist.position.FOLLOWING);
               print_line(lines.getposition(), lines.getitem());
               break;
            case 'd': 
               lines.delete();
               print_line(lines.getposition(), lines.getitem());
               break;
            case 'i': 
               lines.insert(line_string, dllist.position.PREVIOUS);
               print_line(lines.getposition(), lines.getitem());
               break;
            case 'r': 
               int new_file_lines = 0;
               new_file_lines = read_file(line_string, lines);
               out.printf("%d lines read from %s%n", 
                           new_file_lines, line_string);
               break;
            case 'w': 
               write_file(line_string, lines);
               break;
            default :
               auxlib.warn("Not a valid command: ", inputline);
               break;
         }
      }
      out.printf("^D%n");
      stdin.close();

      exit(auxlib.exit_status);
   }

}

