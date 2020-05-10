import visitor.*;
import syntaxtree.*;
import java.util.*;
import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;  // Import the IOException class to handle errors


//Offset Table will create the offsets of a semantically correct Minijava program.
public class OffsetCreator {

    public SymbolTable visitor_sym;

    //The constructor gets the SymbolTable object. 
    public OffsetCreator(SymbolTable st){
        this.visitor_sym = st;   
    }

    //OutputCreator function creates our output.
    public void OutputCreator(){

        //For every class in the classId table
        for (String id : visitor_sym.classId_table.keySet()) {
            
            //We get its Class Table.
            ClassTable temp = visitor_sym.classId_table.get(id);

            //Skipping the Main class since it doesn't have any fields or methods.
            if (temp.methodId_table!=null){
                if(temp.methodId_table.containsKey("main")){
                    continue;
                }
            }

            System.out.println("-------Class "+id+"-------" );

            //Getting the field offsets.
            System.out.println("--Variables--" );
            if(temp.field_table!=null){


                int counter = 0; //Counter of which field we're on.
                int ot_sum = 0; //Ot_sum is the sum of all field offsets.
                String last_type = null; //The last type of the fields.

                int last_count = 0; //Used in case we're in a hierarchy.
                String last_type_class = null; //The last type from a field table in the mother class.

                for (String f_id : temp.field_table.keySet()) {
                    
                    
                    //Getting the type of the field.
                    String Type = temp.field_table.get(f_id);
                    last_type = Type;
                    
                    //If it's the first field print 0, except if we're in a hierarchy. If so, get the offset sum of the previous mother class.
                    if (counter == 0){
                        if(temp.mother == null){
                            System.out.println(id+"."+f_id+" : 0" );
                            temp.ot_insert(f_id,8);
                        }else{
                            
                            //Getting the last offset sum from the mother class.
                            last_count = visitor_sym.find_field_table(id);

                            //Getting the last type from the mother class.
                            last_type_class = visitor_sym.find_last_type(id);

                            //The first offset in a child class is going to be added up from the last type of its mother.
                            if(last_type_class == "int" ){
                                last_count = last_count + 4;
                                temp.ot_insert(f_id,last_count+8);
                            }
                            if(last_type_class == "boolean" ){
                                last_count = last_count + 1;
                                temp.ot_insert(f_id,last_count+8);
                            }
                            if(last_type_class == "pointer"){
                                last_count = last_count + 8;
                                temp.ot_insert(f_id,last_count+8);
                            }
                            
                            System.out.println(id+"."+f_id+" : "+last_count );

                            //Used for the next child classes.
                            ot_sum = last_count;
                        }
                    }else{ //If it's not the first item we will go to every previous field and create the sum.
                        
                        int w_counter = counter;

                        int sum = 0 ;
                        if (last_count != 0){
                            sum = last_count;
                        }else{
                            sum = 0;
                        }
                        

                        w_counter--;
                        while(w_counter >= 0 ){

                            //Getting the field by index, then its type.
                            String field = temp.getKey(w_counter);
                            String f_type = temp.field_table.get(field);

                            //Adding up the necessary offsets.
                            if(f_type == "int" ){
                                sum = sum + 4;
                                temp.ot_insert(f_id,sum+8);
                            }
                            if(f_type == "boolean" ){
                                sum = sum + 1;
                                temp.ot_insert(f_id,sum+8);
                            }
                            if(f_type == "boolean[]" || f_type == "int[]" || visitor_sym.classId_table.containsKey(f_type) ){
                                sum = sum + 8;
                                temp.ot_insert(f_id,sum+8);
                            }

                            w_counter--;

                        }

                        System.out.println(id+"."+f_id+" : "+sum );

                        ot_sum = sum;

                    }
                    
                    counter++;
                }

                String last_type_s = null;

                int size = ot_sum;

                //Storing the last type. It will be used if there is a child class that inherits from our current class.
                if(last_type == "int" ){
                    last_type_s = "int";
                    size = size + 4;
                }
                if(last_type == "boolean" ){
                    last_type_s = "boolean";
                    size = size + 1;
                }
                if(last_type == "boolean[]" || last_type == "int[]" || visitor_sym.classId_table.containsKey(last_type) ){
                    last_type_s = "pointer";
                    size = size + 8;
                }

                //Storing the field offset sum and last type in the Class Table, in case they are needed by a child class.
                temp.ot_sum = ot_sum;
                temp.last_type = last_type_s;

                temp.size = size+8;

                
            }else{
                temp.size = 8;
            }

            //Moving on to the method offsets.
            System.out.println("--Methods--" );
            if(temp.methodId_table!=null){
                
                int counter = 0; //Counter of which methodId we're on.
                int mt_sum = 0; //Mt_sum is the sum of all metthod offsets.
                int v_count = 0;

                int last_count = 0; //Used in case we're in a hierarchy.

                for (String m_id : temp.methodId_table.keySet()) {

                    //If we're in a hierarchy we need to skip overriden functions.
                    String new_mother = visitor_sym.mother_search(id,m_id);
                    if (new_mother != null){
                        temp.over_insert(m_id);
                        continue;
                    }

                    //If it's the first method print 0, except if we're in a hierarchy. If so, get the offset sum of the previous mother class.
                    if (counter == 0){
                        
                        if(temp.mother == null){
                            System.out.println(id+"."+m_id+" : 0" );
                            temp.vt_insert(m_id,v_count);
                            v_count++;

                        }else{
                            
                            //Getting the last offset sum from the mother class.
                            last_count = visitor_sym.find_methodId_table(id);

                            v_count = visitor_sym.find_v_table(id);
                            v_count++;

                            //-1 is returned in case the mother class is the Main. We must not add the offsets of the main function. So -1 is used to skip it.
                            if (last_count == -1){
                                last_count = 0;
                            }else{ //The first offset in a child class is going to be added up from the last method of its mother.
                                last_count = last_count + 8;
                            }

                            System.out.println(id+"."+m_id+" : "+last_count );
                            temp.vt_insert(m_id,v_count);
                            v_count++;

                            //Used for the next child classes.
                            mt_sum = last_count;
                        }
                    }else{ //If it's not the first item we will go to every previous field and create the sum.

                        temp.vt_insert(m_id,v_count);
                        v_count++;

                        int w_counter = counter;
                        w_counter--;

                        int sum;
                        if (last_count != 0){
                            sum = last_count;
                        }else{
                            sum = 0;
                        }
                        
                        //We add 8 to the sum for every function.
                        while(w_counter >= 0 ){

                            sum = sum + 8;

                            w_counter--;

                        }

                        System.out.println(id+"."+m_id+" : "+sum );

                        mt_sum = sum;

                    }
                    counter++;
                }

                //Storing the method offset sum in the Class Table.
                temp.mt_sum = mt_sum;
                temp.last_vcount = --v_count;

            }

            System.out.print("\n");
       }

    }

