import java.util.LinkedHashMap;
import java.util.Iterator;
import java.io.FileWriter;
import java.util.*;
import java.io.IOException;  // Import the IOException class to handle errors

//The SymbolTable.java file contains all the necessary structures for the implementation of our Symbol Table.

//The Symbol Table class consists of a LinkedHashMap. Each key is the class id and its key the corresponding Class Table.
public class SymbolTable {


  LinkedHashMap<String, ClassTable> classId_table;

  //recurse_push adds every class in a hierarchy stack.
  public void recurse_push(Stack hierarchy, String id){

    hierarchy.push(id);

    ClassTable current = this.get(id);

    if (current.mother != null ){
      ClassTable mom_table = this.get(current.mother);

      hierarchy.push(current.mother);
  
      if (mom_table.mother != null ){
        recurse_push(hierarchy,mom_table.mother);
      }      
    }


  }

  //Getting the last v-table in a hierarchy.
  public int find_v_table(String id){

    ClassTable current = this.get(id);
    ClassTable mom_table = this.get(current.mother);

    if (current.mother == null && current.v_table == null ){
      return -1;
    }

    if (mom_table.v_table == null){
      return find_v_table(current.mother); 
    }else{
      return mom_table.last_vcount;
    }
  
  }

  //Getting the size of the last class that had a size>8.
  public int find_size(String id){

    ClassTable current = this.get(id);
    ClassTable mom_table = this.get(current.mother);

    if (current.mother == null && current.size == 8 ){
      return 0;
    }

    if (mom_table.size == 8 ){
      return find_size(current.mother); 
    }else{
      return mom_table.size;
    }
  
  }

  //Is_child will search throughout the class hierarchy to see if the "child" argument has f_mother as a mother class.
  public boolean is_child(String f_mother, String child){

    ClassTable current = this.get(child);

    if (current.mother == null){
      return false;
    }else{
      if (current.mother == f_mother){
        return true;
      }else{
        return is_child(f_mother, current.mother);
      }
    }

  }

  //Find_last_type will search throughout the class hierarchy to get the last type of the first mother class that has a field table.
  public String find_last_type(String id){

    ClassTable current = this.get(id);
    ClassTable mom_table = this.get(current.mother);

    if (current.mother == null && current.field_table == null ){
      return null;
    }

    if (mom_table.field_table == null){
      return find_last_type(current.mother); 
    }else{
      return mom_table.last_type;
    }

  }

  //Find_field_table will search throughout the class hierarchy to get the field table offset sum of the first mother class that has a field table.
  public int find_field_table(String id){

    ClassTable current = this.get(id);
    ClassTable mom_table = this.get(current.mother);

    if (current.mother == null && current.field_table == null ){
      return 0;
    }

    if (mom_table.field_table == null){
      return find_field_table(current.mother); 
    }else{
      return mom_table.ot_sum;
    }
  
  }

  //Find_methodId_table will search throughout the class hierarchy to get the methodId table offset sum of the first mother class that has a methodId table.
  public int find_methodId_table(String id){

    ClassTable current = this.get(id);
    ClassTable mom_table = this.get(current.mother);


    if (current.mother == null && current.methodId_table == null ){
      return 0;
    }

    if (mom_table.methodId_table == null){
      return find_methodId_table(current.mother); 
    }else{
      if(mom_table.methodId_table.containsKey("main")){
        return -1;
      }
      return mom_table.mt_sum;
    }
  
  }

  //Mother_search will search throughout the class hierarchy to get the first mother that has the "id" argument.
  public String mother_search(String mother, String id){

    ClassTable current = this.get(mother);

    if (current.mother == null){
      return null;
    }else{
      boolean not_up = false;
      ClassTable new_mother = this.get(current.mother);
      if (new_mother.methodId_table != null){
        if( new_mother.methodId_table.containsKey(id) ){
            return current.mother;
        }else{
            not_up = true;
        }
      }

      if( new_mother.methodId_table == null   ||  not_up == true  ){
        return mother_search(current.mother,id);
      }
    }

    return null;


  }

  //Similar to mother_search but for v-tables.
  public String vtable_search(String mother, String id){

    ClassTable current = this.get(mother);

    if (current.mother == null){
      return null;
    }else{
      boolean not_up = false;
      ClassTable new_mother = this.get(current.mother);
      if (new_mother.v_table != null){
        if( new_mother.v_table.containsKey(id) ){
            return current.mother;
        }else{
            not_up = true;
        }
      }

      if( new_mother.v_table == null   ||  not_up == true  ){
        return vtable_search(current.mother,id);
      }
    }

    return null;


  }

