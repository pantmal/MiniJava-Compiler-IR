import syntaxtree.*;
import visitor.*;
import java.io.*;
import java.io.FileWriter;   // Import the FileWriter class


public class Main {
    public static void main (String [] args) throws Exception {

        //Printing an error message if there aren't any input files.
        if(args.length < 1){
            System.err.println("Usage: java Main <inputFile1> <inputFile2> ... <inputFileN> ");
            System.exit(1);
        }

        FileInputStream fis = null;


        try{

            for (String s: args) {
                System.out.println("Generating LLVM IR code for program: "+s);
                System.out.print("\n");    

                String ll_file = s.replace(".java","");
                ll_file = ll_file + ".ll";

                //Parsing the input program.
                fis = new FileInputStream(s);
                MiniJavaParser parser = new MiniJavaParser(fis);
                System.err.println("Program parsed successfully.");
                System.out.print("\n");    
                Goal root = parser.Goal();        
            
                //If the parsing was successful, we move on to the FirstVisitor which will create the Symbol Table and perform declaration checks.
                FirstVisitor eval = new FirstVisitor();
                root.accept(eval, null);
                

                FileWriter myWriter = new FileWriter(ll_file);
                
                //Creating the offset table with the OffsetTable class.
                OffsetTable ot = new OffsetTable(eval.visitor_sym);
                ot.OffsetCreator();
                ot.VTableCreator(myWriter);
                ot.BoilerPlate(myWriter);

                LLVM_Visitor ll_eval = new LLVM_Visitor(eval.visitor_sym,myWriter);
                root.accept(ll_eval, null);

                System.out.println("LLVM IR code successfully written to: "+ll_file+" !\n"); 

                myWriter.close();
            }

        }

        catch(ParseException ex){
            System.out.println(ex.getMessage());
        }

        catch(FileNotFoundException ex){
            System.err.println(ex.getMessage());
        }

        finally{

            try{
                if(fis != null) fis.close();
            }
            catch(IOException ex){
                System.err.println(ex.getMessage());
            }
        }


    }


}
