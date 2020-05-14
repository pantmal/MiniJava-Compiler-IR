all: compile

compile:
	java -jar ../jtb132di.jar minijava.jj -te
	java -jar ../javacc5.jar minijava-jtb.jj
	javac Main.java FirstVisitor.java LLVM_Visitor.java SymbolTable.java OffsetTable.java

clean:
	rm -f *.class *~

