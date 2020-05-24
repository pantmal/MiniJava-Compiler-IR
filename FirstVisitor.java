import visitor.*;
import syntaxtree.*;
import java.util.*;

//The First Visitor will create the Symbol Table so the LLVM Visitor can create the .ll files.
public class FirstVisitor extends GJDepthFirst<String, String>{
      
    public SymbolTable visitor_sym;
    public List<String> idList;

    
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

      //Initialize the symbol table, if null
      if (this.visitor_sym == null){
            this.visitor_sym = new SymbolTable();
      }

      String main_class = n.f1.accept(this, argu);

      //Add the classId to the table.
      visitor_sym.add_class(main_class);

      n.f2.accept(this, argu);
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      
      String ret_Type = n.f5.accept(this, argu);
      String id = n.f6.accept(this, argu);

      ClassTable current = visitor_sym.get_last();

      //Add the main method.
      current.meth_insert(id, ret_Type);

      n.f7.accept(this, argu);
      n.f8.accept(this, argu);
      n.f9.accept(this, argu);
      n.f10.accept(this, argu);
      
      
      String args = n.f11.accept(this, argu);

      MethodTable curr_meth = current.get_last_meth();

      //Add the arguments to the parameter table
      curr_meth.p_insert(args, "String[]");

      n.f12.accept(this, argu);
      n.f13.accept(this, argu);
      n.f14.accept(this, argu);
      n.f15.accept(this, argu);
      n.f16.accept(this, argu);
      n.f17.accept(this, argu);
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

      //Initialize the symbol table, if null
      if (this.visitor_sym == null){
            this.visitor_sym = new SymbolTable();
      }


      String _ret=null;
      String class_id;

      n.f0.accept(this, argu);
      class_id = n.f1.accept(this, argu);


      //Add the classId to the table.
      visitor_sym.add_class(class_id);

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

      String class_id;

      n.f0.accept(this, argu);
      class_id = n.f1.accept(this, argu);

      //Add the classId to the table.
      visitor_sym.add_class(class_id);

      n.f2.accept(this, argu);

      ClassTable current = visitor_sym.get_last();
      String mother = n.f3.accept(this, argu);
      
      //Add the mother's name to the ClassTable.
      current.mother = mother;

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
      
      String Type, id;

      //Getting the last ClassTable of the Symbol Table.
      ClassTable current = visitor_sym.get_last();

      
      Type = n.f0.accept(this, argu);
      Type = Type.toString();
      
      id = n.f1.accept(this, argu);

      n.f2.accept(this, argu);

      //If both the field and methodId tables are null, add the first field.
      if (current.field_table == null && current.methodId_table == null ){
            current.f_insert(id, Type);     
      }else if(current.methodId_table == null ){ //If the methodId table is null add a new field, if it's not already declared.
      
            current.f_insert(id, Type);     

      }else if(current.methodId_table != null ){ //If the methodId table has at least one entry, we add the variable to the local variables of the last method.

            MethodTable curr_meth = current.get_last_meth();
      
            curr_meth.l_insert(id, Type);                        
      }


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
      
      String ret_Type, id;		

      //Getting the last classId and its ClassTable from the Symbol Table.
      ClassTable current = visitor_sym.get_last();
      String last_class = visitor_sym.get_last_key();

      n.f0.accept(this, argu);
      
      ret_Type = n.f1.accept(this, argu);
      id = n.f2.accept(this, argu);

      //Adding the method.
      current.meth_insert(id, ret_Type);

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      n.f5.accept(this, argu);
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
      n.f8.accept(this, argu);
      n.f9.accept(this, argu);
      n.f10.accept(this, argu);
      n.f11.accept(this, argu);
      n.f12.accept(this, argu);


      return _ret;
   }

   /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
    public String visit(FormalParameter n, String argu) throws Exception {
      String _ret=null;

      String Type, id;		

      //Getting the last ClassTable from the Symbol Table.
      ClassTable current = visitor_sym.get_last();

      //Getting the last methodId from the current ClassTable.
      MethodTable curr_meth = current.get_last_meth();

      Type = n.f0.accept(this, argu);
      id = n.f1.accept(this, argu);

      //Adding the parameter to the parameter table.
      curr_meth.p_insert(id, Type);


      return _ret;
   }


   /**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    */
    public String visit(Type n, String argu) throws Exception {
      return n.f0.accept(this, argu);
   }

   /**
    * f0 -> BooleanArrayType()
    *       | IntegerArrayType()
    */
    public String visit(ArrayType n, String argu) throws Exception {
      return n.f0.accept(this, argu);
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

    //Returning tokens as strings.
    public String visit(NodeToken n, String argu) throws Exception { return n.toString(); }
   
}
