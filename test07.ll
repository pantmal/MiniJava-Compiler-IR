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

	%_14 = getelementptr i8, i8* %this, i32 14
	%_15 = bitcast i8* %_14 to i32* 
	store i32 20,i32* %_15

	%_16 = getelementptr i8, i8* %this, i32 18
	%_17 = bitcast i8* %_16 to i1* 
	%_18 = getelementptr i8, i8* %this, i32 10
	%_19 = bitcast i8* %_18 to i32* 
	%_20 = load i32, i32* %_19
	%_21 = getelementptr i8, i8* %this, i32 14
	%_22 = bitcast i8* %_21 to i32* 
	%_23 = load i32, i32* %_22
	%_24 = icmp slt i32 %_20, %_23

	store i1 %_24,i1* %_17

	ret i32 0
}
 
