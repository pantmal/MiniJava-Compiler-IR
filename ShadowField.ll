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

	%_5 = call i8* @calloc(i32 1, i32 12)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	store i8* %_5,i8** %a

	%_13 = load i8*, i8** %a
	%_17 = bitcast i8* %_13 to i8*** 
	%_18 = load i8**, i8*** %_17 
	%_19 = getelementptr i8*, i8** %_18, i32 0 
	%_20 = load i8*, i8** %_19 
	%_21 = bitcast i8* %_20 to i8* (i8* )* 
	%_22 = call i8* %_21( i8* %_13) 

	store i8* %_22,i8** %a

	%_23 = load i8*, i8** %a
	%_27 = bitcast i8* %_23 to i8*** 
	%_28 = load i8**, i8*** %_27 
	%_29 = getelementptr i8*, i8** %_28, i32 1 
	%_30 = load i8*, i8** %_29 
	%_31 = bitcast i8* %_30 to i32 (i8* )* 
	%_32 = call i32 %_31( i8* %_23) 

	call void (i32) @print_int(i32 %_32)

	ret i32 0
}
 
define i8* @A.foo(i8* %this) {
	%y = alloca i8*

	%_38 = call i8* @calloc(i32 1, i32 12)
	%_39 = bitcast i8* %_38 to i8*** 
	%_40 = getelementptr [2 x i8*], [2 x i8*]* @.A_vtable, i32 0, i32 0 
	store i8** %_40, i8*** %_39

	store i8* %_38,i8** %x

	%_41 = load i8*, i8** %x
	ret i8* %_41
}
 
define i32 @A.get(i8* %this) {
	%_42 = getelementptr i8, i8* %this, i32 8
	%_43 = bitcast i8* %_42 to i32* 
	%_44 = load i32, i32* %_43
	ret i32 %_44
}
 