    public String get_type(String type){
        String return_type = null;
        if(type == "int" ){
            return_type = "i32";
        }
        if(type == "boolean" ){
            return_type = "i1";
        }
        if(type == "boolean[]" || type == "int[]" || visitor_sym.classId_table.containsKey(type) ){
            return_type = "i8*";
        }

        return return_type;
    }


    public void VTableCreator(FileWriter ll){

        for (String id : visitor_sym.classId_table.keySet()) {
            
            ClassTable temp = visitor_sym.classId_table.get(id);

            if (temp.mother == null){

                try {
                    if (temp.methodId_table!=null){
                        if(temp.methodId_table.containsKey("main")){
                            ll.write("@."+id+"_vtable = global [0 x i8*] [] \n");
                            continue;
                        }
                    }

                    if (temp.v_table!=null){
                        int v_table_size = temp.get_last_v();
                        v_table_size++;

                        ll.write("@."+id+"_vtable = global [ "+v_table_size+ " x i8*] [  \n");
                        if(temp.methodId_table!=null){
                
                            int m_count = 0;
                            for (String m_id : temp.methodId_table.keySet()) {
                                
                                Tuple<String, MethodTable> tupe;
                                tupe = temp.methodId_table.get(m_id);

                                String return_type = get_type(tupe.x);
                                
                                ll.write("\ti8* bitcast ("+return_type+" (i8*");

                                int p_count = 0 ;

                                if (tupe.y.param_table == null){
                                    ll.write(")*");
                                }else{

                                    ll.write(",");

                                    int param_table_size = tupe.y.param_table.size();
                                    for (String param : tupe.y.param_table.keySet()) {
                                        
                                        String type = tupe.y.param_table.get(param);
                                        String output_type = get_type(type);

                                        ll.write(output_type);
                                        
                                        p_count++;

                                        if(p_count == param_table_size){
                                            ll.write(")*");
                                        }else{
                                            ll.write(",");
                                        }

                                    }
                                }
                                
                                ll.write(" @"+id+"."+m_id+" to i8*)");

                                m_count++;
                                if(m_count == v_table_size){
                                    ll.write("\n]\n");
                                }else{
                                    ll.write(",\n");
                                }


                            }

                        }

                    }else{
                        ll.write("@."+id+"_vtable = global [0 x i8*] [] \n");
                    }


                } catch (IOException e) {
                    System.out.println("An error occurred.");
                    e.printStackTrace();
                }

                

            }else{
                
                try {
                    Stack hierarchy = new Stack(); 
                    visitor_sym.recurse_push(hierarchy,id);

                    //Add checks!

                    int v_table_size = 0;
                    if(temp.v_table == null){
                        v_table_size = visitor_sym.find_v_table(id);
                        v_table_size++;
                    }else{
                        v_table_size = temp.get_last_v();
                        v_table_size++;
                    }

                    

                    ll.write("@."+id+"_vtable = global [ "+v_table_size+ " x i8*] [  \n");

                    while(hierarchy.empty()==false){

            
                        String curr_id = (String) hierarchy.peek(); //Getting the last counter.
                        ClassTable curr_temp = visitor_sym.classId_table.get(curr_id);

                        if (curr_temp.v_table!=null){
                                                        
                            if(curr_temp.methodId_table!=null){
                    
                                int m_count = 0;
                                for (String m_id : curr_temp.methodId_table.keySet()) {

                                    if (m_count > 0){
                                        ll.write(",\n");
                                    }

                                    String child_class = null;


                                    for(int i = hierarchy.size() - 1; i >= 0; i--){
                                        String obj = (String) hierarchy.get(i);
                                        if(curr_id == obj){
                                            continue;
                                        }

                                        ClassTable obj_temp = visitor_sym.classId_table.get(obj);

                                        if(obj_temp.overriden_functions.contains(m_id)){
                                            child_class = obj;
                                        }
                                    }
            
                                    
                                    String new_mother = visitor_sym.mother_search(curr_id,m_id);
                                    if (new_mother != null){
                                        m_count++;
                                        continue;
                                    }
                                    
                                    Tuple<String, MethodTable> tupe;
                                    tupe = curr_temp.methodId_table.get(m_id);

                                    String return_type = get_type(tupe.x);
                                    
                                    ll.write("\ti8* bitcast ("+return_type+" (i8*");

                                    int p_count = 0 ;
                                    if (tupe.y.param_table == null){
                                        ll.write(")*");
                                    }else{

                                        ll.write(",");

                                        int param_table_size = tupe.y.param_table.size();
                                        for (String param : tupe.y.param_table.keySet()) {
                                            
                                            String type = tupe.y.param_table.get(param);
                                            String output_type = get_type(type);

                                            ll.write(output_type);
                                            
                                            p_count++;

                                            if(p_count == param_table_size){
                                                ll.write(")*");
                                            }else{
                                                ll.write(",");
                                            }

                                        }
                                    }
                                    
                                    
                                    if (child_class == null){
                                        ll.write(" @"+curr_id+"."+m_id+" to i8*)");
                                    }else{
                                        ll.write(" @"+child_class+"."+m_id+" to i8*)");
                                    }

                                    

                                    m_count++;
                                    
                                


                                }

                            }

                        }//else{
                        //    ll.write("\n");
                        //}
                        hierarchy.pop();

                    }

                    ll.write("\n]\n");

                }catch (IOException e) {
                    System.out.println("An error occurred.");
                    e.printStackTrace();
                }


            }

        }

    
    
    }


    public void BoilerPlate(FileWriter ll){

        try{

            ll.write("\ndeclare i8* @calloc(i32, i32)\n");
            ll.write("declare i32 @printf(i8*, ...)\n");
            ll.write("declare void @exit(i32) \n \n");

            ll.write("@_cint = constant [4 x i8] c\"%d\\0a\\00\" \n");
            ll.write("@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\" \n");
            ll.write("define void @print_int(i32 %i) { \n");
            ll.write("\t%_str = bitcast [4 x i8]* @_cint to i8* \n");
            ll.write("\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i) \n");
            ll.write("\tret void \n");
            ll.write("}\n \n");

            ll.write("define void @throw_oob() {\n");
            ll.write("\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n");
            ll.write("\tcall i32 (i8*, ...) @printf(i8* %_str)\n");
            ll.write("\tcall void @exit(i32 1)\n");
            ll.write("\tret void \n");
            ll.write("}\n \n");
        

        }catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }


    }


    
}