  //Adding a class to the classId table
  public void add_class(String id){
    
    if (classId_table == null){
      classId_table = new LinkedHashMap<String, ClassTable>();
    }
    classId_table.put(id, new ClassTable());
  }

  //Getting the last ClassTable of the classId table
  public ClassTable get_last(){

    String lKeyLast = null ;
    for(String key : classId_table.keySet()){
      lKeyLast = key;
    }

    ClassTable temp = classId_table.get(lKeyLast);

    return temp;

  }

  //Getting the last class id of the classId table
  public String get_last_key(){

    String lKeyLast = null ;
    for(String key : classId_table.keySet()){
      lKeyLast = key;
    }

    return lKeyLast;

  }

  //Getting the ClassTable of the "id" argument.
  public ClassTable get(String id){

    ClassTable temp = classId_table.get(id);
    return temp;
  }

  
}


//The ClassTable will contain all the fields and method names of a class, as well as some additional information.
class ClassTable{

  public String mother; //Mother is the name of the class whom this class extends from. If the class is not a child, this string is null.
  public String last_type; //Last type in the field table. It is used for the creation of the Offset Table.
  public int ot_sum; //ot_sum contains the sum of the offsets from the fields. Its usage will be explained later on. 
  public int mt_sum; //Same thing as ot_sum but for the methods.
  public int size;
  public int last_vcount;
  public List<String> overriden_functions;
  public LinkedHashMap<String, String> field_table ;
  public LinkedHashMap<String, Tuple<String,MethodTable>> methodId_table ;
  public LinkedHashMap<String, Integer> ot_table ;
  public LinkedHashMap<String, Integer> v_table ;


  //Adding an overriden function in said table.
  public void over_insert(String id){

    if (overriden_functions == null){
      overriden_functions = new ArrayList<>();
    }

    overriden_functions.add(id);

  }


  //Getting the last position of this v-table.  
  public int get_last_v(){

    String lKeyLast = null ;
    for(String key : v_table.keySet()){
      lKeyLast = key;
    }

    int size = v_table.get(lKeyLast);

    return size;

  }

  //Adding a field and its offset in the ot_table.
  public void ot_insert(String id, int offset){
    if (ot_table == null){
        ot_table = new LinkedHashMap<String, Integer>();
    }
    ot_table.put(id, offset);
  }

  //Adding a method and its position in the v_table.
  public void vt_insert(String id, int index){
    if (v_table == null){
        v_table = new LinkedHashMap<String, Integer>();
    }
    v_table.put(id, index);
  }
  
  //GetKey function will return the key (of the field table) that corresponds to the "index" argument.
  public String getKey(int index) {

    Iterator<String> itr = field_table.keySet().iterator();
    for (int i = 0; i < index; i++) {
        itr.next();
    }
    return itr.next();
  }

  //Same thing as the previous function, but for the methodId table.
  public String getKey_m(int index) {

    Iterator<String> itr = methodId_table.keySet().iterator();
    for (int i = 0; i < index; i++) {
        itr.next();
    }
    return itr.next();
  }

  //Recurse_lookup will search throughout the class hierarchy to see if the "id" argument exists.
  public String recurse_lookup(String id, LinkedHashMap<String, ClassTable> classId_table ){

    String Type = null;
    if( this.field_table != null  ){
      if( this.field_table.containsKey(id) ) {
        Type = this.field_table.get(id);
        return Type;
      }else{
        if (this.mother != null ){
          ClassTable mother_t = classId_table.get(this.mother);
          Type = mother_t.recurse_lookup(id,classId_table);
          if (Type == null){
            return null;
          }else{
            return Type;
          }
        }
        return null;
      }
    }else{
      if (this.mother != null ){
        ClassTable mother_t = classId_table.get(this.mother);
        Type = mother_t.recurse_lookup(id,classId_table);
        if (Type == null){
          return null;   
        }else{
          return Type;
        }
      }
      return null;
    }

  }

  //Getting the appropriate type in LLVM format.
  public String get_type(String type, LinkedHashMap<String, ClassTable> classId_table){
    String return_type = null;
    if(type == "int" ){
        return_type = "i32";
    }
    if(type == "boolean" ){
        return_type = "i1";
    }
    if(type == "boolean[]" || classId_table.containsKey(type) ){
        return_type = "i8*";
    }
    if(type == "int[]" ){
        return_type = "i32*";
    }

    return return_type;
  }

