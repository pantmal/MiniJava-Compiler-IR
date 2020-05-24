import visitor.*;
import syntaxtree.*;
import java.util.*;
import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;  // Import the IOException class to handle errors


//The LLVM_Visitor will print the information we need in the .ll file.
public class LLVM_Visitor extends GJDepthFirst<String, String>{
    
    //These fields are "inherited" from the type-checking visitor from the prevous assignment.
    public SymbolTable visitor_sym; //The SymbolTable of this Visitor.
    public String curr_class; //Curr_class will get the "scope" of the last class we're on.
    public String curr_meth; //Curr_class will get the "scope" of the last method we're on.
    public Stack counterStack; //counterStack will used to store some counters. Its usage will be explained in the MessageSend visit.
    public boolean give_type; //Give_type will be used in order to get the type of the identifier.
    // Will be set to false in some cases because we may need the name of the identifier and not its type. 

    //These fields are new ones from the LLVM visitor.
    public FileWriter ll; //The ll file.
    int global_counter; //Counter used for temp variables.
    int label_counter; //Counter used for labels.
    public boolean in_assign; //This field and the following ones will be explained later on.
    public boolean not_load;
    public Stack q_Stack;
    public String hold_type;
    
    //The constructor gets the SymbolTable object, the ll file and initializes the counters. 
    public LLVM_Visitor(SymbolTable st, FileWriter ll_arg){ 
        this.visitor_sym = st;
        this.ll = ll_arg;   

        global_counter = -1;
        label_counter = -1;
    }

    //Getting the appropriate type in LLVM format.
    public String get_type(String type){
        String return_type = null;
        if(type == "int" ){
            return_type = "i32";
        }
        if(type == "boolean" ){
            return_type = "i1";
        }
        if(type == "boolean[]" || visitor_sym.classId_table.containsKey(type) ){
            return_type = "i8*";
        }
        if(type == "int[]" ){
          return_type = "i32*";
        }

        return return_type;
    }

