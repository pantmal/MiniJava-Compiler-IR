import syntaxtree.*;
import visitor.*;
import java.io.*;

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
                System.out.println("Type check on program: "+s);
                System.out.print("\n");    

                //Parsing the input program.
                fis = new FileInputStream(s);
                MiniJavaParser parser = new MiniJavaParser(fis);
                System.err.println("Program parsed successfully.");
                System.out.print("\n");    
                Goal root = parser.Goal();        
            
                //If the parsing was successful, we move on to the FirstVisitor which will create the Symbol Table and perform declaration checks.
                FirstVisitor eval = new FirstVisitor();

                boolean decl_error = false;

                try{ 
                    root.accept(eval, null);
                }catch(Exception ouch){ //If we encounter any declaration errors, the semantic check ends. 

                    System.out.println("We encountered at least one declaration error! ");  
                    System.out.print("\n");      
                    decl_error = true;

                }

                //We encountered a declaration error, so now we move on to the next program.
                if(decl_error == true){
                    continue;
                }
            
                //Checking if the symbol table has a object from a class that was never declared. If so, we stop the semantic check.
                //This is the only check performed in the main function. All other checks are in the Visitor files.
                for (int counter = 0; counter < eval.idList.size(); counter++) { 		      
                    String id_check = eval.idList.get(counter);
                    if( !(eval.visitor_sym.classId_table.containsKey(id_check)) ){

                        System.out.println("We encountered at least one declaration error! ");    
                        System.out.print("\n");    
                        decl_error = true;
                
                    }
                }
                
                if(decl_error == true){
                    continue;
                }

        
                System.out.println("Our program is free of type errors, moving on to the offset table: ");    
                System.out.print("\n");    

                //Creating the offset table with the OffsetTable class.
                OffsetCreator ot = new OffsetCreator(eval.visitor_sym);
                ot.OutputCreator();
                System.out.print("\n");    

                ClassTable last = eval.visitor_sym.get_last();

                int last1 = 0;
                for (String key : last.ot_table.keySet()) {
                    System.out.println(last.ot_table.get(key));
                    last1 = last.ot_table.get(key);
                }

                /*
                int size = last1;
                if (last.last_type == "int" ){
                    size = size + 4;
                }
                if(last.last_type == "boolean" ){
                    size = size + 1;
                    
                }
                if(last.last_type == "pointer" ){
                    size = size + 8;
                }

                System.out.println(size);
                */

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
