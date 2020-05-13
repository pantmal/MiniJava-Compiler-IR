import visitor.*;
import syntaxtree.*;
import java.util.*;
import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;  // Import the IOException class to handle errors


//The Second Visitor will perform type checks in our program.
public class LLVM_Visitor extends GJDepthFirst<String, String>{
      
    public SymbolTable visitor_sym; //The SymbolTable of this Visitor.
    public String curr_class; //Curr_class will get the "scope" of the last class we're on.
    public String curr_meth; //Curr_class will get the "scope" of the last method we're on.
    public Stack counterStack; //counterStack will used to store some counters. Its usage will be explained in the MessageSend visit.
    public boolean give_type; //Give_type will be used in order to get the type of the identifier.
    // Will be set to false in some cases because we may need the name of the identifier and not its type. 

    public FileWriter ll;
    int global_counter;
    int label_counter;
    public boolean in_assign;
    public boolean not_load;
    public Stack q_Stack;
    public String hold_type;
    
    
    //The constructor gets the SymbolTable object. 
    public LLVM_Visitor(SymbolTable st, FileWriter ll_arg){ 
        this.visitor_sym = st;
        this.ll = ll_arg;   

        global_counter = -1;
        label_counter = -1;
    }

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

    public String global_increment(){

      global_counter++;
      String s = String.valueOf(global_counter);//Now it will return "10"  
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
        n.f3.accept(this, argu);
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
        n.f5.accept(this, argu);
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

        ClassTable temp = visitor_sym.classId_table.get(curr_class);

        this.give_type = false;
        this.in_assign = false;
        String Type = n.f0.accept(this, argu);
        String output_type = get_type(Type);

        this.give_type = false;
        this.in_assign = false;
        String id = n.f1.accept(this, argu);
        
        if (temp.field_table != null){
          if (!temp.field_table.containsKey(id)){
            ll.write("\t%"+id+" = alloca "+output_type+"\n");
            ll.write("\n");
          }else{
            ll.write(""); //BS1
          }
        }else{
          ll.write("\t%"+id+" = alloca "+output_type+"\n");
          ll.write("\n");
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


        String output_type = get_type(ret_type);

        ll.write("define "+output_type+" @"+curr_class+"."+curr_meth+"(i8* %this");


        ClassTable temp = visitor_sym.classId_table.get(curr_class);
        Tuple<String, MethodTable> tupe;
        if( temp.methodId_table != null ){ 

          tupe = temp.methodId_table.get(curr_meth);

          if (tupe.y.param_table != null ){
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

          //elenxos an keno
          tupe = temp.methodId_table.get(curr_meth);

          if (tupe.y.param_table != null ){
        
            for (String i : tupe.y.param_table.keySet()) {

              //Getting the type in our current method.
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

        this.in_assign = true;
        this.give_type = false;
        String expr_type = n.f10.accept(this, argu);

        ll.write("\tret "+output_type+" "+expr_type+"\n");
        
        //ret i32 %_5

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

      ll.write(output_type+" %."+id);

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

    //Getting the left type.
    this.give_type = true;
    this.in_assign = false;
    String l_Type = n.f0.accept(this, argu);
    String output_type = get_type(l_Type);

    this.give_type = false;
    this.in_assign = false;
    String l_name = n.f0.accept(this, argu);
    

    ClassTable temp = visitor_sym.classId_table.get(curr_class);
    Tuple<String, MethodTable> tupe = temp.methodId_table.get(curr_meth);

    //Both parameter and local variable tables are null
    this.not_load = true;
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


    global_counter = global_counter + 5;

  
    n.f1.accept(this, argu);

    //Getting the right type.
    this.in_assign = true;
    this.give_type = false;
    String r_val = n.f2.accept(this, argu);

    if(l_name.startsWith("%")){
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

      //Getting the left type.
      this.give_type = true;
      this.in_assign = false;
      String l_Type = n.f0.accept(this, argu);

      this.give_type = false;
      this.in_assign = false;
      String l_name = n.f0.accept(this, argu);
      
      ClassTable temp = visitor_sym.classId_table.get(curr_class);
      Tuple<String, MethodTable> tupe = temp.methodId_table.get(curr_meth);

      //Both parameter and local variable tables are null
      this.not_load = true;
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
      global_counter = global_counter + 5;

      n.f1.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String index = n.f2.accept(this, argu);

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);

      this.in_assign = true;
      this.give_type = false;
      String r_expr = n.f5.accept(this, argu);
      n.f6.accept(this, argu);

      
      String temps = global_increment();

      //leave checks for boolean arrays

      if (l_Type == "int[]"){
        if(!l_name.startsWith("%")){
          ll.write("\t"+temps+" = load i32*, i32** %"+l_name+"\n");
        }else{
          ll.write("\t"+temps+" = load i32*, i32** "+l_name+"\n");
        }
      }else{
        if(!l_name.startsWith("%")){
          ll.write("\t"+temps+" = load i8*, i8** %"+l_name+"\n");
        }else{
          ll.write("\t"+temps+" = load i8*, i8** "+l_name+"\n");
        }
      }

      String temps1 = global_increment();

      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        String temps11 = global_increment();

        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      String temps2 = global_increment();
      ll.write("\t"+temps2+" = icmp sge i32 "+index+ ", 0\n");

      String temps3 = global_increment();
      ll.write("\t"+temps3+" = icmp slt i32 "+index+ ", "+temps1+"\n"); 

      String temps4 = global_increment();
      ll.write("\t"+temps4+" = and i1 "+temps2+ ", "+temps3+"\n"); 

      label_counter++;
      String l1 = String.valueOf(label_counter);//Now it will return "10"  
      String label1 = "%oob_ok_";
      label1 = label1 + l1;

      String label2 = "%oob_err_";
      label2 = label2 + l1;
      ll.write("\tbr i1 "+temps4+", label "+label1+", label "+label2+"\n \n");

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      ll.write("\tcall void @throw_oob()\n");
      ll.write("\tbr label "+label1+"\n \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");

      String temps5 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps5+" = add i32 1, "+index+"\n"); 
      }else{
        ll.write("\t"+temps5+" = add i32 4, "+index+"\n"); 
      }  

      String temps6 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps6+" = getelementptr i32, i32* "+temps+", i32 "+temps5+"\n");
        ll.write("\tstore i32 "+r_expr+", i32* "+temps6+"\n \n");
      }else{
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


      label_counter++;
      String l1 = String.valueOf(label_counter);//Now it will return "10"  
      String label1 = "%if_then_";
      label1 = label1 + l1;

      String label2 = "%if_else_" + l1;
      String label3 = "%if_end_" + l1;

      this.give_type = false;
      this.in_assign = true;
      String cond = n.f2.accept(this, argu);

      ll.write("\tbr i1 "+cond+", label "+label1+", label "+label2+" \n");
      
      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      
      n.f6.accept(this, argu);

      ll.write("\tbr label "+label3+"\n");
      

      //n.f3.accept(this, argu);

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");
      
      n.f4.accept(this, argu);

      ll.write("\tbr label "+label3+"\n");

      //n.f5.accept(this, argu);

      label3 = label3.replace("%","");
      ll.write("\t"+label3+": \n");

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

      label_counter++;
      String l1 = String.valueOf(label_counter);//Now it will return "10"  
      String label1 = "%loop" + l1;

      label_counter++;
      String l2 = String.valueOf(label_counter);//Now it will return "10"  
      String label2 = "%loop" + l2;

      label_counter++;
      String l3 = String.valueOf(label_counter);//Now it will return "10"  
      String label3 = "%loop" + l3;

      ll.write("\tbr label "+label1+"\n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");


      this.give_type = false;
      this.in_assign = true;
      String cond = n.f2.accept(this, argu);

      ll.write("\tbr i1 "+cond+", label "+label2+", label "+label3+" \n");
      
      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");

      //n.f3.accept(this, argu);


      n.f4.accept(this, argu);

      ll.write("\tbr label %"+label1+"\n");

      label3 = label3.replace("%","");
      ll.write("\t"+label3+": \n");

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
        String print_arg = n.f2.accept(this, argu);
        

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

      label_counter++;
      String l1 = String.valueOf(label_counter);//Now it will return "10"  
      String label1 = "%and_clause" + l1;

      label_counter++;
      String l2 = String.valueOf(label_counter);//Now it will return "10"  
      String label2 = "%and_clause" + l2;

      label_counter++;
      String l3 = String.valueOf(label_counter);//Now it will return "10"  
      String label3 = "%and_clause" + l3;

      label_counter++;
      String l4 = String.valueOf(label_counter);//Now it will return "10"  
      String label4 = "%and_clause" + l4;

      this.give_type = false;
      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);

      ll.write("\tbr i1 "+L_expr+", label "+label2+", label "+label1+" \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");
      ll.write("\tbr label "+label3+"\n");
  
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
      String L_expr = n.f0.accept(this, argu);
  
      n.f1.accept(this, argu);
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);
  
      String temps2 = global_increment();
  
      ll.write("\t"+temps2+" = icmp slt i32 "+L_expr+", "+R_expr+"\n");
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
      String L_expr = n.f0.accept(this, argu);
  
      n.f1.accept(this, argu);
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);
  
