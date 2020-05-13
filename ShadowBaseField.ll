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

	%_5 = call i8* @calloc(i32 1, i32 12)
	%_6 = bitcast i8* %_5 to i8*** 
	%_7 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0 
	store i8** %_7, i8*** %_6

	store i8* %_5,i8** %a

	%_8 = load i8*, i8** %a
	%_12 = bitcast i8* %_8 to i8*** 
	%_13 = load i8**, i8*** %_12 
	%_14 = getelementptr i8*, i8** %_13, i32 0 
	%_15 = load i8*, i8** %_14 
	%_16 = bitcast i8* %_15 to i32 (i8* )* 
	%_17 = call i32 %_16( i8* %_8) 

	call void (i32) @print_int(i32 %_17)

	%_23 = call i8* @calloc(i32 1, i32 16)
	%_24 = bitcast i8* %_23 to i8*** 
	%_25 = getelementptr [1 x i8*], [1 x i8*]* @.B_vtable, i32 0, i32 0 
	store i8** %_25, i8*** %_24

	store i8* %_23,i8** %a

	%_26 = load i8*, i8** %a
	%_30 = bitcast i8* %_26 to i8*** 
	%_31 = load i8**, i8*** %_30 
	%_32 = getelementptr i8*, i8** %_31, i32 0 
	%_33 = load i8*, i8** %_32 
	%_34 = bitcast i8* %_33 to i32 (i8* )* 
	%_35 = call i32 %_34( i8* %_26) 

	call void (i32) @print_int(i32 %_35)

	ret i32 0
}
 
define i32 @A.getX(i8* %this) {
	%_36 = getelementptr i8, i8* %this, i32 8
	%_37 = bitcast i8* %_36 to i32* 
	%_38 = load i32, i32* %_37
	ret i32 %_38
}
 
define i32 @B.getX(i8* %this) {
	%_39 = getelementptr i8, i8* %this, i32 12
	%_40 = bitcast i8* %_39 to i32* 
	store i32 1,i32* %_40

	%_46 = getelementptr i8, i8* %this, i32 12
	%_47 = bitcast i8* %_46 to i32* 
	%_48 = load i32, i32* %_47
	ret i32 %_48
}
 