    //Function used to get a new temp variable.
    public String global_increment(){

      global_counter++;
      String s = String.valueOf(global_counter);
      String temps = "%_";  
      temps = temps+s;

      return temps;

    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> ( VarDeclaration() )*
    * f15 -> ( Statement() )*
    * f16 -> "}"
    * f17 -> "}"
    */
   public String visit(MainClass n, String argu) throws Exception {
    String _ret=null;
    n.f0.accept(this, argu);

    //Setting the scope of the Main class and main method using the curr_class and curr_meth fields.
    this.give_type = false;
    this.in_assign = false;
    String main_class = n.f1.accept(this, argu);
    this.curr_class = main_class;

    n.f2.accept(this, argu);
    n.f3.accept(this, argu);
    n.f4.accept(this, argu);
    n.f5.accept(this, argu);

    String main = n.f6.accept(this, argu);
    this.curr_meth = main;

    n.f7.accept(this, argu);
    n.f8.accept(this, argu);
    n.f9.accept(this, argu);
    n.f10.accept(this, argu);

    this.give_type = false;
    this.in_assign = false;
    String id = n.f11.accept(this, argu);

    ll.write("define i32 @main() {\n");

    n.f12.accept(this, argu);
    n.f13.accept(this, argu);
    n.f14.accept(this, argu);
    n.f15.accept(this, argu);
    n.f16.accept(this, argu);
    n.f17.accept(this, argu);
    
    ll.write("\tret i32 0\n");
    ll.write("}\n \n");
    return _ret;
  }


    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
    public String visit(ClassDeclaration n, String argu) throws Exception {

        String _ret=null;
    
        n.f0.accept(this, argu);
    
        //Setting the scope of the current class we're on.
        this.give_type = false;
        this.in_assign = false;
        String class_name = n.f1.accept(this, argu);
        this.curr_class = class_name;
    
        n.f2.accept(this, argu);
        //n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
    
        return _ret;
     }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
    public String visit(ClassExtendsDeclaration n, String argu) throws Exception {
        String _ret=null;

        n.f0.accept(this, argu);

        //Setting the scope of the current class we're on.
        this.give_type = false;
        this.in_assign = false;
        String class_name = n.f1.accept(this, argu);
        this.curr_class = class_name;

        n.f2.accept(this, argu);
        
        this.give_type = false;
        this.in_assign = false;
        n.f3.accept(this, argu);

        n.f4.accept(this, argu);
       //n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        return _ret;
     }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
     public String visit(VarDeclaration n, String argu) throws Exception {
        String _ret=null;

        this.give_type = false;
        this.in_assign = false;
        String Type = n.f0.accept(this, argu);
        String output_type = get_type(Type);

        this.give_type = false;
        this.in_assign = false;
        String id = n.f1.accept(this, argu);

        //Getting the ClassTable object of our current class in order to print the local variables.
        ClassTable temp = visitor_sym.classId_table.get(curr_class);
        
        if( temp.methodId_table != null){

          if(temp.methodId_table.containsKey(curr_meth)){

            Tuple<String,MethodTable> tupe = temp.methodId_table.get(curr_meth);

            if (tupe.y.already_printed != true){ //Already_printed boolean is used because some local tables were being read twice, for some reason..
          
              if ( tupe.y.local_table != null ){
                for (String i : tupe.y.local_table.keySet()) { 

                  //Getting the output_type of the local variable and printing an alloca command to allocate space for it.
                  String curr_Type = tupe.y.local_table.get(i);
                  String output_type_arg = get_type(curr_Type);

                  ll.write("\t%"+i+" = alloca "+output_type_arg+"\n");
                  tupe.y.already_printed = true;
                  
                }
            
              }
            }

          }
        }

        n.f2.accept(this, argu);

        return _ret;
     }


    /**
    * f0 -> "public"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( FormalParameterList() )?
    * f5 -> ")"
    * f6 -> "{"
    * f7 -> ( VarDeclaration() )*
    * f8 -> ( Statement() )*
    * f9 -> "return"
    * f10 -> Expression()
    * f11 -> ";"
    * f12 -> "}"
    */
    public String visit(MethodDeclaration n, String argu) throws Exception {
        String _ret=null;

        n.f0.accept(this, argu);

        this.give_type = false;
        this.in_assign = false;
        String ret_type = n.f1.accept(this, argu);
        

        //Setting the scope of the current method we're on.
        this.give_type = false;
        this.in_assign = false;
        String meth_name = n.f2.accept(this, argu);
        this.curr_meth = meth_name;

        //Writing the definition of this method.
        String output_type = get_type(ret_type);
        ll.write("define "+output_type+" @"+curr_class+"."+curr_meth+"(i8* %this");

        //Getting the ClassTable object of our current class in order to print the parameters (in the function body).
        ClassTable temp = visitor_sym.classId_table.get(curr_class);
        Tuple<String, MethodTable> tupe;
        if( temp.methodId_table != null ){ 

          tupe = temp.methodId_table.get(curr_meth);

          if (tupe.y.param_table != null ){ //Add a comma if there are more than one parameters.
            if (tupe.y.param_table.size() > 0 ){
              ll.write(", ");
            }
          }
          
        }

        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);


        ll.write(") {\n");
        
        if( temp.methodId_table != null ){ 

          tupe = temp.methodId_table.get(curr_meth);

          if (tupe.y.param_table != null ){
        
            for (String i : tupe.y.param_table.keySet()) {

              //Getting the output_type of the parameter and printing an alloca command to allocate space for it.
              String curr_Type = tupe.y.param_table.get(i);
              String output_type_arg = get_type(curr_Type);

              ll.write("\t%"+i+" = alloca "+output_type_arg+"\n");
              ll.write("\tstore "+output_type_arg+" %."+i+", "+output_type_arg+"* %"+i+"\n");
            }
          }
          
        }

        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        n.f9.accept(this, argu);

        //In_assign here is set to true because we need to get a variable containing the value of an expression.
        this.in_assign = true;
        this.give_type = false;
        String expr_ret = n.f10.accept(this, argu);

        ll.write("\tret "+output_type+" "+expr_ret+"\n"); //Printing the return statement.
        
        n.f11.accept(this, argu);
        n.f12.accept(this, argu);

        ll.write("}\n \n");

        return _ret;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
    public String visit(FormalParameter n, String argu) throws Exception {
      String _ret=null;


      this.give_type = false;
      this.in_assign = false;
      String Type = n.f0.accept(this, argu);
      String output_type = get_type(Type);

      this.in_assign = false;
      this.give_type = false;
      String id = n.f1.accept(this, argu);

      ll.write(output_type+" %."+id); //Printing the type and name of the parameter in the method definiton.

      return _ret;

    }


    /**
    * f0 -> ","
    * f1 -> FormalParameter()
    */
   public String visit(FormalParameterTerm n, String argu) throws Exception {
    String _ret=null;
    n.f0.accept(this, argu);

    ll.write(", ");

    n.f1.accept(this, argu);
    return _ret;
 }

    /**
    * f0 -> Identifier()
    * f1 -> "="
    * f2 -> Expression()
    * f3 -> ";"
    */
  public String visit(AssignmentStatement n, String argu) throws Exception {
    
    String _ret=null;

    //Getting the left type and its output format.
    this.give_type = true;
    this.in_assign = false;
    String l_Type = n.f0.accept(this, argu);
    String output_type = get_type(l_Type);

    //Getting the name of the identifier.
    this.give_type = false;
    this.in_assign = false;
    String l_name = n.f0.accept(this, argu);
    
    ClassTable temp = visitor_sym.classId_table.get(curr_class);
    Tuple<String, MethodTable> tupe = temp.methodId_table.get(curr_meth);

    //In the following checks we check if the variable is a field.
    //If it is, we call field_access (or mother_field_access) in order to print the commands we need to get the field.

    this.not_load = true; //Not_load is set to true because we must not load the value of the field.

    //Both parameter and local variable tables are null
    if ( tupe.y.param_table == null && tupe.y.local_table == null  ){
      if ( temp.field_table != null  ){
        if( temp.field_table.containsKey(l_name) ) {
          l_name = field_access(temp, l_name);
        }else{
          l_name = mother_field_access(temp, l_name, global_counter);
        }
      }else{
        l_name = mother_field_access(temp, l_name, global_counter);
      }
    }

    //Only parameter table is null. 
    if ( tupe.y.param_table == null && tupe.y.local_table != null  ){
      if ( !tupe.y.local_table.containsKey(l_name)  ){
        if ( temp.field_table != null  ){
          if( temp.field_table.containsKey(l_name) ) {
            l_name = field_access(temp, l_name);
          }else{
            l_name = mother_field_access(temp, l_name, global_counter);
          }
        }else{
          l_name = mother_field_access(temp, l_name, global_counter);
        }
      }
    }

    //Only local table is null. 
    if ( tupe.y.param_table != null && tupe.y.local_table == null  ){
      if ( !tupe.y.param_table.containsKey(l_name)  ){
        if ( temp.field_table != null  ){
          if( temp.field_table.containsKey(l_name) ) {
            l_name = field_access(temp, l_name);
          }else{
            l_name = mother_field_access(temp, l_name, global_counter);
          }
        }else{
          l_name = mother_field_access(temp, l_name, global_counter);
        }
      }
    }

    //Both parameter and local tables have at least one variable.
    if ( tupe.y.param_table != null && tupe.y.local_table != null  ){
      if ( !tupe.y.param_table.containsKey(l_name)  ){
        if ( !tupe.y.local_table.containsKey(l_name) ){
          if ( temp.field_table != null  ){
            if( temp.field_table.containsKey(l_name) ) {
              l_name = field_access(temp, l_name);
            }else{
              l_name = mother_field_access(temp, l_name, global_counter);
            }
          }else{
            l_name = mother_field_access(temp, l_name, global_counter);
          }
        }
      }
    }
    this.not_load = false;

  
    n.f1.accept(this, argu);

    //Getting the right value.
    this.in_assign = true;
    this.give_type = false;
    String r_val = n.f2.accept(this, argu);

    //Storing the value in the l_name variable.
    if(l_name.startsWith("%")){ //Variables that come from fields already begin with '%' so don't print it again.
      ll.write("\tstore "+output_type+" "+r_val+","+output_type+"* "+l_name+"\n");
    }else{
      ll.write("\tstore "+output_type+" "+r_val+","+output_type+"* %"+l_name+"\n");
    }

    
    n.f3.accept(this, argu);
    this.give_type = false;
    ll.write("\n");

    return _ret;
 }

    /**
    * f0 -> Identifier()
    * f1 -> "["
    * f2 -> Expression()
    * f3 -> "]"
    * f4 -> "="
    * f5 -> Expression()
    * f6 -> ";"
    */
    public String visit(ArrayAssignmentStatement n, String argu) throws Exception {
      String _ret=null;

      //Getting the array type and its output format.
      this.give_type = true;
      this.in_assign = false;
      String l_Type = n.f0.accept(this, argu);

      //Getting the name of the identifier.
      this.give_type = false;
      this.in_assign = false;
      String l_name = n.f0.accept(this, argu);
      
      ClassTable temp = visitor_sym.classId_table.get(curr_class);
      Tuple<String, MethodTable> tupe = temp.methodId_table.get(curr_meth);

      //In the following checks we check if the variable is a field.
      //If it is, we call field_access (or mother_field_access) in order to print the commands we need to get the field.

      this.not_load = true;//Not_load is set to true because we must not load the value of the field.

      //Both parameter and local variable tables are null
      if ( tupe.y.param_table == null && tupe.y.local_table == null  ){
        if ( temp.field_table != null  ){
          if( temp.field_table.containsKey(l_name) ) {
            l_name = field_access(temp, l_name);
          }else{
            l_name = mother_field_access(temp, l_name, global_counter);
          }
        }else{
          l_name = mother_field_access(temp, l_name, global_counter);
        }
      }

      //Only parameter table is null. 
      if ( tupe.y.param_table == null && tupe.y.local_table != null  ){
        if ( !tupe.y.local_table.containsKey(l_name)  ){
          if ( temp.field_table != null  ){
            if( temp.field_table.containsKey(l_name) ) {
              l_name = field_access(temp, l_name);
            }else{
              l_name = mother_field_access(temp, l_name, global_counter);
            }
          }else{
            l_name = mother_field_access(temp, l_name, global_counter);
          }
        }
      }

      //Only local table is null. 
      if ( tupe.y.param_table != null && tupe.y.local_table == null  ){
        if ( !tupe.y.param_table.containsKey(l_name)  ){
          if ( temp.field_table != null  ){
            if( temp.field_table.containsKey(l_name) ) {
              l_name = field_access(temp, l_name);
            }else{
              l_name = mother_field_access(temp, l_name, global_counter);
            }
          }else{
            l_name = mother_field_access(temp, l_name, global_counter);
          }
        }
      }

      //Both parameter and local tables have at least one variable.
      if ( tupe.y.param_table != null && tupe.y.local_table != null  ){
        if ( !tupe.y.param_table.containsKey(l_name)  ){
          if ( !tupe.y.local_table.containsKey(l_name) ){
            if ( temp.field_table != null  ){
              if( temp.field_table.containsKey(l_name) ) {
                l_name = field_access(temp, l_name);
              }else{
                l_name = mother_field_access(temp, l_name, global_counter);
              }
            }else{
              l_name = mother_field_access(temp, l_name, global_counter);
            }
          }
        }
      }
      this.not_load = false;
    
      n.f1.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String index = n.f2.accept(this, argu); //Accessing the index.

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);

      this.in_assign = true;
      this.give_type = false;
      String r_expr = n.f5.accept(this, argu);
      n.f6.accept(this, argu);

      
      String temps = global_increment();

      //Loading the address of array
      if (l_Type == "int[]"){//Int arrays use i32*.
        if(!l_name.startsWith("%")){
          ll.write("\t"+temps+" = load i32*, i32** %"+l_name+"\n");
        }else{
          ll.write("\t"+temps+" = load i32*, i32** "+l_name+"\n");
        }
      }else{ //Boolean arrays use i8*.
        if(!l_name.startsWith("%")){
          ll.write("\t"+temps+" = load i8*, i8** %"+l_name+"\n");
        }else{
          ll.write("\t"+temps+" = load i8*, i8** "+l_name+"\n");
        }
      }

      String temps1 = global_increment();

      //Loading the size of the array (first integer of the array)
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{ 

        //In boolean arrays we require a bitcast since the array is in i8* format.
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        String temps11 = global_increment();
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      String temps2 = global_increment();
      ll.write("\t"+temps2+" = icmp sge i32 "+index+ ", 0\n"); //Checking that the index is greater than zero

      String temps3 = global_increment();
      ll.write("\t"+temps3+" = icmp slt i32 "+index+ ", "+temps1+"\n"); //Checking that the index is less than the size of the array

      String temps4 = global_increment();
      ll.write("\t"+temps4+" = and i1 "+temps2+ ", "+temps3+"\n"); //Both of these conditions must hold

      label_counter++;
      String l1 = String.valueOf(label_counter);
      String label1 = "%oob_ok_";
      label1 = label1 + l1;

      String label2 = "%oob_err_";
      label2 = label2 + l1;
      ll.write("\tbr i1 "+temps4+", label "+label1+", label "+label2+"\n \n");//Checking the value of the condition and moving to the right label.

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      ll.write("\tcall void @throw_oob()\n"); //Throwing out of bounds exception
      ll.write("\tbr label "+label1+"\n \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n"); //All ok, we can safely index the array now

      String temps5 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps5+" = add i32 1, "+index+"\n"); //Adding one to the index, since the first element holds the size
      }else{
        ll.write("\t"+temps5+" = add i32 4, "+index+"\n"); //In boolean arrays we add 4 since we have an i8* array the first element holds 4 bytes.
      }  

