@.test99_vtable = global [0 x i8*] [] 
 
@.Test_vtable = global [ 2 x i8*] [  
	i8* bitcast (i32 (i8*)* @Test.start to i8*),
	i8* bitcast (i32 (i8*,i8*)* @Test.next to i8*)
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
	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
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
 
define i32 @Test.start(i8* %this) {
	%_12 = getelementptr i8, i8* %this, i32 8
	%_13 = bitcast i8* %_12 to i8** 
	%_14 = call i8* @calloc(i32 1, i32 20)
	%_15 = bitcast i8* %_14 to i8*** 
	%_16 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0 
	store i8** %_16, i8*** %_15

	store i8* %_14,i8** %_13

	%_17 = getelementptr i8, i8* %this, i32 16
	%_18 = bitcast i8* %_17 to i32* 
	%_19 = getelementptr i8, i8* %this, i32 8
	%_20 = bitcast i8* %_19 to i8** 
	%_21 = load i8*, i8** %_20
	%_25 = bitcast i8* %_21 to i8*** 
	%_26 = load i8**, i8*** %_25 
	%_27 = getelementptr i8*, i8** %_26, i32 1 
	%_28 = load i8*, i8** %_27 
	%_29 = bitcast i8* %_28 to i32 (i8* , i8*)* 
	%_30 = call i32 %_29( i8* %_21, i8* %this) 

	store i32 %_30,i32* %_18

	ret i32 0
}
 
define i32 @Test.next(i8* %this, i8* %.t) {
	%t = alloca i8*
	store i8* %.t, i8** %t
	ret i32 0
}
 
