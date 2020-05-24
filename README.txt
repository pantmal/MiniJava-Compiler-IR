Ονοματεπώνυμο: Παντελεήμων Μαλέκας
Α.Μ: 1115201600268

Compilation command: make 
Run command: java Main [inputfile1] [inputfile2] ... [inputfileN]

Brief description of the programs: For the third assignment I created two Visitors that extend from the generated GJDepthFirst Visitor, of the generated visitors. The first compilation command uses the -te flag, so all visitors support the use of Exceptions. The First Visitor adds all the necessary symbols in a Symbol Table object. Once the FirstVisitor finishes, the offset table and v-tables are created with the use of the OffsetTable class. This class also prints the V-tables of each class to the .ll file as well as some boilerplate code included in every file.  After that, the LLVM Visitor writes the rest of the necessary LLVM IR commands to the .ll file, using the Symbol Table from the First Visitor.

Here are some details about each .java file.

SymbolTable.java: This file contains all the necessary structures for the implementation of our Symbol Table. The Symbol Table class consists of a LinkedHashMap. Each key is the class id and its key a corresponding Class Table object. The ClassTable class contains all the fields and method names of a class, as well as some additional information. For the fields, a LinkedHashMap is used where each key is the variable name and its key is its type. For the method names a LinkedHashMap is used where each key is the method name and its key is a custom Tuple class, where one part is its type and the other is a MethodTable object, which is used to store the variables of a function. Specifically, a MethodTable is used to store the parameters and local variables of a method (if any), again with the use of LinkedHashMaps. Additional information can be seen at the comments of the program.

FirstVisitor.java: The First Visitor will create the Symbol Table. It add symbols from every declaration so the OffsetTable.java and LLVM_Visitor can write the necessary code to the .ll file.

OffsetTable.java: Offset Table will create the offsets of the Minijava program. For every class in the classId table, we get its Class Table, skipping the Main class since it doesn't have any fields or methods. First we get the field offsets and then we move on to the method offsets, where similar work is performed in each case. This class also prints the V-tables of each class to the .ll file as well as some boilerplate code included in every file. Additional information can be seen at the comments of the program.

LLVM_Visitor.java: The LLVM_Visitor writes the rest of the necessary LLVM IR commands to the .ll file, using the SymbolTable of the First Visitor. In every "declaration" visit the program will update two fields: curr_class and curr_method. They are used so we can know the scope we're on. After that, at every visit function we write the necessary LLVM IR code to the .ll file. Each case is explained in detail at the comments of the LLVM_Visitor.java file.

Main.java: The Main Class adds together our previous programs. After parsing the input program, if the parsing was successful, we move on to the FirstVisitor which will create the Symbol Table. After the First Visitor ends evaluating, the offset table and v-tables are created with the use of the OffsetTable class. This class also prints the V-tables of each class to the .ll file as well as some boilerplate code included in every file. After that, the LLVM Visitor writes the rest of the necessary LLVM IR commands to the .ll file. Each produced .ll file can be compiled with: clang-4.0 -o out1 ex.ll, and executed with: ./out1

Any additional information can be seen at the comments of each program. 