      String temps6 = global_increment();
      if(l_Type == "int[]"){ //Getting pointer to the i + 1 element of the array
        ll.write("\t"+temps6+" = getelementptr i32, i32* "+temps+", i32 "+temps5+"\n");
        ll.write("\tstore i32 "+r_expr+", i32* "+temps6+"\n \n");
      }else{ //In boolean arrays we also use the zext command to convert an i1 element to i8 format.
        ll.write("\t"+temps6+" = getelementptr i8, i8* "+temps+", i32 "+temps5+"\n");

        String zext = global_increment();
        ll.write("\t"+zext+" = zext i1 "+r_expr+" to i8 \n");
        ll.write("\tstore i8 "+zext+", i8* "+temps6+"\n \n");
      }
      ll.write("\n");

      return _ret;

    }


    /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    * f5 -> "else"
    * f6 -> Statement()
    */
    public String visit(IfStatement n, String argu) throws Exception {
      String _ret=null;

      n.f0.accept(this, argu);
      n.f1.accept(this, argu);

      //Creating the labels we need.
      label_counter++;
      String l1 = String.valueOf(label_counter);
      String label1 = "%if_then_";
      label1 = label1 + l1;

      String label2 = "%if_else_" + l1;
      String label3 = "%if_end_" + l1;

      this.give_type = false;
      this.in_assign = true;
      String cond = n.f2.accept(this, argu); //Getting the value of the condition expression.

      ll.write("\tbr i1 "+cond+", label "+label1+", label "+label2+" \n");
      
      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n"); //The 'false' label.
      
      n.f6.accept(this, argu);

      ll.write("\tbr label "+label3+"\n");
      
      //n.f3.accept(this, argu);

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n"); //The 'true' label.
      
      n.f4.accept(this, argu);

      ll.write("\tbr label "+label3+"\n");

      //n.f5.accept(this, argu);

      label3 = label3.replace("%","");
      ll.write("\t"+label3+": \n"); //Label for the post-if statements.

      ll.write("\n");
      
      return _ret;
   }

    /**
    * f0 -> "while"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
    public String visit(WhileStatement n, String argu) throws Exception {
      String _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);

      //Creating the labels we need.

      label_counter++;
      String l1 = String.valueOf(label_counter);
      String label1 = "%loop" + l1;

      label_counter++;
      String l2 = String.valueOf(label_counter);
      String label2 = "%loop" + l2;

      label_counter++;
      String l3 = String.valueOf(label_counter);
      String label3 = "%loop" + l3;

      ll.write("\tbr label "+label1+"\n"); //Jump at the starting label.

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");

      this.give_type = false;
      this.in_assign = true;
      String cond = n.f2.accept(this, argu);//Getting the value of the condition expression.

      ll.write("\tbr i1 "+cond+", label "+label2+", label "+label3+" \n");
      
      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n"); //Label if the condition is true.

      //n.f3.accept(this, argu);

      n.f4.accept(this, argu);

      ll.write("\tbr label %"+label1+"\n");//Jump back at the starting label.

      label3 = label3.replace("%","");
      ll.write("\t"+label3+": \n");//Label if the condition is false.

      ll.write("\n");

      return _ret;
   }

    /**
    * f0 -> "System.out.println"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> ";"
    */
    public String visit(PrintStatement n, String argu) throws Exception {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        
        this.give_type = false;
        this.in_assign = true;
        String print_arg = n.f2.accept(this, argu); //Getting the value of the argument expression.
        
        ll.write("\tcall void (i32) @print_int(i32 "+print_arg+")\n");
        ll.write("\n");

        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
     }

    /**
    * f0 -> Clause()
    * f1 -> "&&"
    * f2 -> Clause()
    */
    public String visit(AndExpression n, String argu) throws Exception {
      String _ret=null;

      //Creating the labels we need.

      label_counter++;
      String l1 = String.valueOf(label_counter);
      String label1 = "%and_clause" + l1;

      label_counter++;
      String l2 = String.valueOf(label_counter); 
      String label2 = "%and_clause" + l2;

      label_counter++;
      String l3 = String.valueOf(label_counter); 
      String label3 = "%and_clause" + l3;

      label_counter++;
      String l4 = String.valueOf(label_counter);
      String label4 = "%and_clause" + l4;

      this.give_type = false;
      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);

      //Check result, short circuit if false
      ll.write("\tbr i1 "+L_expr+", label "+label2+", label "+label1+" \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");
      ll.write("\tbr label "+label4+"\n");
  
      //n.f1.accept(this, argu);

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);

      ll.write("\tbr label "+label3+"\n");

      label3 = label3.replace("%","");
      ll.write("\t"+label3+": \n");
      ll.write("\tbr label "+label4+"\n");

      label4 = label4.replace("%","");
      ll.write("\t"+label4+": \n");
      
      String temps2 = global_increment();

      //Getting apporopriate value, depending on the predecesor block with the use of the phi command.
      ll.write("\t"+temps2+" = phi i1 [ 0, %"+label1+" ], [ "+R_expr+", %"+label3+"] \n");

      ll.write("\n");
      
      return temps2;
   }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "<"
    * f2 -> PrimaryExpression()
    */
    public String visit(CompareExpression n, String argu) throws Exception {
      String _ret=null;

      this.give_type = false;
      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu); //Getting the value of the left expression.
  
      n.f1.accept(this, argu);
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu); //Getting the value of the right expression.
  
      String temps2 = global_increment();
  
      ll.write("\t"+temps2+" = icmp slt i32 "+L_expr+", "+R_expr+"\n"); //Using icmp slt command.
      ll.write("\n");
      return temps2;
   }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
    public String visit(PlusExpression n, String argu) throws Exception {
      String _ret=null;

      this.give_type = false;
      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);//Getting the value of the left expression.
  
      n.f1.accept(this, argu);
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);//Getting the value of the right expression.
  
      String temps2 = global_increment();
  
      ll.write("\t"+temps2+" = add i32 "+L_expr+", "+R_expr+"\n");//Using the add command.
      ll.write("\n");
      return temps2;
   }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
    public String visit(MinusExpression n, String argu) throws Exception {
      String _ret=null;

      this.give_type = false;
      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);//Getting the value of the left expression.
  
      n.f1.accept(this, argu);
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);//Getting the value of the right expression.
  
      String temps2 = global_increment();
  
      ll.write("\t"+temps2+" = sub i32 "+L_expr+", "+R_expr+"\n");//Use of sub command.
      ll.write("\n");
      return temps2;
   }



    /**
    * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
   public String visit(TimesExpression n, String argu) throws Exception {
    String _ret=null;

    this.give_type = false;
    this.in_assign = true;
    String L_expr = n.f0.accept(this, argu);//Getting the value of the left expression.

    n.f1.accept(this, argu);

    this.give_type = false;
    this.in_assign = true;
    String R_expr = n.f2.accept(this, argu);//Getting the value of the right expression.

    String temps2 = global_increment();

    ll.write("\t"+temps2+" = mul i32 "+L_expr+", "+R_expr+"\n");//Use of mult command.
    ll.write("\n");
    return temps2;
 }


    /**
    * f0 -> PrimaryExpression()
    * f1 -> "["
    * f2 -> PrimaryExpression()
    * f3 -> "]"
    */
    public String visit(ArrayLookup n, String argu) throws Exception {
      String _ret=null;

      String item_ret = null;

      //Getting the array type and its output format.
      this.give_type = true;
      this.in_assign = false;
      String l_Type = n.f0.accept(this, argu);

      //Getting the name of the identifier.
      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String index = n.f2.accept(this, argu);//Accessing the index.
      n.f3.accept(this, argu);

      
      String temps1 = global_increment();
      
      //Loading the size of the array (first integer of the array)
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{

        //In boolean arrays we require a bitcast since the array is in i8* format.
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        String temps11 = global_increment();
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      String temps2 = global_increment();
      ll.write("\t"+temps2+" = icmp sge i32 "+index+ ", 0\n");//Checking that the index is greater than zero

      String temps3 = global_increment();
      ll.write("\t"+temps3+" = icmp slt i32 "+index+ ", "+temps1+"\n");//Checking that the index is less than the size of the array

      String temps4 = global_increment();
      ll.write("\t"+temps4+" = and i1 "+temps2+ ", "+temps3+"\n");//Both of these conditions must hold

      label_counter++;
      String l1 = String.valueOf(label_counter);
      String label1 = "%oob_ok_";
      label1 = label1 + l1;

      String label2 = "%oob_err_";
      label2 = label2 + l1;
      ll.write("\tbr i1 "+temps4+", label "+label1+", label "+label2+"\n \n");//Checking the value of the condition and moving to the right label.

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      ll.write("\tcall void @throw_oob()\n"); //Throwing an out of bounds exception.
      ll.write("\tbr label "+label1+"\n \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");//All ok, we can safely index the array now

      String temps5 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps5+" = add i32 1, "+index+"\n"); //Adding one to the index, since the first element holds the size
      }else{
        ll.write("\t"+temps5+" = add i32 4, "+index+"\n"); //In boolean arrays we add 4 since we have an i8* array the first element holds 4 bytes.
      }

      String temps6 = global_increment();
      if(l_Type == "int[]"){ //Getting pointer to the i + 1 element of the array
        ll.write("\t"+temps6+" = getelementptr i32, i32* "+temps+", i32 "+temps5+"\n");
      }else{
        ll.write("\t"+temps6+" = getelementptr i8, i8* "+temps+", i32 "+temps5+"\n");
      }

      String temps7 = global_increment();
      if(l_Type == "int[]"){ //Finally loading the value of the cell.
        ll.write("\t"+temps7+" = load i32, i32* "+temps6+"\n");
      }else{
        ll.write("\t"+temps7+" = load i8, i8* "+temps6+"\n");
        String trunc = global_increment();
        ll.write("\t"+trunc+"= trunc i8 "+temps7+" to i1 \n"); //In boolean arrays we also use trunc in order to convert an i8 element to i1 format.
        temps7 = trunc;
      }
      ll.write("\n");
      return temps7;
   }


    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
    public String visit(ArrayLength n, String argu) throws Exception {
      String _ret=null;

      //Getting the array type and its output format.
      this.give_type = true;
      this.in_assign = false;
      String l_Type = n.f0.accept(this, argu);
      
      //Getting the name of the identifier.
      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);
      n.f2.accept(this, argu);

      String temps1 = global_increment();
      
      //Loading the size of the array (first integer of the array)
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{

        //In boolean arrays we require a bitcast since the array is in i8* format.
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        String temps11 = global_increment();
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }
      ll.write("\n");
      return temps1;
   }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( ExpressionList() )?
    * f5 -> ")"
    */
    public String visit(MessageSend n, String argu) throws Exception {
      String _ret=null;

      //Getting the type of the calling object.
      this.give_type = true;
      this.in_assign = false;
      String obj_type = n.f0.accept(this, argu);
      
      //Every MessageSend returns a temp variable containing its value. However if this variable is used a calling object we will have to get its type with the hold_type field.
      if (obj_type.contains("%")){ 
        obj_type = hold_type;
      }

      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);
    
      this.give_type = false;
      this.in_assign = false; 
      String meth_name = n.f2.accept(this, argu); //Getting the name of the function.

      ClassTable temp = visitor_sym.classId_table.get(obj_type);
      
      Tuple<String, MethodTable> tupe;

      //Getting the correct <String, MethodTable> tuple we need.
      if (temp.v_table != null ){

        if(temp.v_table.containsKey(meth_name)){
          tupe = temp.methodId_table.get(meth_name);
        }else{
          String new_mother = visitor_sym.vtable_search(obj_type,meth_name);
          ClassTable mother_table = visitor_sym.get(new_mother);
          tupe = mother_table.methodId_table.get(meth_name);
        }

      }else{
        String new_mother = visitor_sym.vtable_search(obj_type,meth_name);
        ClassTable mother_table = visitor_sym.get(new_mother);
        tupe = mother_table.methodId_table.get(meth_name);
      }

      int offset; //The offset in this case is the position of the method in the v-table.
      if(temp.v_table==null){

        String new_mother = visitor_sym.vtable_search(obj_type,meth_name); 
        ClassTable mother_table = visitor_sym.get(new_mother);
        
        offset = mother_table.v_table.get(meth_name);
      }else if(!temp.v_table.containsKey(meth_name)){
        String new_mother = visitor_sym.vtable_search(obj_type,meth_name); 
        ClassTable mother_table = visitor_sym.get(new_mother);
        
        offset = mother_table.v_table.get(meth_name);
      }else{
        offset = temp.v_table.get(meth_name);
      }

      global_counter = global_counter + 3;
      String temps1 = global_increment(); //Doing the required bitcasts, so that we can access the vtable pointer
      ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i8*** \n");
      
      String temps2 = global_increment();//Loading the vtable_ptr
      ll.write("\t"+temps2+" = load i8**, i8*** "+temps1+" \n"); 
      
      String temps3 = global_increment(); //Getting a pointer to the 'offset' entry in the vtable.
      ll.write("\t"+temps3+" = getelementptr i8*, i8** "+temps2+", i32 "+offset+" \n");
      
      String temps4 = global_increment();// Get the actual function pointer.
      ll.write("\t"+temps4+" = load i8*, i8** "+temps3+" \n");
      
      String output_type = get_type(tupe.x);//Getting the return type of the function.
      String temps5 = global_increment();//Casting the function pointer from i8* to a function ptr type that matches its signature.
      ll.write("\t"+temps5+" = bitcast i8* "+temps4+" to "+output_type+" (i8* ");


      if (tupe.y.param_table != null ){
    
        for (String i : tupe.y.param_table.keySet()) {

          //Printing the output type of each parameter.
          String curr_Type = tupe.y.param_table.get(i);
          String output_type_arg = get_type(curr_Type);

          ll.write(", ");
          ll.write(output_type_arg);
        }
      }

      ll.write(")* \n"); //Ending the bitcast call here.

      
      if (tupe.y.param_table != null){ //The following Queue will hold the value of each expression which is used as a parameter.
      
        Queue<String> paramQueue = new LinkedList<>();
        
        if ( q_Stack == null ){
          q_Stack = new Stack();  
        }

        q_Stack.push(paramQueue); //We add each Queue to a Stack because a MessageSend can be used as a parameter itself.
        
      }

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);

      String temps6 = global_increment();//Performing the call
      ll.write("\t"+temps6+" = call "+output_type+ " "+ temps5+"( i8* "+temps);

      
      if (tupe.y.param_table != null ){

        Queue<String> paramQueue = (Queue<String>) q_Stack.pop(); //Getting the Queue with the parameters.
        for (String i : tupe.y.param_table.keySet()) {

          //Printing the output type of each parameter.
          String curr_Type = tupe.y.param_table.get(i);
          String output_type_arg = get_type(curr_Type);

          ll.write(", ");
          ll.write(output_type_arg+" ");

          String val = paramQueue.remove(); 
          ll.write(val); //Printing the value of the parameter.
        }
      }

      ll.write(") \n");//Ending the call.
      ll.write("\n");

      this.hold_type = tupe.x; //Holding the type of the MessageSend in case it is used a calling object later on.

      return temps6;

   }

    /**
    * f0 -> Expression()
    * f1 -> ExpressionTail()
    */
    public String visit(ExpressionList n, String argu) throws Exception {
      String _ret=null;

      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);//Getting the value of the expression.

      Queue<String> paramQueue = (Queue<String>) q_Stack.pop();
      paramQueue.add(temps); //Adding it to the parameter Queue.
      q_Stack.push(paramQueue);//Adding the Queue back to the Stack.
      
      n.f1.accept(this, argu);
      return _ret;
   }

   /**
    * f0 -> ( ExpressionTerm() )*
    */
   public String visit(ExpressionTail n, String argu) throws Exception {
      return n.f0.accept(this, argu);
   }

   /**
    * f0 -> ","
    * f1 -> Expression()
    */
   public String visit(ExpressionTerm n, String argu) throws Exception {
      String  _ret=null;

      n.f0.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String temps = n.f1.accept(this, argu);//Getting the value of the expression.

      Queue<String> paramQueue = (Queue<String>) q_Stack.pop();
      paramQueue.add(temps);//Adding it to the parameter Queue.
      q_Stack.push(paramQueue);//Adding the Queue back to the Stack.
      
      return _ret;
   }



    /**
    * f0 -> "true"
    */
    public String visit(TrueLiteral n, String argu) throws Exception {
      n.f0.accept(this, argu);
      return "1";
    }

    /**
    * f0 -> "false"
    */
    public String visit(FalseLiteral n, String argu) throws Exception {
      n.f0.accept(this, argu);
      return "0";
    } 
    
    /**
    * f0 -> "this"
    */
    public String visit(ThisExpression n, String argu) throws Exception {

      if(give_type == true){ //Returning the type of the cuurent object.
        return this.curr_class;
      }else{ //Returning a temp variable of 'this'.
        return "%this";
      }

    }


    //Custom function used to get the field we need.
    public String field_access(ClassTable temp, String id ){

      String Type = null;
      int offset = 0; 

      //Getting its output type and its offset.
      Type = temp.field_table.get(id);
      String output_type = get_type(Type);
      offset = temp.ot_table.get(id);
      String s_offset = String.valueOf(offset);

      String temps = global_increment();
      
      try{ //Getting a pointer of the field we need using the offset.
        ll.write("\t"+temps+" = getelementptr i8, i8* %this, i32 "+s_offset+"\n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }

      String temps1 = global_increment();

      try{ //Perform the necessary bitcast.
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to "+output_type+"* \n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }

      if (not_load != true){ //If not_load is false we also get the value of the field.
        
        String temps2 = global_increment();

        try{
          ll.write("\t"+temps2+" = load "+output_type+", "+output_type+"* "+temps1+"\n");
        }catch (IOException e) {
          System.out.println("An error occurred.");
          e.printStackTrace();
        }

        
        return temps2;
      } 

      return temps1;

    }

    //Recursively searching the hierarchy to get the field.
    public String mother_field_access(ClassTable temp, String id, int global_counter ){
      
      if (temp.mother != null ){

        ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
        String reg = mother_t.field_lookup(id, visitor_sym.classId_table, this, ll, not_load ); 

        return reg;
        
      }
      return null;
    }

    //Loading a local variable.
    public String local_access(String Type, String id ){

      
      String output_type = get_type(Type);
      
      String temps = global_increment();
      
      try{
        ll.write("\t"+temps+" = load "+output_type+", "+output_type+"* %"+id+"\n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }


      return temps;

    }


      /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Identifier n, String argu) throws Exception {


        ClassTable temp = null;
        Tuple<String, MethodTable> tupe = null;
        String id = null;
        int offset = 0;
        String comb = null;
        String Type = null;

        if (in_assign == true){ //Getting the value of the identifier in a temp variable.
          temp = visitor_sym.classId_table.get(curr_class);
          tupe = temp.methodId_table.get(curr_meth);
  
          id = n.f0.accept(this, argu);

          //The general idea for every if statement is as follows: 
          //First we check if the variable is in the local or parameter table of the method we're in. 
          //If not we check the field table of the class we're in. 
          //If not we also check the field table of the first mother we find (if the class is in hierarchy).

          //Both parameter and local variable tables are null
          if ( tupe.y.param_table == null && tupe.y.local_table == null  ){
            if ( temp.field_table != null  ){
              if( temp.field_table.containsKey(id) ) {
                in_assign = false;
                return field_access(temp, id);
              }else{
                in_assign = false;
                return mother_field_access(temp, id, global_counter);
              }
            }else{
              in_assign = false;
              return mother_field_access(temp, id, global_counter);
            }
          }
  
          //Only parameter table is null. 
          if ( tupe.y.param_table == null && tupe.y.local_table != null  ){
            if ( tupe.y.local_table.containsKey(id)  ){
              Type = tupe.y.local_table.get(id);
              in_assign = false;
              return local_access(Type, id);
            }else{
              if ( temp.field_table != null  ){
                if( temp.field_table.containsKey(id) ) {
                  in_assign = false;
                  return field_access(temp, id);
                }else{
                  in_assign = false;
                  return mother_field_access(temp, id, global_counter);
                }
              }else{
                in_assign = false;
                return mother_field_access(temp, id, global_counter);
              }
            }
          }
  
          //Only local table is null. 
          if ( tupe.y.param_table != null && tupe.y.local_table == null  ){
            if ( tupe.y.param_table.containsKey(id)  ){
              Type = tupe.y.param_table.get(id);
              in_assign = false;
              return local_access(Type, id);
            }else{
              if ( temp.field_table != null  ){
                if( temp.field_table.containsKey(id) ) {
                  in_assign = false;
                  return field_access(temp, id);
                }else{
                  in_assign = false;
                  return mother_field_access(temp, id, global_counter);
                }
              }else{
                in_assign = false;
                return mother_field_access(temp, id, global_counter);
              }
            }
          }
  
          //Both parameter and local tables have at least one variable.
          if ( tupe.y.param_table != null && tupe.y.local_table != null  ){
            if ( tupe.y.param_table.containsKey(id)  ){
              Type = tupe.y.param_table.get(id);
              in_assign = false;
              return local_access(Type, id);
            }else if ( tupe.y.local_table.containsKey(id) ){
              Type = tupe.y.local_table.get(id);
              in_assign = false;
              return local_access(Type, id);
            }else{
              if ( temp.field_table != null  ){
                if( temp.field_table.containsKey(id) ) {
                  in_assign = false;
                  return field_access(temp, id);
                }else{
                  in_assign = false;
                  return mother_field_access(temp, id, global_counter);
                }
              }else{
                in_assign = false;
                return mother_field_access(temp, id, global_counter);
              }
            }
          }
          
        }


        if (give_type == true){ //Returning the Type if the identifier.
        
          //Getting the tables we need.
          temp = visitor_sym.classId_table.get(curr_class);
          tupe = temp.methodId_table.get(curr_meth);
  
          id = n.f0.accept(this, argu);
  
          Type = null;
  
          //The general idea for every if statement is as follows: 
          //First we check if the variable is in the local or parameter table of the method we're in. 
          //If not we check the field table of the class we're in. 
          //If not we also check the field table of the first mother we find (if the class is in hierarchy).
      
          //Both parameter and local variable tables are null
          if ( tupe.y.param_table == null && tupe.y.local_table == null  ){
            if ( temp.field_table != null  ){
              if( temp.field_table.containsKey(id) ) {
                Type = temp.field_table.get(id);
                return Type;
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  return Type;
                }
              }
            }else{
              if (temp.mother != null ){
                ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                Type = mother_t.recurse_lookup(id, visitor_sym.classId_table);
                return Type;
              }
            }
          }
  
          //Only parameter table is null. 
          if ( tupe.y.param_table == null && tupe.y.local_table != null  ){
            if ( tupe.y.local_table.containsKey(id)  ){
              Type = tupe.y.local_table.get(id);
              return Type;
            }else{
              if ( temp.field_table != null  ){
                if( temp.field_table.containsKey(id) ) {
                  Type = temp.field_table.get(id);
                  return Type;
                }else{
                  if (temp.mother != null ){
                    ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                    Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                    return Type;
                  }
                }
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  return Type;
                }
              }
            }
          }
  
          //Only local table is null. 
          if ( tupe.y.param_table != null && tupe.y.local_table == null  ){
            if ( tupe.y.param_table.containsKey(id)  ){
              Type = tupe.y.param_table.get(id);
              return Type;
            }else{
              if ( temp.field_table != null  ){
                if( temp.field_table.containsKey(id) ) {
                  Type = temp.field_table.get(id);
                  return Type;
                }else{
                  if (temp.mother != null ){
                    ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                    Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                    return Type;
                  }
                }
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  return Type;
                }
              }
            }
          }
  
          //Both parameter and local tables have at least one variable.
          if ( tupe.y.param_table != null && tupe.y.local_table != null  ){
            if ( tupe.y.param_table.containsKey(id)  ){
              Type = tupe.y.param_table.get(id);
              return Type;
            }else if ( tupe.y.local_table.containsKey(id) ){
              Type = tupe.y.local_table.get(id);
              return Type;
            }else{
              if ( temp.field_table != null  ){
                if( temp.field_table.containsKey(id) ) {
                  Type = temp.field_table.get(id);
                  return Type;
                }else{
                  if (temp.mother != null ){
                    ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                    Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                    return Type;
                  } 
                }
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  return Type;
                }
              }
            }
          }
  
          return Type;
  
        }else{ //In this case we return the name of the identifier.
          id = n.f0.accept(this, argu);
          return id;
        }
  
    }

 
    /* f0 -> "new"
    * f1 -> "boolean"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
   public String visit(BooleanArrayAllocationExpression n, String argu) throws Exception {
    String _ret=null;
    n.f0.accept(this, argu);
    n.f1.accept(this, argu);
    n.f2.accept(this, argu);

    this.give_type = false;
    this.in_assign = true;
    String index = n.f3.accept(this, argu);//Getting the value of the index expression.

    n.f4.accept(this, argu);

    String temps = global_increment();

    //Calculate size bytes to be allocated for the array. We need an additional int worth of space, to store the size of the array.
    ll.write("\t"+temps+" = add i32 1, "+index+"\n");

    String temps1 = global_increment();

    label_counter++;
    String l1 = String.valueOf(label_counter);
    String label1 = "%nsz_ok_";
    label1 = label1 + l1;

    String label2 = "%nsz_err_";
    label2 = label2 + l1;

    //Check that the size of the array is not negative. Since we added 1, we just check that the size is >= 1.
    ll.write("\t"+temps1+" = icmp sge i32 "+temps+", 1\n");
    ll.write("\tbr i1 "+temps1+", label "+label1+", label "+label2+"\n \n");

    label2 = label2.replace("%","");
    ll.write("\t"+label2+": \n");
    ll.write("\tcall void @throw_nsz()\n");//Size was negative, throw negative size exception
    ll.write("\tbr label "+label1+"\n \n");

    label1 = label1.replace("%","");
    ll.write("\t"+label1+": \n");//All ok, we can proceed with the allocation

    String temps2 = global_increment();

    //Adding 4 to the index since the size contains 4 bytes.
    ll.write("\t"+temps2+" = add i32 4, "+index+"\n");

    String temps3 = global_increment();

    //Allocate a space of size+4.
    ll.write("\t"+temps3+" = call i8* @calloc(i32 1, i32 "+temps2+") \n");

    String temps4 = global_increment();

    ll.write("\t"+temps4+" = bitcast i8* "+temps3+" to i32* \n");//Cast the returned pointer
    ll.write("\tstore i32 "+index+", i32* "+temps4+" \n");//Store the size of the array in the first position of the array

    String temps5 = global_increment();

    ll.write("\t"+temps5+" = bitcast i32* "+temps4+" to i8* \n");//Bitcast the first position since the array is in i8* format.
    ll.write("\n");
    return temps5;
 }


   /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
    public String visit(IntegerArrayAllocationExpression n, String argu) throws Exception {
      String _ret=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String index = n.f3.accept(this, argu);//Getting the value of the index expression.

      n.f4.accept(this, argu);

      String temps = global_increment();

      //Calculate size bytes to be allocated for the array. We need an additional int worth of space, to store the size of the array.
      ll.write("\t"+temps+" = add i32 1, "+index+"\n");

      String temps1 = global_increment();

      label_counter++;
      String l1 = String.valueOf(label_counter);
      String label1 = "%nsz_ok_";
      label1 = label1 + l1;

      String label2 = "%nsz_err_";
      label2 = label2 + l1;

      //Check that the size of the array is not negative. Since we added 1, we just check that the size is >= 1.
      ll.write("\t"+temps1+" = icmp sge i32 "+temps+", 1\n");
      ll.write("\tbr i1 "+temps1+", label "+label1+", label "+label2+"\n \n");

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      ll.write("\tcall void @throw_nsz()\n"); //Size was negative, throw negative size exception
      ll.write("\tbr label "+label1+"\n \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");//All ok, we can proceed with the allocation

      String temps2 = global_increment();

      //Allocate sz + 1 integers (4 bytes each)
      ll.write("\t"+temps2+" = call i8* @calloc(i32 "+temps+", i32 4) \n");

      String temps3 = global_increment();

      ll.write("\t"+temps3+" = bitcast i8* "+temps2+" to i32* \n");//Cast the returned pointer
      ll.write("\tstore i32 "+index+", i32* "+temps3+"\n \n");//Store the size of the array in the first position of the array
      ll.write("\n");
      return temps3;
   }


    /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
   public String visit(AllocationExpression n, String argu) throws Exception {
    String _ret=null;
    n.f0.accept(this, argu);

    if(give_type == true){

      this.in_assign = false;
      this.give_type = false;
      String id = n.f1.accept(this, argu);  
      return id;

    }else{
    
      this.in_assign = false;
      this.give_type = false;
      String id = n.f1.accept(this, argu);

      ClassTable temp = visitor_sym.classId_table.get(id);
      int size = temp.size; //Getting the size of the object.

      String temps = global_increment();

      //First, we allocate the required memory on heap for our object with the use of calloc.
      //The first argument is the amount of objects we want to allocate (always 1 for object allocation, but this is handy when we will look at arrays)
      //The second argument is the size of the object. This is calculated as the sum of the size of the fields of the class and all the super classes PLUS 8 bytes, to account for the vtable pointer.

      ll.write("\t"+temps+" = call i8* @calloc(i32 1, i32 "+size+")\n");

      String temps1 = global_increment();

      //Next we need to set the vtable pointer to point to the correct vtable. First we bitcast the object pointer from i8* to i8***
      ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i8*** \n");

      String temps2 = global_increment();

      int v_table_size = 0;
      if(temp.v_table == null){ //Getting the last position with the "find_v_table" function, since we're in hierarchy and the current v-table is null.
          v_table_size = visitor_sym.find_v_table(id);
          v_table_size++;
      }else{ //Getting the size of the v-table using the last position.
          v_table_size = temp.get_last_v();
          v_table_size++;
      }

      //Getting the address of the first element of the Base_vtable
      ll.write("\t"+temps2+" = getelementptr ["+v_table_size+" x i8*], ["+v_table_size+" x i8*]* @."+id+"_vtable, i32 0, i32 0 \n");

      //Setting the vtable to the correct address.
      ll.write("\tstore i8** "+temps2+", i8*** "+temps1+"\n");

      n.f2.accept(this, argu);
      n.f3.accept(this, argu);

      ll.write("\n");
      return temps;
    }

 }


    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) throws Exception {
        String id = n.f0.accept(this, argu);
        return id;
    }

    /**
    * f0 -> "!"
    * f1 -> Clause()
    */
    public String visit(NotExpression n, String argu) throws Exception {
      String _ret=null;
      n.f0.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String reg = n.f1.accept(this, argu);

      String temps = global_increment();

      ll.write("\t"+temps+" = xor i1 1, "+reg+"\n"); //Using xor to achieve the 'not' function.
      ll.write("\n");
      return temps;
    }
    
    /**
    * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
    public String visit(BracketExpression n, String argu) throws Exception {
      String _ret=null;
      n.f0.accept(this, argu);
      
      this.give_type = false;
      this.in_assign = true;
      String reg = n.f1.accept(this, argu); //Getting the value of the expression.
      n.f2.accept(this, argu);
      
      return reg;
   }


    /**
    * f0 -> "int"
    * f1 -> "["
    * f2 -> "]"
    */
    public String visit(IntegerArrayType n, String argu) throws Exception {
      //R _ret=null;

      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);

      return "int[]";
   }


   /**
    * f0 -> "boolean"
    * f1 -> "["
    * f2 -> "]"
    */
    public String visit(BooleanArrayType n, String argu) throws Exception {
     //R _ret=null;

     n.f0.accept(this, argu);
     n.f1.accept(this, argu);
     n.f2.accept(this, argu);

     return "boolean[]";

   }


 public String visit(NodeToken n, String argu) throws Exception { return n.toString(); }

}
