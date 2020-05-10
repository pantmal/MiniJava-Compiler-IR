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
    
    //The constructor gets the SymbolTable object. 
    public LLVM_Visitor(SymbolTable st, FileWriter ll_arg){ 
        this.visitor_sym = st;
        this.ll = ll_arg;   

        global_counter = -1;
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
        String output_type = get_type(Type);

        this.give_type = false;
        String id = n.f1.accept(this, argu);
        

        if( temp.methodId_table != null ){ 
            ll.write("\t%"+id+" = alloca "+output_type+"\n");
            ll.write("\tstore "+output_type+" 0,"+output_type+"* %"+id+"\n");
            //store i32 10, i32* %x
            //%x = alloca i32
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
        String ret_type = n.f1.accept(this, argu);

        //Setting the scope of the current method we're on.
        this.give_type = false;
        String meth_name = n.f2.accept(this, argu);
        this.curr_meth = meth_name;

        


        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        n.f9.accept(this, argu);

        this.give_type = true;
        String expr_type = n.f10.accept(this, argu);
             


        n.f11.accept(this, argu);
        n.f12.accept(this, argu);

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

    global_counter++;
    String s = String.valueOf(global_counter);//Now it will return "10"  
    
    String temps = "%_";
    temps = temps+s;

    String output_type = get_type(l_Type);
    //ll.write("\t"+temps+" = load "+output_type+", "+output_type+"* %"+l_name);


    //Getting the ClassTable of our current class.
    ClassTable temp = visitor_sym.classId_table.get(curr_class);    
    //Same thing for the method.
    Tuple<String, MethodTable> tupe = temp.methodId_table.get(curr_meth);

  
    n.f1.accept(this, argu);

    //Getting the right type.
    String r_val = n.f2.accept(this, argu);

    ll.write("\tstore "+output_type+" "+r_val+","+output_type+"* %"+l_name+"\n");
    
    n.f3.accept(this, argu);
    this.give_type = false;

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
        

        //WILL CHANGE, MUST ADD STUFF?
        global_counter++;
        String s = String.valueOf(global_counter);//Now it will return "10"  
    
        String temps = "%_";
        temps = temps+s;

        ll.write("\t"+temps+" = load i32, i32* %"+print_arg+"\n");

        ll.write("\tcall void (i32) @print_int(i32 "+temps+")\n");
        

        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
     }

      /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Identifier n, String argu) throws Exception {

        if (give_type == true){ //Returning the Type if the identifier.
        
          //Getting the tables we need.
          ClassTable temp = visitor_sym.classId_table.get(curr_class);
          Tuple<String, MethodTable> tupe = temp.methodId_table.get(curr_meth);
  
          String id = n.f0.accept(this, argu);
  
          String Type = null;
  
          //Taking in account the many cases we have.
  
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
        String id = n.f0.accept(this, argu);
        return id;
      }
  
        
    }

       /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) throws Exception {
        String id = n.f0.accept(this, argu);
        return id;
      }


 public String visit(NodeToken n, String argu) throws Exception { return n.toString(); }

}