      String temps2 = global_increment();
  
      ll.write("\t"+temps2+" = add i32 "+L_expr+", "+R_expr+"\n");
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
      String L_expr = n.f0.accept(this, argu);
  
      n.f1.accept(this, argu);
  
      this.give_type = false;
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);
  
      String temps2 = global_increment();
  
      ll.write("\t"+temps2+" = sub i32 "+L_expr+", "+R_expr+"\n");
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
    String L_expr = n.f0.accept(this, argu);

    n.f1.accept(this, argu);

    this.give_type = false;
    this.in_assign = true;
    String R_expr = n.f2.accept(this, argu);

    String temps2 = global_increment();

    ll.write("\t"+temps2+" = mul i32 "+L_expr+", "+R_expr+"\n");
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

      this.give_type = true;
      this.in_assign = false;
      String l_Type = n.f0.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);

      this.give_type = false;
      this.in_assign = true;
      String index = n.f2.accept(this, argu);
      n.f3.accept(this, argu);

      
      String temps1 = global_increment();
      
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        String temps11 = global_increment();
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      String temps2 = global_increment();
      ll.write("\t"+temps2+" = icmp sge i32 "+index+ ", 0\n");

      String temps3 = global_increment();
      ll.write("\t"+temps3+" = icmp slt i32 "+index+ ", "+temps1+"\n"); 

      String temps4 = global_increment();
      ll.write("\t"+temps4+" = and i1 "+temps2+ ", "+temps3+"\n"); 

      label_counter++;
      String l1 = String.valueOf(label_counter);//Now it will return "10"  
      String label1 = "%oob_ok_";
      label1 = label1 + l1;

      String label2 = "%oob_err_";
      label2 = label2 + l1;
      ll.write("\tbr i1 "+temps4+", label "+label1+", label "+label2+"\n \n");

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      ll.write("\tcall void @throw_oob()\n");
      ll.write("\tbr label "+label1+"\n \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");

      String temps5 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps5+" = add i32 1, "+index+"\n"); 
      }else{
        ll.write("\t"+temps5+" = add i32 4, "+index+"\n"); 
      }

      String temps6 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps6+" = getelementptr i32, i32* "+temps+", i32 "+temps5+"\n");
      }else{
        ll.write("\t"+temps6+" = getelementptr i8, i8* "+temps+", i32 "+temps5+"\n");
      }

      String temps7 = global_increment();
      if(l_Type == "int[]"){
        ll.write("\t"+temps7+" = load i32, i32* "+temps6+"\n");
      }else{
        ll.write("\t"+temps7+" = load i8, i8* "+temps6+"\n");
        String trunc = global_increment();
        ll.write("\t"+trunc+"= trunc i8 "+temps7+" to i1 \n");
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

      this.give_type = true;
      this.in_assign = false;
      String l_Type = n.f0.accept(this, argu);
      
      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);
      n.f2.accept(this, argu);

      String temps1 = global_increment();
      
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{
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

      this.give_type = true;
      this.in_assign = false;
      String obj_type = n.f0.accept(this, argu);
      
      if (obj_type.contains("%")){
        obj_type = hold_type;
      }

      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);
    
      this.give_type = false;
      this.in_assign = false; 
      String meth_name = n.f2.accept(this, argu);

      ClassTable temp = visitor_sym.classId_table.get(obj_type);
      
      Tuple<String, MethodTable> tupe;

      if (temp.methodId_table != null ){

        if(temp.methodId_table.containsKey(meth_name)){
          tupe = temp.methodId_table.get(meth_name);
        }else{
          String new_mother = visitor_sym.mother_search(obj_type,meth_name);
          ClassTable mother_table = visitor_sym.get(new_mother);
          tupe = mother_table.methodId_table.get(meth_name);
        }

      }else{
        String new_mother = visitor_sym.mother_search(obj_type,meth_name);
        ClassTable mother_table = visitor_sym.get(new_mother);
        tupe = mother_table.methodId_table.get(meth_name);
      }

      int offset;
      if(temp.v_table==null){

        String new_mother = visitor_sym.mother_search(obj_type,meth_name); 
        ClassTable mother_table = visitor_sym.get(new_mother);
        
        offset = mother_table.v_table.get(meth_name);
      }else if(!temp.v_table.containsKey(meth_name)){
        String new_mother = visitor_sym.mother_search(obj_type,meth_name); 
        ClassTable mother_table = visitor_sym.get(new_mother);
        
        offset = mother_table.v_table.get(meth_name);
      }else{
        offset = temp.v_table.get(meth_name);
      }

      global_counter = global_counter + 3;
      String temps1 = global_increment();
      ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i8*** \n");
      
      String temps2 = global_increment();
      ll.write("\t"+temps2+" = load i8**, i8*** "+temps1+" \n");
      
      String temps3 = global_increment();
      ll.write("\t"+temps3+" = getelementptr i8*, i8** "+temps2+", i32 "+offset+" \n");
      
      String temps4 = global_increment();
      ll.write("\t"+temps4+" = load i8*, i8** "+temps3+" \n");
      
      String output_type = get_type(tupe.x);
      String temps5 = global_increment();
      ll.write("\t"+temps5+" = bitcast i8* "+temps4+" to "+output_type+" (i8* ");


      if (tupe.y.param_table != null ){
    
        for (String i : tupe.y.param_table.keySet()) {

          //Getting the type in our current method.
          String curr_Type = tupe.y.param_table.get(i);
          String output_type_arg = get_type(curr_Type);

          ll.write(", ");
          ll.write(output_type_arg);
        }
      }

      ll.write(")* \n");

      
      if (tupe.y.param_table != null){
      
        Queue<String> paramQueue = new LinkedList<>();
        
        if ( q_Stack == null ){
          q_Stack = new Stack();  
        }

        q_Stack.push(paramQueue);
        

      }

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);

      String temps6 = global_increment();
      ll.write("\t"+temps6+" = call "+output_type+ " "+ temps5+"( i8* "+temps);

      System.out.println(meth_name);

      
      if (tupe.y.param_table != null ){

        Queue<String> paramQueue = (Queue<String>) q_Stack.pop();
        for (String i : tupe.y.param_table.keySet()) {

          //Getting the type in our current method.
          String curr_Type = tupe.y.param_table.get(i);
          String output_type_arg = get_type(curr_Type);

          ll.write(", ");
          ll.write(output_type_arg+" ");

          String val = paramQueue.remove(); 
          ll.write(val);
        }
      }

      ll.write(") \n");
      ll.write("\n");

      this.hold_type = tupe.x;

      return temps6;

      //return _ret;
   }

      /**
    * f0 -> Expression()
    * f1 -> ExpressionTail()
    */
    public String visit(ExpressionList n, String argu) throws Exception {
      String _ret=null;

      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      Queue<String> paramQueue = (Queue<String>) q_Stack.pop();
      paramQueue.add(temps);
      q_Stack.push(paramQueue);
      
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
      String temps = n.f1.accept(this, argu);

      Queue<String> paramQueue = (Queue<String>) q_Stack.pop();
      paramQueue.add(temps);
      q_Stack.push(paramQueue);
      
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

      if(give_type == true){
        return this.curr_class;
      }else{
        return "%this";
      }

      
    }


    public String field_access(ClassTable temp, String id ){

      String Type = null;
      int offset = 0; 

      Type = temp.field_table.get(id);
      String output_type = get_type(Type);
      offset = temp.ot_table.get(id);
      String s_offset = String.valueOf(offset);//Now it will return "10"  

      String temps = global_increment();
      
      try{
        ll.write("\t"+temps+" = getelementptr i8, i8* %this, i32 "+s_offset+"\n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }

      String temps1 = global_increment();

      try{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to "+output_type+"* \n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }

      if (not_load != true){
        
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

    public String mother_field_access(ClassTable temp, String id, int global_counter ){
      
      if (temp.mother != null ){

        global_counter = global_counter + 5; //BS2
        ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
        String reg = mother_t.field_lookup(id, visitor_sym.classId_table, global_counter, ll, not_load ); 

        global_counter = global_counter + 5;//BS2

        return reg;

        
      }
      return null;
    }


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

        if (in_assign == true){
          temp = visitor_sym.classId_table.get(curr_class);
          tupe = temp.methodId_table.get(curr_meth);
  
          id = n.f0.accept(this, argu);

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
                  if (Type == null){
                    throw new Exception("Type error!");    
                  }else{
                    return Type;
                  }
                }
                throw new Exception("Type error!");
              }
            }else{
              if (temp.mother != null ){
                ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                Type = mother_t.recurse_lookup(id, visitor_sym.classId_table);
                if (Type == null){
                  throw new Exception("Type error!");    
                }else{
                  return Type;
                }
              }
              throw new Exception("Type error!");
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
                    if (Type == null){
                      throw new Exception("Type error!");    
                    }else{
                      return Type;
                    }
                  }
                  throw new Exception("Type error!");
                }
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  if (Type == null){
                    throw new Exception("Type error!");    
                  }else{
                    return Type;
                  }
                }
                throw new Exception("Type error!");
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
                    if (Type == null){
                      throw new Exception("Type error!");    
                    }else{
                      return Type;
                    }
                  }
                  throw new Exception("Type error!");
                }
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  if (Type == null){
                    throw new Exception("Type error!");    
                  }else{
                    return Type;
                  }
                }
                throw new Exception("Type error!");
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
                    if (Type == null){
                      throw new Exception("Type error!");    
                    }else{
                      return Type;
                    }
                  }
                  throw new Exception("Type error!");
                }
              }else{
                if (temp.mother != null ){
                  ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
                  Type = mother_t.recurse_lookup(id, visitor_sym.classId_table );
                  if (Type == null){
                    throw new Exception("Type error!");    
                  }else{
                    return Type;
                  }
                }
                throw new Exception("Type error!");
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
    String index = n.f3.accept(this, argu);

    n.f4.accept(this, argu);

    String temps = global_increment();

    ll.write("\t"+temps+" = add i32 1, "+index+"\n");

    String temps1 = global_increment();

    label_counter++;
    String l1 = String.valueOf(label_counter);//Now it will return "10"  
    String label1 = "%nsz_ok_";
    label1 = label1 + l1;

    String label2 = "%nsz_err_";
    label2 = label2 + l1;

    ll.write("\t"+temps1+" = icmp sge i32 "+temps+", 1\n");
    ll.write("\tbr i1 "+temps1+", label "+label1+", label "+label2+"\n \n");

    label2 = label2.replace("%","");
    ll.write("\t"+label2+": \n");
    ll.write("\tcall void @throw_nsz()\n");
    ll.write("\tbr label "+label1+"\n \n");

    label1 = label1.replace("%","");
    ll.write("\t"+label1+": \n");

    String temps2 = global_increment();

    ll.write("\t"+temps2+" = add i32 4, "+index+"\n");

    String temps3 = global_increment();

    ll.write("\t"+temps3+" = call i8* @calloc(i32 1, i32 "+temps2+") \n");

    String temps4 = global_increment();

    ll.write("\t"+temps4+" = bitcast i8* "+temps3+" to i32* \n");
    ll.write("\tstore i32 "+index+", i32* "+temps4+" \n");

    String temps5 = global_increment();

    ll.write("\t"+temps5+" = bitcast i32* "+temps4+" to i8* \n");
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
      String index = n.f3.accept(this, argu);

      n.f4.accept(this, argu);

      String temps = global_increment();

      ll.write("\t"+temps+" = add i32 1, "+index+"\n");

      String temps1 = global_increment();

      label_counter++;
      String l1 = String.valueOf(label_counter);//Now it will return "10"  
      String label1 = "%nsz_ok_";
      label1 = label1 + l1;

      String label2 = "%nsz_err_";
      label2 = label2 + l1;

      ll.write("\t"+temps1+" = icmp sge i32 "+temps+", 1\n");
      ll.write("\tbr i1 "+temps1+", label "+label1+", label "+label2+"\n \n");

      label2 = label2.replace("%","");
      ll.write("\t"+label2+": \n");
      ll.write("\tcall void @throw_nsz()\n");
      ll.write("\tbr label "+label1+"\n \n");

      label1 = label1.replace("%","");
      ll.write("\t"+label1+": \n");

      String temps2 = global_increment();

      ll.write("\t"+temps2+" = call i8* @calloc(i32 "+temps+", i32 4) \n");

      String temps3 = global_increment();

      ll.write("\t"+temps3+" = bitcast i8* "+temps2+" to i32* \n");
      ll.write("\tstore i32 "+index+", i32* "+temps3+"\n \n");
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
      int size = temp.size;

      String temps = global_increment();

      ll.write("\t"+temps+" = call i8* @calloc(i32 1, i32 "+size+")\n");

      String temps1 = global_increment();

      ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i8*** \n");

      String temps2 = global_increment();

      int v_table_size = 0;
      if(temp.v_table == null){
          v_table_size = visitor_sym.find_v_table(id);
          v_table_size++;
      }else{
          v_table_size = temp.get_last_v();
          v_table_size++;
      }


      ll.write("\t"+temps2+" = getelementptr ["+v_table_size+" x i8*], ["+v_table_size+" x i8*]* @."+id+"_vtable, i32 0, i32 0 \n");

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

      ll.write(temps+" = xor i1 1, "+reg+"\n");
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
      String reg = n.f1.accept(this, argu);
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