@.CallFromSuper_vtable = global [0 x i8*] [] 
 
@.A_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.foo to i8*)
]
 
@.B_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.foo to i8*)
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
	%b = alloca i8*

	%rv = alloca i32

	%_5 = call i8* @calloc(i32 1, i32 0)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [1 x i8*], [1 x i8*]* @.B_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	store i8* %_5,i8** %b

	%_13 = load i8*, i8** %b
	%_17 = bitcast i8* %_13 to i8*** 
	%_18 = load i8**, i8*** %_17 
	%_19 = getelementptr i8*, i8** %_18, i32 0 
	%_20 = load i8*, i8** %_19 
	%_21 = bitcast i8* %_20 to i32 (i8* )* 
	%_22 = call i32 %_21( i8* %_13) 

	store i32 %_22,i32* %rv

	%_23 = load i32, i32* %rv
	call void (i32) @print_int(i32 %_23)

	ret i32 0
}
 
define i32 @A.foo(i8* %this) {
	ret i32 1
}
 
