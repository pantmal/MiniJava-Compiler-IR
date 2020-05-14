@.ShadowBaseField_vtable = global [0 x i8*] [] 
 
@.A_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @A.getX to i8*)
]
 
@.B_vtable = global [ 1 x i8*] [  
	i8* bitcast (i32 (i8*)* @B.getX to i8*)
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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0 
	store i8** %_2, i8*** %_1

	store i8* %_0,i8** %a

	%_3 = load i8*, i8** %a
	%_7 = bitcast i8* %_3 to i8*** 
	%_8 = load i8**, i8*** %_7 
	%_9 = getelementptr i8*, i8** %_8, i32 0 
	%_10 = load i8*, i8** %_9 
	%_11 = bitcast i8* %_10 to i32 (i8* )* 
	%_12 = call i32 %_11( i8* %_3) 

	call void (i32) @print_int(i32 %_12)

	%_13 = call i8* @calloc(i32 1, i32 16)
	%_14 = bitcast i8* %_13 to i8*** 
	%_15 = getelementptr [1 x i8*], [1 x i8*]* @.B_vtable, i32 0, i32 0 
	store i8** %_15, i8*** %_14

	store i8* %_13,i8** %a

	%_16 = load i8*, i8** %a
	%_20 = bitcast i8* %_16 to i8*** 
	%_21 = load i8**, i8*** %_20 
	%_22 = getelementptr i8*, i8** %_21, i32 0 
	%_23 = load i8*, i8** %_22 
	%_24 = bitcast i8* %_23 to i32 (i8* )* 
	%_25 = call i32 %_24( i8* %_16) 

	call void (i32) @print_int(i32 %_25)

	ret i32 0
}
 
define i32 @A.getX(i8* %this) {
	%_26 = getelementptr i8, i8* %this, i32 8
	%_27 = bitcast i8* %_26 to i32* 
	%_28 = load i32, i32* %_27
	ret i32 %_28
}
 
define i32 @B.getX(i8* %this) {
	%_29 = getelementptr i8, i8* %this, i32 12
	%_30 = bitcast i8* %_29 to i32* 
	store i32 1,i32* %_30

	%_31 = getelementptr i8, i8* %this, i32 12
	%_32 = bitcast i8* %_31 to i32* 
	%_33 = load i32, i32* %_32
	ret i32 %_33
}
 
