@.test07_vtable = global [0 x i8*] [] 
 
@.Operator_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @Operator.compute to i8*)
]
 

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32) 
 
@_cint = constant [4 x i8] c"%d\0a\00" 
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00" 
@_cNSZ = constant [15 x i8] c"Negative Size\0a\00" 
 
define void @print_int(i32 %i) { 
	%_str = bitcast [4 x i8]* @_cint to i8* 
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i) 
	ret void 
}
 
define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void 
}
 
define void @throw_nsz() {
	%_str = bitcast [15 x i8]* @_cNSZ to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void 
}
 
define i32 @main() {
	%_0 = call i8* @calloc(i32 1, i32 19)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Operator_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	%_6 = bitcast i8* %_0 to i8*** 
	%_7 = load i8**, i8*** %_6 
	%_8 = getelementptr i8*, i8** %_7, i32 0 
	%_9 = load i8*, i8** %_8 
	%_10 = bitcast i8* %_9 to i32 (i8* )* 
	%_11 = call i32 %_10( i8* %_0) 

	call void (i32) @print_int(i32 %_11)

	ret i32 0
}
 
define i32 @Operator.compute(i8* %this) {
	%_12 = getelementptr i8, i8* %this, i32 10
	%_13 = bitcast i8* %_12 to i32* 
	store i32 10,i32* %_13

	%_19 = getelementptr i8, i8* %this, i32 14
	%_20 = bitcast i8* %_19 to i32* 
	store i32 20,i32* %_20

	%_26 = getelementptr i8, i8* %this, i32 18
	%_27 = bitcast i8* %_26 to i1* 
	%_33 = getelementptr i8, i8* %this, i32 10
	%_34 = bitcast i8* %_33 to i32* 
	%_35 = load i32, i32* %_34
	%_36 = getelementptr i8, i8* %this, i32 14
	%_37 = bitcast i8* %_36 to i32* 
	%_38 = load i32, i32* %_37
	%_39 = icmp slt i32 %_35, %_38

	store i1 %_39,i1* %_27

	ret i32 0
}
 