  //field_lookup will search throughout the class hierarchy to find the "id" argument and print the appropriate commands to access it.
  public String field_lookup(String id, LinkedHashMap<String, ClassTable> classId_table, LLVM_Visitor eval, FileWriter ll, boolean not_load ){


    String Type = null;
    int offset = 0;
    if( this.field_table != null  ){
      if( this.field_table.containsKey(id) ) {

        //Getting its output type and its offset.
        Type = this.field_table.get(id);
        String output_type = get_type(Type, classId_table);
        offset = this.ot_table.get(id);
        String s_offset = String.valueOf(offset);

        eval.global_counter++;
        String s = String.valueOf(eval.global_counter);
        String temps = "%_";
        temps = temps+s;
        
        try { //Getting a pointer of the field we need using the offset.
          ll.write("\t"+temps+" = getelementptr i8, i8* %this, i32 "+s_offset+"\n");
        }catch (IOException e) {
          System.out.println("An error occurred.");
          e.printStackTrace();
        }

        eval.global_counter++;
        String s1 = String.valueOf(eval.global_counter);
        String temps1 = "%_";
        temps1 = temps1+s1;

        try{ //Perform the necessary bitcast.
          ll.write("\t"+temps1+" = bitcast i8* "+temps+" to "+output_type+"* \n");
        }catch (IOException e) {
          System.out.println("An error occurred.");
          e.printStackTrace();
        }

        if (not_load != true){ //If not_load is false we also get the value of the field.
          eval.global_counter++;
          String s2 = String.valueOf(eval.global_counter);
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
        
      }else{ //It's not in this field table, so recursively call the function.
        if (this.mother != null ){
          ClassTable mother_t = classId_table.get(this.mother);
          String reg = mother_t.field_lookup(id,classId_table, eval, ll, not_load);
          return reg;
        }
        return null;
      }
    }else{ //This field table is empty, so recursively call the function.
      if (this.mother != null ){
        ClassTable mother_t = classId_table.get(this.mother);
        String reg = mother_t.field_lookup(id,classId_table, eval, ll, not_load);
        return reg;
      }
      return null;
    }

  }


  //f_insert adds a variable and its type to the field table.
  public void f_insert(String id, String type){
    if (field_table == null){
      field_table = new LinkedHashMap<String, String>();
    }
    field_table.put(id, type);
  }

  //meth_insert adds a variable and its type to the field table. Note that the value of a methodId corresponds to a tuple.
  //The tuple consists of a string which is the method type, and a MethodTable object, where parameters and local variables will be stored. 
  public void meth_insert(String id, String ret_type  ){
    
    if (methodId_table == null){
      methodId_table = new LinkedHashMap<String, Tuple<String,MethodTable>>();
    }
    
    methodId_table.put(id, new Tuple(ret_type,new MethodTable() ) );
    
  }

  //Getting the last MethodTable of the methodId table.
  public MethodTable get_last_meth(){

    String lKeyLast = null ;
    for(String key : methodId_table.keySet()){
      lKeyLast = key;
    }

    Tuple<String, MethodTable> temp = methodId_table.get(lKeyLast);

    return temp.y;
  }


}

//Tuple class is used to store two variables together, it is needed for the methodId table which will be explained later on.
class Tuple<X, Y> { 
  public final X x; 
  public final Y y; 
  public Tuple(X x, Y y) { 
    this.x = x; 
    this.y = y; 
  } 
} 

//The Method Table is used to store the parameters and local variables of a method (if any)
class MethodTable{

  public LinkedHashMap<String, String> param_table ;
  public LinkedHashMap<String, String> local_table ;
  public boolean already_printed;

  //GetKey function will return the key (of the parameter table) that corresponds to the "index" argument.
  public String getKey(int index) {

    Iterator<String> itr = param_table.keySet().iterator();
    for (int i = 0; i < index; i++) {
        itr.next();
    }
    return itr.next();
  }

  //p_insert adds a variable and its type to the parameter table.
  public void p_insert(String id, String type){
    if (param_table == null){
      param_table = new LinkedHashMap<String, String>();
    }

    param_table.put(id, type);
  }

  //l_insert adds a variable and its type to the local variables table.
  public void l_insert(String id, String type){
    
    if (local_table == null){
      local_table = new LinkedHashMap<String, String>();
    }


    local_table.put(id, type);
  }


}

