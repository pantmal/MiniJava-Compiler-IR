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
          System.out.println("anyting");
          return_type = "i32*";
        }

        return return_type;
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
    String id = n.f11.accept(this, argu);

    ll.write("define i32 @main() {\n");

    n.f12.accept(this, argu);
    n.f13.accept(this, argu);
    n.f14.accept(this, argu);
    n.f15.accept(this, argu);
    n.f16.accept(this, argu);
    n.f17.accept(this, argu);
    
    ll.write("\tret i32 0\n");
    ll.write("}\n");
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
        String class_name = n.f1.accept(this, argu);
        this.curr_class = class_name;

        n.f2.accept(this, argu);
        
        this.give_type = false;
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

        
        String Type = n.f0.accept(this, argu);
        System.out.println(Type);
        String output_type = get_type(Type);

        this.give_type = false;
        String id = n.f1.accept(this, argu);
        
        if (temp.field_table != null){
          if (!temp.field_table.containsKey(id)){
            ll.write("\t%"+id+" = alloca "+output_type+"\n");
            //ll.write("\tstore "+output_type+" 0,"+output_type+"* %"+id+"\n");
          }
        }else{
          ll.write("\t%"+id+" = alloca "+output_type+"\n");
          //ll.write("\tstore "+output_type+" 0,"+output_type+"* %"+id+"\n");
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

        String ret_type = n.f1.accept(this, argu);

        //Setting the scope of the current method we're on.
        this.give_type = false;
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

      
      String Type = n.f0.accept(this, argu);
      String output_type = get_type(Type);

      //this.in_assign = true;
      String id = n.f1.accept(this, argu);

      ll.write(output_type+" %."+id);
      //i32 %.x

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
    String l_Type = n.f0.accept(this, argu);

    this.give_type = false;
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
    /*global_counter++;
    String s = String.valueOf(global_counter);//Now it will return "10"  
    String temps = "%_";
    temps = temps+s;*/

    String output_type = get_type(l_Type);
    //ll.write("\t"+temps+" = load "+output_type+", "+output_type+"* %"+l_name);

  
    n.f1.accept(this, argu);

    //Getting the right type.
    this.in_assign = true;
    String r_val = n.f2.accept(this, argu);

    if(l_name.startsWith("%")){
      ll.write("\tstore "+output_type+" "+r_val+","+output_type+"* "+l_name+"\n");
    }else{
      ll.write("\tstore "+output_type+" "+r_val+","+output_type+"* %"+l_name+"\n");
    }

    
    
    n.f3.accept(this, argu);
    this.give_type = false;

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
      String index = n.f2.accept(this, argu);

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      String r_expr = n.f5.accept(this, argu);
      n.f6.accept(this, argu);

      global_counter++;
      String s = String.valueOf(global_counter);//Now it will return "10"  
      String temps = "%_";  
      temps = temps+s;

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

      global_counter++;
      String s1 = String.valueOf(global_counter);//Now it will return "10"  
      String temps1 = "%_";  
      temps1 = temps1+s1;

      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        global_counter++;
        String s11 = String.valueOf(global_counter);//Now it will return "10"  
        String temps11 = "%_";  
        temps11 = temps11+s11;
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      global_counter++;
      String s2 = String.valueOf(global_counter);//Now it will return "10"  
      String temps2 = "%_";  
      temps2 = temps2+s2;
      ll.write("\t"+temps2+" = icmp sge i32 "+index+ ", 0\n");

      global_counter++;
      String s3 = String.valueOf(global_counter);//Now it will return "10"  
      String temps3 = "%_";  
      temps3 = temps3+s3;
      ll.write("\t"+temps3+" = icmp slt i32 "+index+ ", "+temps1+"\n"); 

      global_counter++;
      String s4 = String.valueOf(global_counter);//Now it will return "10"  
      String temps4 = "%_";  
      temps4 = temps4+s4;
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

      global_counter++;
      String s5 = String.valueOf(global_counter);//Now it will return "10"  
      String temps5 = "%_";  
      temps5 = temps5+s5;
      if(l_Type == "int[]"){
        ll.write("\t"+temps5+" = add i32 1, "+index+"\n"); 
      }else{
        ll.write("\t"+temps5+" = add i32 4, "+index+"\n"); 
      }  

      global_counter++;
      String s6 = String.valueOf(global_counter);//Now it will return "10"  
      String temps6 = "%_";  
      temps6 = temps6+s6;
      if(l_Type == "int[]"){
        ll.write("\t"+temps6+" = getelementptr i32, i32* "+temps+", i32 "+temps5+"\n");
        ll.write("\tstore i32 "+r_expr+", i32* "+temps6+"\n \n");
      }else{
        ll.write("\t"+temps6+" = getelementptr i8, i8* "+temps+", i32 "+temps5+"\n");

        String zext = "%z";  
        ll.write("\t"+zext+" = zext i1 "+r_expr+" to i8 \n");
        ll.write("\tstore i8 "+zext+", i8* "+temps6+"\n \n");
      }

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
        String print_arg = n.f2.accept(this, argu);
        

        ll.write("\tcall void (i32) @print_int(i32 "+print_arg+")\n");
        

        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
     }

     //AND EXPRESSION

           /**
    * f0 -> PrimaryExpression()
    * f1 -> "<"
    * f2 -> PrimaryExpression()
    */
    public String visit(CompareExpression n, String argu) throws Exception {
      String _ret=null;
      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);
  
      n.f1.accept(this, argu);
  
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);
  
      global_counter++;
      String s2 = String.valueOf(global_counter);//Now it will return "10"  
      String temps2 = "%_";
      temps2 = temps2+s2;
  
      ll.write("\t"+temps2+" = icmp slt i32 "+L_expr+", "+R_expr+"\n");
    
      return temps2;
   }

           /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
    public String visit(PlusExpression n, String argu) throws Exception {
      String _ret=null;

      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);
  
      n.f1.accept(this, argu);
  
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);
  
      global_counter++;
      String s2 = String.valueOf(global_counter);//Now it will return "10"  
      String temps2 = "%_";
      temps2 = temps2+s2;
  
      ll.write("\t"+temps2+" = add i32 "+L_expr+", "+R_expr+"\n");
    
      return temps2;
   }

           /**
    * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
    public String visit(MinusExpression n, String argu) throws Exception {
      String _ret=null;

      this.in_assign = true;
      String L_expr = n.f0.accept(this, argu);
  
      n.f1.accept(this, argu);
  
      this.in_assign = true;
      String R_expr = n.f2.accept(this, argu);
  
      global_counter++;
      String s2 = String.valueOf(global_counter);//Now it will return "10"  
      String temps2 = "%_";
      temps2 = temps2+s2;
  
      ll.write("\t"+temps2+" = sub i32 "+L_expr+", "+R_expr+"\n");
  
      return temps2;
   }



        /**
    * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
   public String visit(TimesExpression n, String argu) throws Exception {
    String _ret=null;

    this.in_assign = true;
    String L_expr = n.f0.accept(this, argu);

    n.f1.accept(this, argu);

    this.in_assign = true;
    String R_expr = n.f2.accept(this, argu);

    global_counter++;
    String s2 = String.valueOf(global_counter);//Now it will return "10"  
    String temps2 = "%_";
    temps2 = temps2+s2;

    ll.write("\t"+temps2+" = mul i32 "+L_expr+", "+R_expr+"\n");

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

      //this.give_type = false;
      //this.not_load = true;
      this.give_type = false;
      this.in_assign = true;
      String temps = n.f0.accept(this, argu);

      n.f1.accept(this, argu);
      String index = n.f2.accept(this, argu);
      n.f3.accept(this, argu);

      /*global_counter++;
      String s = String.valueOf(global_counter);//Now it will return "10"  
      String temps = "%_";  
      temps = temps+s;*/

      //ll.write("\t"+temps+" = load i32*, i32** "+l_name+"\n");

      global_counter++;
      String s1 = String.valueOf(global_counter);//Now it will return "10"  
      String temps1 = "%_";  
      temps1 = temps1+s1;
      
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        global_counter++;
        String s11 = String.valueOf(global_counter);//Now it will return "10"  
        String temps11 = "%_";  
        temps11 = temps11+s11;
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      global_counter++;
      String s2 = String.valueOf(global_counter);//Now it will return "10"  
      String temps2 = "%_";  
      temps2 = temps2+s2;
      ll.write("\t"+temps2+" = icmp sge i32 "+index+ ", 0\n");

      global_counter++;
      String s3 = String.valueOf(global_counter);//Now it will return "10"  
      String temps3 = "%_";  
      temps3 = temps3+s3;
      ll.write("\t"+temps3+" = icmp slt i32 "+index+ ", "+temps1+"\n"); 

      global_counter++;
      String s4 = String.valueOf(global_counter);//Now it will return "10"  
      String temps4 = "%_";  
      temps4 = temps4+s4;
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

      global_counter++;
      String s5 = String.valueOf(global_counter);//Now it will return "10"  
      String temps5 = "%_";  
      temps5 = temps5+s5;
      if(l_Type == "int[]"){
        ll.write("\t"+temps5+" = add i32 1, "+index+"\n"); 
      }else{
        ll.write("\t"+temps5+" = add i32 4, "+index+"\n"); 
      }

      global_counter++;
      String s6 = String.valueOf(global_counter);//Now it will return "10"  
      String temps6 = "%_";  
      temps6 = temps6+s6;
      if(l_Type == "int[]"){
        ll.write("\t"+temps6+" = getelementptr i32, i32* "+temps+", i32 "+temps5+"\n");
      }else{
        ll.write("\t"+temps6+" = getelementptr i8, i8* "+temps+", i32 "+temps5+"\n");
      }

      global_counter++;
      String s7 = String.valueOf(global_counter);//Now it will return "10"  
      String temps7 = "%_";  
      temps7 = temps7+s7;
      if(l_Type == "int[]"){
        ll.write("\t"+temps7+" = load i32, i32* "+temps6+"\n");
      }else{
        ll.write("\t"+temps7+" = load i8, i8* "+temps6+"\n");
        String trunc = "%trunc";
        ll.write("\t"+trunc+"= trunc i8 "+temps7+" to i1 \n");
        temps7 = trunc;
      }

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

      global_counter++;
      String s1 = String.valueOf(global_counter);//Now it will return "10"  
      String temps1 = "%_";  
      temps1 = temps1+s1;
      
      if (l_Type == "int[]"){
        ll.write("\t"+temps1+" = load i32, i32* "+temps+"\n");
      }else{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i32* \n");

        global_counter++;
        String s11 = String.valueOf(global_counter);//Now it will return "10"  
        String temps11 = "%_";  
        temps11 = temps11+s11;
        ll.write("\t"+temps11+" = load i32, i32* "+temps1+"\n");
        temps1 = temps11;
      }

      return temps1;
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
      n.f0.accept(this, argu);
      return "%this";
    }


    public String field_access(ClassTable temp, String id ){

      String Type = null;
      int offset = 0; 

      Type = temp.field_table.get(id);
      String output_type = get_type(Type);
      offset = temp.ot_table.get(id);
      String s_offset = String.valueOf(offset);//Now it will return "10"  

      global_counter++;
      String s = String.valueOf(global_counter);//Now it will return "10"  
      String temps = "%_";
      temps = temps+s;
      
      try{
        ll.write("\t"+temps+" = getelementptr i8, i8* %this, "+output_type+" "+s_offset+"\n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }

      global_counter++;
      String s1 = String.valueOf(global_counter);//Now it will return "10"  
      String temps1 = "%_";
      temps1 = temps1+s1;

      try{
        ll.write("\t"+temps1+" = bitcast i8* "+temps+" to "+output_type+"* \n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }

      if (not_load != true){
        global_counter++;
        String s2 = String.valueOf(global_counter);//Now it will return "10"  
        String temps2 = "%_";
        temps2 = temps2+s2;

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
        ClassTable mother_t = visitor_sym.classId_table.get(temp.mother);
        String reg = mother_t.field_lookup(id, visitor_sym.classId_table, global_counter, ll, not_load ); 

        global_counter = global_counter + 5;

        return reg;

        
      }
      return null;
    }


    public String local_access(String Type, String id ){

      
      String output_type = get_type(Type);
      
      global_counter++;
      //System.out.println(global_counter);
      String s = String.valueOf(global_counter);//Now it will return "10"  
      String temps = "%_";
      temps = temps+s;
      
      try{
        ll.write("\t"+temps+" = load "+output_type+", "+output_type+"* %"+id+"\n");
      }catch (IOException e) {
        System.out.println("An error occurred.");
        e.printStackTrace();
      }


      return temps;

    }

    //%_0 = load i32, i32* %x

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
    String index = n.f3.accept(this, argu);

    n.f4.accept(this, argu);

    global_counter++;
    String s = String.valueOf(global_counter);//Now it will return "10"  
    String temps = "%_";
    temps = temps+s;

    ll.write("\t"+temps+" = add i32 1, "+index+"\n");

    global_counter++;
    String s1 = String.valueOf(global_counter);//Now it will return "10"  
    String temps1 = "%_";
    temps1 = temps1+s1;

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

    global_counter++;
    String s2 = String.valueOf(global_counter);//Now it will return "10"  
    String temps2 = "%_";
    temps2 = temps2+s2;

    ll.write("\t"+temps2+" = add i32 4, "+index+"\n");

    global_counter++;
    String s3 = String.valueOf(global_counter);//Now it will return "10"  
    String temps3 = "%_";
    temps3 = temps3+s3;

    ll.write("\t"+temps3+" = call i8* @calloc(i32 1, i32 "+temps2+") \n");

    global_counter++;
    String s4 = String.valueOf(global_counter);//Now it will return "10"  
    String temps4 = "%_";
    temps4 = temps4+s4;

    ll.write("\t"+temps4+" = bitcast i8* "+temps3+" to i32* \n");
    ll.write("\tstore i32 "+index+", i32* "+temps4+" \n");

    global_counter++;
    String s5 = String.valueOf(global_counter);//Now it will return "10"  
    String temps5 = "%_";
    temps5 = temps5+s5;

    ll.write("\t"+temps5+" = bitcast i32* "+temps4+" to i8* \n");

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
      String index = n.f3.accept(this, argu);

      n.f4.accept(this, argu);

      global_counter++;
      String s = String.valueOf(global_counter);//Now it will return "10"  
      String temps = "%_";
      temps = temps+s;

      ll.write("\t"+temps+" = add i32 1, "+index+"\n");

      global_counter++;
      String s1 = String.valueOf(global_counter);//Now it will return "10"  
      String temps1 = "%_";
      temps1 = temps1+s1;

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

      global_counter++;
      String s2 = String.valueOf(global_counter);//Now it will return "10"  
      String temps2 = "%_";
      temps2 = temps2+s2;

      ll.write("\t"+temps2+" = call i8* @calloc(i32 "+temps+", i32 4) \n");

      global_counter++;
      String s3 = String.valueOf(global_counter);//Now it will return "10"  
      String temps3 = "%_";
      temps3 = temps3+s3;

      ll.write("\t"+temps3+" = bitcast i8* "+temps2+" to i32* \n");
      ll.write("\tstore i32 "+index+", i32* "+temps3+"\n \n");

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
    
    this.in_assign = false;
    this.give_type = false;
    String id = n.f1.accept(this, argu);

    ClassTable temp = visitor_sym.classId_table.get(id);
    int size = temp.size;

    global_counter++;
    String s = String.valueOf(global_counter);//Now it will return "10"  
    String temps = "%_";
    temps = temps+s;


    ll.write("\t"+temps+" = call i8* @calloc(i32 1, i32 "+size+")\n");

    global_counter++;
    String s1 = String.valueOf(global_counter);//Now it will return "10"  
    String temps1 = "%_";
    temps1 = temps1+s1;

    ll.write("\t"+temps1+" = bitcast i8* "+temps+" to i8*** \n");

    global_counter++;
    String s2 = String.valueOf(global_counter);//Now it will return "10"  
    String temps2 = "%_";
    temps2 = temps2+s2;

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
    return temps;
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
      String reg = n.f1.accept(this, argu);

      global_counter++;
      String s = String.valueOf(global_counter);//Now it will return "10"  
      String temps = "%_";
      temps = temps+s;


      ll.write(temps+" = xor i1 1, "+reg+"\n");

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