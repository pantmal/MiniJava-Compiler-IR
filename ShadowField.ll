@.ShadowField_vtable = global [0 x i8*] [] 
 
@.A_vtable = global [ 2 x i8*] [  
	i8* bitcast (i8* (i8*)* @A.foo to i8*),
	i8* bitcast (i32 (i8*)* @A.get to i8*)
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
	%a = alloca i8*
	%_0 = call i8* @calloc(i32 1, i32 12)
	%_1 = bitcast i8* %_0 to i8*** 
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	store i8* %_0,i8** %a

	%_3 = load i8*, i8** %a
	%_7 = bitcast i8* %_3 to i8*** 
	%_8 = load i8**, i8*** %_7 
	%_9 = getelementptr i8*, i8** %_8, i32 0 
	%_10 = load i8*, i8** %_9 
	%_11 = bitcast i8* %_10 to i8* (i8* )* 
	%_12 = call i8* %_11( i8* %_3) 

	store i8* %_12,i8** %a

	%_13 = load i8*, i8** %a
	%_17 = bitcast i8* %_13 to i8*** 
	%_18 = load i8**, i8*** %_17 
	%_19 = getelementptr i8*, i8** %_18, i32 1 
	%_20 = load i8*, i8** %_19 
	%_21 = bitcast i8* %_20 to i32 (i8* )* 
	%_22 = call i32 %_21( i8* %_13) 

	call void (i32) @print_int(i32 %_22)

	ret i32 0
}
 
define i8* @A.foo(i8* %this) {
	%x = alloca i8*
	%b = alloca i32
	%_23 = call i8* @calloc(i32 1, i32 12)
	%_24 = bitcast i8* %_23 to i8*** 
	%_25 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0 
	store i8** %_25, i8*** %_24

	store i8* %_23,i8** %x

	%_26 = load i8*, i8** %x
	ret i8* %_26
}
 
define i32 @A.get(i8* %this) {
	%_27 = getelementptr i8, i8* %this, i32 8
	%_28 = bitcast i8* %_27 to i32* 
	%_29 = load i32, i32* %_28
	ret i32 %_29
}
 
